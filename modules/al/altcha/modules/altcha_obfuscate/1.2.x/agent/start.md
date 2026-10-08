<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ALTCHA Obfuscate — agent index

Submodule of **ALTCHA**. Adds field formatters that hide a value behind ALTCHA's
proof-of-work "obfuscation" plugin until a visitor clicks to reveal it — anti-scraper
protection for emails, phones, and strings. No settings page, permission, or Drush.

- **The three formatters, their field types, per-formatter + global settings, and how obfuscation works** →
  [configure/formatters.md](configure/formatters.md)

Parent module docs: `modules/altcha/1.2.x/`.

Key facts: formatters `altcha_obfuscated_email` (email → `mailto:`),
`altcha_obfuscated_telephone` (telephone → `tel:`), `altcha_obfuscated_string` (string),
chosen on *Manage display*. Value is AES-256-GCM encrypted (`ObfuscationUtility`, needs
`ext-openssl`) and revealed via a proof-of-work "Click to reveal" widget. Per-formatter
setting `reveal_text_override`; global keys in `altcha.settings`: `obfuscate_reveal_text`,
`obfuscate_max_number`, `obfuscate_library_override`. Depends on `altcha`.
