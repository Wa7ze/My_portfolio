import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'work_data.dart';

class WorkCard extends StatefulWidget {
  final WorkItem item;
  const WorkCard({super.key, required this.item});

  @override
  State<WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<WorkCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translate(0.0, _hover ? -6.0 : 0.0)
          ..scale(_hover ? 1.02 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: _hover
              ? [BoxShadow(blurRadius: 24, spreadRadius: -8, offset: const Offset(0, 14), color: Colors.black.withOpacity(.18))]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(widget.item.imageUrl, fit: BoxFit.cover),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.black.withOpacity(.45),
                  child: Text(widget.item.title,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () => context.push('/work/${widget.item.slug}')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
