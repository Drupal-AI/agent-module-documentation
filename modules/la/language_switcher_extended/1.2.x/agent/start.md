<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# language_switcher_extended — agent start

Extends **core's Language Switcher block** (it does not add its own block). Implements
`hook_language_switch_links_alter()` and pipes every switcher's links through the service
`language_switcher_extended.link_processor`, driven entirely by one config object
`language_switcher_extended.settings`. Main use: on a content-entity page, handle languages
the entity is **not translated into** — hide the link, repoint it to the front page, or show
the language as un-clickable text. Depends on core `block` + `language` (and in practice
`content_translation` to have translations to detect). No Drush, no plugin types, no theme
overrides.

Config UI: **Admin → Configuration → Regional and language → Language Switcher Extended** —
path `/admin/config/regional/language/language-switcher-extended`, route
`language_switcher_extended.settings`, permission `administer language_switcher_extended`.

- Every settings key, its values, defaults, and `drush cset` recipes → [configure/language_switcher_extended.md](configure/language_switcher_extended.md)
- The link-processor service, the alter hook, and how links are mutated programmatically → [api/language_switcher_extended.md](api/language_switcher_extended.md)
