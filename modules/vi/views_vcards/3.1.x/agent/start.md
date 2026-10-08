<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views vCards (views_vcards) — agent index

Exports View results as downloadable vCard (`.vcf`) files via three Views plugins. Depends on core
`views` + the `maennchen/zipstream-php` composer library. No admin settings page (`configure` null),
no permissions, no Drush. All configuration is per-View.

- **Build the vCard display, map fields to vCard properties, paths, ZIP vs single, Attach-to,
  theming, access** → [configure/vcard-display.md](configure/vcard-display.md)

Key facts:
- Plugins: display `views_vcard` (extends `PathPluginBase`, `returns_response = TRUE`), style
  `views_vcard_style`, row `views_vcard_fields` (schema `views.row.views_vcard_fields`).
- 1 result row → single `text/vcard` `.vcf`; >1 row → streamed ZIP of `.vcf` files (ZipStream).
- Row option groups: `name_email`, `home`, `work` — each key is set to the machine name of a Views
  field you must also add under *Fields*.
- Access is the View display's own access plugin; the module adds none. Twig debug must be OFF.
