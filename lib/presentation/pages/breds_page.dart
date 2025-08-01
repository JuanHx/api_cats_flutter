import 'package:api_cats_app/data/models/breed_model.dart';
import 'package:api_cats_app/presentation/widgets/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/breed_bloc.dart';
import '../widgets/cat_card.dart';
import 'breed_detail_page.dart';
import '../widgets/generic_loading.dart';
import '../widgets/generic_footer.dart';

class BreedsPage extends StatefulWidget {
  const BreedsPage({super.key});

  @override
  State<BreedsPage> createState() => _BreedsPageState();
}

class _BreedsPageState extends State<BreedsPage> {
  @override
  void initState() {
    super.initState();
    // Verificar si ya hay datos en cache cuando se carga la página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<BreedBloc>();
      if (!bloc.hasCachedBreeds) {
        bloc.add(BreedsFetchEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreedBloc, BreedState>(
      listener: (context, state) {
        if (state.navigateToDetail && state.selectedBreed != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BreedDetailPage(breed: state.selectedBreed!, images: state.images),
            ),
          ).then((_) {
            // 🔄 Resetear el trigger después de navegar
            context.read<BreedBloc>().emit(state.copyWith(navigateToDetail: false));
          });
        }
      },
      builder: (context, state) {
        if (state.isLoading) return const GenericLoading();

        if (state.breeds.isNotEmpty) {
          final breedsList = state.breeds;

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text('Cat Breeds'),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: _buildContent(context, breedsList),
            bottomNavigationBar: const GenericFooter(selectedIndex: 1),
          );
        }

        return const NotFound();
      },
    );
  }

  Widget _buildContent(BuildContext context, List<BreedModel> breedsList) {
    return ListView.builder(
      itemCount: breedsList.length,
      itemBuilder: (context, index) {
        final breed = breedsList[index];
        return CatCard(
          breed: breed,
          onPressed: () {
            context.read<BreedBloc>().add(SelectedBreed(breed));
            context.read<BreedBloc>().add(GetImagesByBreed(breed.id));
          },
        );
      },
    );
  }
}
