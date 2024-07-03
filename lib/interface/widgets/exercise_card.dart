import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final String title;
  final String exerciseType;
  final List<String> muscleGroups;
  final String previewImage;
  final String infoText;
  final bool showSwapAction;
  final bool showInfoAction;
  final bool selected;
  final VoidCallback onTap;

  const ExerciseCard({
    super.key,
    required this.title,
    required this.exerciseType,
    required this.muscleGroups,
    required this.previewImage,
    required this.infoText,
    this.showSwapAction = false,
    this.showInfoAction = true,
    this.selected = false,
    required this.onTap,
  });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool _isSelected = false;
  bool _showInfo = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.selected;
  }

  void _handleTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
    widget.onTap();
  }

  void _toggleInfo() {
    setState(() {
      _showInfo = !_showInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _handleTap,
        child: Card(
          key: Key(_isSelected ? 'exercise-card-selected' : 'exercise-card-default'),
          surfaceTintColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Row(
            children: [
              Column(children: [
                Row(
                  children: [
                    Text(widget.title),
                    if (widget.showInfoAction)
                      IconButton(
                        key: const Key('button-info-exercise'),
                        icon: const Icon(Icons.info),
                        onPressed: _toggleInfo,
                      ),
                  ],
                ),
                Text(widget.exerciseType),
                Wrap(
                  children: widget.muscleGroups
                      .map((muscle) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              label: Text(muscle),
                            ),
                          ))
                      .toList(),
                ),
              ]),
              Column(
                children: [
                  if (widget.showSwapAction)
                    IconButton(
                      key: const Key('button-swap-exercise'),
                      icon: const Icon(Icons.swap_horiz),
                      onPressed: () {
                        // Handle swap action
                      },
                    ),
                ],
              ),
              Image.asset(
                widget.previewImage,
                key: const Key('image-exercise-preview'),
              ),
              if (_showInfo)
                Container(
                  key: const Key('info-view'),
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.infoText),
                ),
            ],
          ),
        ));
  }
}
