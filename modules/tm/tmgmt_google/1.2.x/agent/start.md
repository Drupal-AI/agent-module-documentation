<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Translator (tmgmt_google) — agent index

Adds one TMGMT translator plugin, **`google`**, that machine-translates TMGMT jobs via Google's
Translate API v2. Depends on `tmgmt`. No permissions, no Drush, no plugin types of its own.

- **The `google` translator plugin, its settings, and creating/configuring a translator entity** →
  [configure/translator.md](configure/translator.md)
- **How it calls Google (endpoint, chunking, detect/languages) and the job flow** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Configuration lives on a `tmgmt_translator` config entity (config `tmgmt.translator.<id>`) with
  `plugin: google`. Configure route: `entity.tmgmt_translator.collection`
  (`/admin/tmgmt/translators`).
- Settings (schema `tmgmt.translator.settings.google`): `api_key` (required), `auto_accept`
  (boolean), `url` (hidden test override).
- `checkAvailable()` returns yes only when `api_key` is set; the UI validates the key by fetching
  Google's supported languages.
- Endpoint: `https://www.googleapis.com/language/translate/v2`; source strings sent in chunks of 5.
