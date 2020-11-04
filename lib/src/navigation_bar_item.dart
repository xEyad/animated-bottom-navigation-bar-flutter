import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/src/bubble_selection_painter.dart';

class NavigationBarItem extends StatelessWidget {
  final bool isActive;
  final double bubbleRadius;
  final double maxBubbleRadius;
  final Color bubbleColor;
  final Color activeColor;
  final Color inactiveColor;
  ///either iconData or imageProvider
  final IconData iconData;
  ///either iconData or imageProvider
  final ImageProvider iconImg;
  final double iconScale;
  final double iconSize;
  final VoidCallback onTap;
  ///this will show under the icon so it should be any class that acts as a text
  final Widget label;
  ///the separating distance between [label] and icon.
  ///useless if [label] is null
  final double labelGap;
  ///distance from the top of the bottom bar
  ///useless if [label] is null
  final double gapFromTop;
  NavigationBarItem({
    this.isActive,
    this.bubbleRadius,
    this.maxBubbleRadius,
    this.bubbleColor,
    this.activeColor,
    this.inactiveColor,
    this.iconData,
    this.iconImg,
    this.iconScale,
    this.iconSize,
    this.onTap,
    this.label,
    this.labelGap,
    this.gapFromTop
  }) : 
  assert(iconData!=null || iconImg!=null),
  super();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // height: double.infinity,
        // width: double.infinity,
        child: CustomPaint(
          painter: BubblePainter(
            bubbleRadius: isActive ? bubbleRadius : 0,
            bubbleColor: bubbleColor,
            maxBubbleRadius: maxBubbleRadius,
          ),
          child: InkWell(
            child: Transform.scale(
              scale: isActive ? iconScale : 1,
              child: _indicator(),
            ),
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  Widget _indicator()
  {
    if(label!=null)
      return _labeledIcon();
    else
      return _icon();
  }

  Widget _labeledIcon()
  {
    return Column(
            children: [
              SizedBox(height: gapFromTop,),
              _icon(),
              SizedBox(height: labelGap,),
              label
            ],
          );
  }

  Widget _icon()
  {
    if(iconData!=null)
    {
      return Icon(
                iconData,
                color: isActive ? activeColor : inactiveColor,
                size: iconSize,
              );
    }
    else
    {
      return Image(
        image: iconImg,
        color: isActive ? activeColor : inactiveColor,
        width: iconSize,
        height: iconSize,        
        fit: BoxFit.contain,
        );
    }
  }
}

class GapItem extends StatelessWidget {
  final double width;

  GapItem({this.width});

  @override
  Widget build(BuildContext context) => Container(width: width);
}
