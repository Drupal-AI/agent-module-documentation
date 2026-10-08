<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF — agent index

Renders core `file` fields that hold a PDF with Mozilla **pdf.js**. Adds exactly three
FieldFormatter plugins (`pdf_default`, `pdf_thumbnail`, `pdf_pages`), one theme hook
(`file_pdf`), one permission (`administer pdfjs`), and one config object (`pdf.settings`
with the single key `custom_viewer`). No field type, no widget, no services, no plugin
types, no Drush, no config schema, and **no `configure` key in `pdf.info.yml`**
(`configure: null`) even though a settings form exists.

- **The three formatters — plugin ids, every setting key + default, render output** →
  [plugins/formatters.md](plugins/formatters.md)
- **Settings form, `pdf.settings.custom_viewer`, permission, and assigning a formatter via drush** →
  [configure/settings-and-display.md](configure/settings-and-display.md)
- **`file_pdf` theme hook, the twig template, libraries and drupalSettings** →
  [theming/file-pdf.md](theming/file-pdf.md)

Key facts:

- Formatters apply to `field_types = {"file"}` only, and each item is gated on
  `$item->entity->getMimeType() == 'application/pdf'`; non-PDF items fall back to `file_link`.
- pdf.js is **not shipped**. It must exist at the docroot path `/libraries/pdf.js/`
  (`build/pdf.js`, `build/pdf.worker.js`, `web/viewer.html`) or nothing renders.
- Settings form: `/admin/config/media/pdfjs`, route `pdf.config_form`,
  permission `administer pdfjs`, menu link parent `system.admin_config_media`.
