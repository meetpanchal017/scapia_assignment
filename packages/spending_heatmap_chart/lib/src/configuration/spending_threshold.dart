class SpendingThreshold {
  // Represents the percentage limit for the spending threshold
  final int percentage;

  // Represents the opacity for visualization
  final double opacity;

  SpendingThreshold({
    required this.percentage,
    required this.opacity,
  })  : assert(percentage > 0 && percentage < 100,
            'Percentage must be between 0 and 100.'),
        assert(
            opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1.');

  // Getter to provide default spending thresholds
  static List<SpendingThreshold> get defaultThreshold {
    return [
      SpendingThreshold(percentage: 5, opacity: 0.1), // Low threshold
      SpendingThreshold(percentage: 10, opacity: 0.3), // Moderate threshold
      SpendingThreshold(percentage: 20, opacity: 0.5), // High threshold
    ];
  }
}
