import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/catalog.dart';
import '../theme/app_colors.dart';
import '../widgets/app_card.dart';
import '../widgets/mail_helper.dart';
import '../widgets/primary_button.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _sending = true);
    final sent = await MailHelper.send(
      subject: 'Message from ${_name.text.trim()}',
      body:
          'Name: ${_name.text.trim()}\n'
          'Email: ${_email.text.trim()}\n\n'
          '${_message.text.trim()}',
    );
    if (!mounted) return;
    setState(() => _sending = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          sent
              ? 'Opening your mail app to send to ${Catalog.email}'
              : 'Could not open mail. Write us at ${Catalog.email}',
        ),
        backgroundColor: AppColors.forest,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Text(
          'Contact us',
          style: GoogleFonts.lexendDeca(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          'A short note is enough. The form opens your email app addressed to the Little Leaf team.',
          style: GoogleFonts.lexendDeca(color: AppColors.moss, fontSize: 14, height: 1.45),
        ),
        const SizedBox(height: 16),
        AppCard(
          color: AppColors.forest,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Catalog.email,
                style: GoogleFonts.lexendDeca(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                Catalog.phone,
                style: GoogleFonts.lexendDeca(color: AppColors.cream, fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text(
                'Weekdays 9:00–17:00',
                style: GoogleFonts.lexendDeca(
                  color: AppColors.cream.withValues(alpha: 0.85),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Your email'),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (!text.contains('@') || !text.contains('.')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _message,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(labelText: 'Message'),
                validator: (value) =>
                    value == null || value.trim().length < 8 ? 'Write a short message' : null,
              ),
              const SizedBox(height: 18),
              PrimaryButton(
                label: _sending ? 'Opening mail…' : 'Send email',
                icon: Icons.send_outlined,
                onPressed: _sending ? null : _send,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
