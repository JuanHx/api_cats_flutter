import 'package:api_cats_app/data/models/breed_model.dart';
import 'package:api_cats_app/data/models/image_cat_model.dart';
import 'package:api_cats_app/presentation/bloc/breed_bloc.dart';
import 'package:api_cats_app/presentation/pages/breds_page.dart';
import 'package:api_cats_app/presentation/widgets/carousel_images.dart';
import 'package:api_cats_app/presentation/widgets/custom_dropdown.dart';
import 'package:api_cats_app/presentation/widgets/divider.dart';
import 'package:api_cats_app/presentation/widgets/generic_footer.dart';
import 'package:api_cats_app/presentation/widgets/generic_loading.dart';
import 'package:api_cats_app/presentation/widgets/title_and_text.dart';
import 'package:api_cats_app/presentation/widgets/underline_link_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BreedDetailPage extends StatefulWidget {
  final List<ImageCatModel> images;
  final BreedModel breed;

  const BreedDetailPage({super.key, required this.breed, required this.images});

  @override
  State<BreedDetailPage> createState() => _BreedDetailPageState();
}

class _BreedDetailPageState extends State<BreedDetailPage> {
  final List<CustomDropdownItem> breedItems = [];

  @override
  void initState() {
    super.initState();
    final bloc = context.read<BreedBloc>();
    breedItems.addAll(
      bloc.state.breeds.map(
        (breed) => CustomDropdownItem(id: breed.id, name: breed.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedBloc, BreedState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const GenericLoading();
        }
        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (result != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BreedsPage()),
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(widget.breed.name),
              backgroundColor: Colors.white,
            ),
            bottomNavigationBar: const GenericFooter(selectedIndex: 1),

            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: CustomDropdown(
                      items: breedItems,
                      initialSelection: widget.breed.id,
                      onChanged: (dynamic value) {
                        final selectedBreed = breedItems.firstWhere(
                          (item) => item.id == value.id,
                        );
                        context.read<BreedBloc>().add(
                          ChangedSelectedBreed(selectedBreed.id),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  CarouseImages(widget: widget),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.breed.name,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomDivider(),
                        const SizedBox(height: 10),
                        TitleAndText(
                          title: 'Life Expectancy: ',
                          text: '${widget.breed.life_span} years',
                        ),
                        CustomDivider(),
                        const SizedBox(height: 10),
                        TitleAndText(
                          title: 'Intelligence: ',
                          text: widget.breed.intelligence.toString(),
                        ),
                        CustomDivider(),
                        const SizedBox(height: 10),
                        TitleAndText(
                          title: 'Origin: ',
                          text: widget.breed.origin!,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.breed.description,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        UnderlinedLinkText(
                          text: 'Learn more on Wikipedia',
                          url: widget.breed.wikipediaUrl!,
                        ),
                        const SizedBox(height: 20),
                        // Otros detalles si los agregas aquí
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
