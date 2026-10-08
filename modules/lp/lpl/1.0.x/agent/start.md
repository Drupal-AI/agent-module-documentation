<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logo per language (lpl) — agent index

One site logo per installed language, swapped by interface language on the core branding block.
Core `^9 || ^10 || ^11`. **No dependencies, no `src/`, no routes, no permissions, no config
entity/schema, no drush.** The whole module is `lpl.module` (~145 lines) plus the info file.

Capabilities:
- [Set a logo per language](configure/logo-per-language.md) — where to configure it (theme settings,
  not a page of its own), the per-language setting keys, upload rules, path validation, and how the
  branding block renders the right logo.

Orientation:
- Configuration lives inside the **existing theme settings form** (`admin/appearance/settings/{theme}`),
  not a dedicated admin page. That is where to look when asked "where do I set this?".
- Fields appear **only for languages with a non-empty URL prefix** (`language.negotiation`
  `url.prefixes`). Monolingual sites see nothing and the module is inert; it declares no dependency
  on `language`/`content_translation`.
- The logo swap targets the core `system_branding_block` only.
- Contrast with `domain_access_logo` (wave 57), which varies the logo per *domain*; same shape of
  problem on a different axis, and the two can coexist.
