import 'package:flutter/material.dart';

class StateDecorator extends StatefulWidget {
  const StateDecorator({
    Key? key,
    required double xShift,
    required double yShift,
    required stateClipper,
    required this.isSelected,
    required this.onTap,
  })  : xShift = xShift,
        yShift = yShift,
        stateClipper = stateClipper,
        super(key: key);

  final double xShift;
  final double yShift;
  final CustomClipper<Path> stateClipper;
  final bool isSelected; // Added parameter to check if the state is selected
  final Function() onTap;

  @override
  _StateDecoratorState createState() => _StateDecoratorState();
}

class _StateDecoratorState extends State<StateDecorator> {
  var color = const Color.fromARGB(255, 20, 20, 20);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double _xScaling = size.width / 411;
    final double _yScaling = size.height / 823;
    return GestureDetector(
      // onTap: () {
      //   setState(() {
      //     print("Clicked ${widget.xShift} ");
      //     color = const Color.fromARGB(255, 179, 255, 0);
      //   });
      // },
      onTap: widget.onTap,
      child: Transform.translate(
        offset: Offset(_xScaling * widget.xShift, _yScaling * widget.yShift),
        child: ClipPath(
          child: Container(
            height: size.height,
            width: size.width,
            color: widget.isSelected
                ? const Color.fromARGB(255, 179, 255, 0)
                : const Color.fromARGB(255, 20, 20, 20),
          ),
          clipper: widget.stateClipper,
        ),
      ),
    );
  }
}
