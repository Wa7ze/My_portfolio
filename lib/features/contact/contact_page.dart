import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _msg = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _msg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        Text('Contact', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800))
            .animate()
            .fadeIn(duration: 400.ms)
            .slide(begin: const Offset(0, .06)),
        const SizedBox(height: 16),
        Form(
          key: _form,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: 380,
                child: TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
              ),
              SizedBox(
                width: 380,
                child: TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                ),
              ),
              SizedBox(
                width: 780,
                child: TextFormField(
                  controller: _msg,
                  minLines: 5,
                  maxLines: 8,
                  decoration: const InputDecoration(labelText: 'Message', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.length < 10) ? 'At least 10 characters' : null,
                ),
              ),
              FilledButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message queued (demo)')));
                  }
                },
                child: const Text('Send'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
