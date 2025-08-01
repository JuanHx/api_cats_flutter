import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/breed_bloc.dart';
import '../widgets/generic_footer.dart';
import '../widgets/generic_loading.dart';

class RandomCatPage extends StatefulWidget {
  const RandomCatPage({super.key});

  @override
  State<RandomCatPage> createState() => _RandomCatPageState();
}

class _RandomCatPageState extends State<RandomCatPage> {
  final PageController _pageController = PageController();
  bool _isVoting = false;

  @override
  void initState() {
    super.initState();
    context.read<BreedBloc>().add(GetRandomBreedEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Random Cat'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<BreedBloc, BreedState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const GenericLoading();
          } else if (state is RandomBreedLoaded) {
            return _buildRandomCatCarousel(state);
          }
          return const Center(child: Text('Cargando gatos aleatorios...'));
        },
      ),
      bottomNavigationBar: const GenericFooter(selectedIndex: 2),
    );
  }

  Widget _buildRandomCatCarousel(RandomBreedLoaded state) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            scrollDirection: Axis.horizontal,
            onPageChanged: (page) {
              if (page > 0) {
                context.read<BreedBloc>().add(GetRandomBreedEvent());
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (_pageController.hasClients) {
                    _pageController.jumpToPage(0);
                  }
                });
              }
            },
            itemBuilder: (context, index) {
              if (index > 0) return const SizedBox();
              return _buildCatCard(state);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCatCard(RandomBreedLoaded state) {
    final isImageValid =
        state.imageUrl.trim().isNotEmpty &&
        (state.imageUrl.startsWith('http://') ||
            state.imageUrl.startsWith('https://'));
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 40.0,
        top: 25.0,
      ),
      child: Card(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: isImageValid
                      ? Image.network(
                          state.imageUrl,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            // Mostrar icono de huellita si falla la carga
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.pets,
                                    size: 80,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Imagen no disponible',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pets,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Imagen no disponible',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.breed.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.breed.description,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildVoteButton(
                    context,
                    icon: 'assets/icons/me-gusta.png',
                    color: Colors.red,
                    isLike: false,
                    breedId: state.breed.id,
                  ),
                  _buildVoteButton(
                    context,
                    icon: 'assets/icons/no-me-gusta.png',
                    color: Colors.green,
                    isLike: true,
                    breedId: state.breed.id,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoteButton(
    BuildContext context, {
    required String icon,
    required Color color,
    required bool isLike,
    required String breedId,
  }) {
    return ElevatedButton(
      onPressed: _isVoting
          ? null
          : () {
              setState(() {
                _isVoting = true;
              });
              context.read<BreedBloc>().add(VoteBreedEvent(breedId, isLike));
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  setState(() {
                    _isVoting = false;
                  });
                }
              });
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Row(
        children: [
          ImageIcon(AssetImage(icon), color: Colors.white, size: 24),
          const SizedBox(width: 8),
          Text(
            isLike ? 'Me gusta' : 'No me gusta',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
