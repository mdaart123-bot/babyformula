import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/catalog.dart';
import '../models/waste_item.dart';
import '../theme/app_colors.dart';
import '../widgets/mail_helper.dart';
import '../widgets/primary_button.dart';

class RecyclePage extends StatefulWidget {
  const RecyclePage({super.key});

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  final _selected = <String>{};

  List<WasteItem> get _chosen =>
      Catalog.waste.where((item) => _selected.contains(item.id)).toList();

  Future<void> _requestContact() async {
    if (_chosen.isEmpty) return;

    final name = TextEditingController();
    final phone = TextEditingController();
    final note = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final inset = MediaQuery.viewInsetsOf(context).bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + inset),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.moss.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Direct contact only',
                    style: GoogleFonts.lexendDeca(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Waste streams are not sold in the shop. Tell us who you are and we will email the plant team.',
                    style: GoogleFonts.lexendDeca(
                      color: AppColors.moss,
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _chosen
                        .map(
                          (item) => Chip(
                            label: Text(item.title, style: GoogleFonts.lexendDeca(fontSize: 12)),
                            backgroundColor: AppColors.cream,
                            side: BorderSide.none,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(labelText: 'Your name'),
                    validator: (value) =>
                        value == null || value.trim().isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: (value) =>
                        value == null || value.trim().length < 8 ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: note,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Intended use'),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Email the plant',
                    icon: Icons.mail_outline,
                    onPressed: () async {
                      if (!(formKey.currentState?.validate() ?? false)) return;
                      final titles = _chosen.map((item) => item.title).join(', ');
                      final sent = await MailHelper.send(
                        subject: 'Waste enquiry: $titles',
                        body:
                            'Name: ${name.text.trim()}\n'
                            'Phone: ${phone.text.trim()}\n'
                            'Streams: $titles\n'
                            'Use: ${note.text.trim()}',
                      );
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              sent
                                  ? 'Opening your mail app'
                                  : 'Could not open mail. Write ${Catalog.email}',
                            ),
                            backgroundColor: AppColors.forest,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    name.dispose();
    phone.dispose();
    note.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Text(
          'Recycle',
          style: GoogleFonts.lexendDeca(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          'By-products from the formula line. Select the streams you want, then request them by direct contact.',
          style: GoogleFonts.lexendDeca(color: AppColors.moss, fontSize: 14, height: 1.45),
        ),
        const SizedBox(height: 16),
        ...Catalog.waste.map((item) {
          final selected = _selected.contains(item.id);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (selected) {
                    _selected.remove(item.id);
                  } else {
                    _selected.add(item.id);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: selected ? AppColors.cream : AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppColors.softShadow,
                  border: Border.all(
                    color: selected ? AppColors.forest : Colors.transparent,
                    width: 1.4,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: selected ? AppColors.white : AppColors.cream,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(item.icon, color: AppColors.forest, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: GoogleFonts.lexendDeca(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${item.category} · ${item.volume}',
                            style: GoogleFonts.lexendDeca(fontSize: 12, color: AppColors.moss),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.summary,
                            style: GoogleFonts.lexendDeca(fontSize: 13, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                    Checkbox(
                      value: selected,
                      activeColor: AppColors.forest,
                      onChanged: (_) {
                        setState(() {
                          if (selected) {
                            _selected.remove(item.id);
                          } else {
                            _selected.add(item.id);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 8),
        PrimaryButton(
          label: _selected.isEmpty
              ? 'Select a waste type'
              : 'Request ${_selected.length} stream${_selected.length == 1 ? '' : 's'}',
          icon: Icons.handshake_outlined,
          onPressed: _selected.isEmpty ? null : _requestContact,
        ),
      ],
    );
  }
}
