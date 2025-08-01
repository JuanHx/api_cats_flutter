import 'package:api_cats_app/presentation/bloc/breed_bloc.dart';
import 'package:api_cats_app/presentation/widgets/ButtonImage.dart';
import 'package:api_cats_app/presentation/pages/breds_page.dart';
import 'package:api_cats_app/presentation/pages/random_cat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/generic_loading.dart';
import '../widgets/generic_footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreedBloc, BreedState>(
      listener: (context, state) {
        if (state.breeds.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BreedsPage()),
          );
        }
      },
      child: BlocBuilder<BreedBloc, BreedState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const GenericLoading();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Api Cats App'),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: const Center(child: TriangleButtonLayout()),
            bottomNavigationBar: const GenericFooter(selectedIndex: 0),
          );
        },
      ),
    );
  }
}

class TriangleButtonLayout extends StatefulWidget {
  const TriangleButtonLayout({super.key});

  @override
  State<TriangleButtonLayout> createState() => _TriangleButtonLayoutState();
}

class _TriangleButtonLayoutState extends State<TriangleButtonLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 20,
            child: ButtonImage(
              onPressed: () {
                final bloc = context.read<BreedBloc>();

                if (bloc.hasCachedBreeds && bloc.state.breeds.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BreedsPage()),
                  );
                } else {
                  bloc.add(BreedsFetchEvent());
                }
              },
              imagePath: 'assets/icons/lista.gif',
            ),
          ),
          Positioned(
            right: 20,
            child: ButtonImage(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RandomCatPage(),
                  ),
                );
              },
              imagePath: 'assets/icons/toma-de-decisiones.gif',
            ),
          ),
        ],
      ),
    );
  }
}
