<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Markup (drowl_paragraphs_bs_type_markup) — agent index

Sub-module of **drowl_paragraphs_bs**. Installs the `markup` Paragraph type.

- **Field**: `field_markup` (`text_long`, label 'Markup (HTML)'), edited with `text_textarea`, displayed
  with `text_default` (core formatted-text formatter — output filtered by the value's text format).
  `allowed_formats: {}` (no per-field restriction; the text-format system governs which formats an
  editor may pick). The shipped default value uses format `html_raw_token`.
- **Shared field**: `field_settings` (hidden) from the base module.
- `.module`: `hook_preprocess_paragraph__markup()` appends a hidden `empty-check-workaround` span to
  `field_markup` so markup with no visual output still renders.
- No routes, permissions, services or schema of its own. Depends only on `drowl_paragraphs_bs`.

See [paragraphs/markup.md](paragraphs/markup.md).
