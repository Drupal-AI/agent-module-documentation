<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Single Language URL Prefix — agent index

Keeps the **language URL prefix** (e.g. `/en`) in URLs on a site with only **one** enabled
language (core normally drops it when monolingual). Works via a path processor. Depends on core
`language`. No permissions of its own, no Drush, no plugins.

- **How it works, its requirements, and the one setting (`excluded_paths`)** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Settings config: **`single_language_url_prefix.settings`**, one key **`excluded_paths`** (newline-
  separated paths/patterns), form at `/admin/config/regional/language/single-language-url-prefix`
  (permission `administer languages`).
- Only acts when **exactly one** language is enabled AND core language negotiation URL **source =
  path prefix** with a prefix set for that language (`language.negotiation` → `url`).
- Service `single_language_url_prefix.path_processor` (`SingleLanguageNegotiationUrl`): inbound
  strips the prefix, outbound injects `$options['prefix']`.
- More than one language enabled → the module is a no-op (core handles prefixes).
