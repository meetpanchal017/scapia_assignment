import 'package:flutter/material.dart';

enum SpendingCategory {
  essentials(
    Icons.local_grocery_store,
  ), // Groceries, utilities, healthcare
  diningEntertainment(
    Icons.restaurant,
  ), // Dining out and entertainment expenses
  travel(
    Icons.flight,
  ), // Travel-related expenses
  shopping(
    Icons.shopping_cart,
  ), // Clothing, electronics, and general retail purchases
  subscriptions(
    Icons.subscriptions,
  ), // All subscription services
  healthFitness(
    Icons.fitness_center,
  ), // Gym memberships, fitness classes, health products
  transportation(
    Icons.directions_car,
  ), // Fuel, public transit, ride-sharing
  education(
    Icons.school,
  ), // Tuition, courses, books
  homeUtilities(
    Icons.home,
  ), // Rent, mortgage, bills
  other(
    Icons.more_horiz,
  ); // Miscellaneous expenses, refunds, and loans

  final IconData icon;

  const SpendingCategory(this.icon);
}
