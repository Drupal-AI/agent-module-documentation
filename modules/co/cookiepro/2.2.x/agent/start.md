<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CookiePro by OneTrust — agent index

Injects the OneTrust/CookiePro cookie-consent banner + preference-center **script** into the
page `<head>` on every request. Thin integration: you paste OneTrust's script tag into one
settings field. The consent logic lives in the **external OneTrust service** and needs a
CookiePro account — this module only delivers the script. No field, no block, no Drush.

- **Where to paste the script / the config object & settings form** →
  [configure/scripts.md](configure/scripts.md)
- **How the pasted script reaches every page (hook, `<head>` injection)** →
  [api/injection.md](api/injection.md)

Key facts:

- Settings form: `/admin/config/development/cookiepro` — route **`cookiepro.admin.header`**
  (also the `configure` route), form id `hfs_header_settings`.
- Config object: **`cookiepro.header.settings`**, single key **`scripts`** (text). The config
  object only exists once you save the form; uninstall deletes it.
- Permission gating the form: **`cookiepro_settings`** (title "CookiePro by OneTrust").
- Injection via `hook_page_attachments_alter()` in `cookiepro.module`.
