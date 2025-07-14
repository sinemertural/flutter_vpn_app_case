import 'package:flutter/material.dart';
import 'package:vpn_app_case/data/entity/country.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback? onConnectPressed;
  final bool isConnected;
  final VoidCallback? onDisconnectPressed;


  const CountryCard({
    super.key,
    required this.country,
    required this.isExpanded,
    required this.onTap,
    this.onConnectPressed,
    this.onDisconnectPressed,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final secondaryTextColor = textColor.withOpacity(0.7);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: theme.cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    country.flag,
                    width: 40,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          country.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${country.locationCount} locations",
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: country.isFree ? Colors.green : Colors.amber,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!country.isFree)
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                        if (!country.isFree) const SizedBox(width: 4),
                        Text(
                          country.isFree ? "FREE" : "PREMIUM",
                          style: TextStyle(
                            color: country.isFree ? Colors.green : Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: textColor,
                  ),
                ],
              ),
              if (isExpanded && country.isFree && onConnectPressed != null) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: isConnected ? onDisconnectPressed : onConnectPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isConnected ? theme.colorScheme.error : Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                      ),
                      child: Text(
                        isConnected ? "DISCONNECT" : "CONNECT",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
