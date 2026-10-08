<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Translator — agent index

Embeds Google Translate's client-side Website Translator as a Drupal **block**. No API key,
no stored translations — translation runs in the visitor's browser. All state is one config
object, `google_translator.settings`. Depends on core **Block**.

- **Settings keys, display modes, disclaimer, the config form & permission** →
  [configure/settings.md](configure/settings.md)
- **The block plugin + how the widget/disclaimer are built and attached** →
  [api/block.md](api/block.md)

Key facts:
- Config form route: `google_translator.config` → `/admin/config/regional/google-translator`.
- Permission: `administer google_translator settings` (plus `administer site configuration`).
- Block plugin id: `google_translator` (admin label "Google Translator").
- Config object `google_translator.settings` keys: `google_translator_active_languages_display_mode`
  (`SIMPLE` | `HORIZONTAL` | `VERTICAL`), `google_translator_active_languages` (array of Google
  short codes, e.g. `pt`, `es`), `google_translator_disclaimer_title`, `google_translator_disclaimer`.
