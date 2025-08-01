import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/breed_bloc.dart';
import '../pages/home_page.dart';
import '../pages/breds_page.dart';
import '../pages/random_cat_page.dart';

class GenericFooter extends StatelessWidget {
  final int selectedIndex;

  const GenericFooter({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: CustomFooter(
          selectedIndex: selectedIndex,
          onTap: (index) {
            if (index == selectedIndex) return;
            
            switch (index) {
              case 0:
                // Navegar a Home
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                break;
              case 1:
                // Navegar a lista de razas
                context.read<BreedBloc>().add(BreedsFetchEvent());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const BreedsPage()),
                );
                break;
              case 2:
                // Navegar a gato aleatorio
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const RandomCatPage()),
                );
                break;
              default:
                break;
            }
          },
        ),
      ),
    );
  }
}

class CustomFooter extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomFooter({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home, 'Home'),
          _buildNavItem(1, Icons.list, 'Breeds'),
          _buildNavItem(2, Icons.shuffle, 'Random'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = index == selectedIndex;
    
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(
          top: isSelected ? 0 : 8.0,
          bottom: isSelected ? 0 : 8.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(isSelected ? 12.0 : 8.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.purple.withOpacity(0.1) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.purple : Colors.grey,
                size: isSelected ? 28 : 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.purple : Colors.grey,
                fontSize: isSelected ? 12 : 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
