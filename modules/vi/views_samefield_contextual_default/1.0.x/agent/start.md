<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Same field Contextual Default (views_samefield_contextual_default) — agent index

**Views argument-default plugin that fills a contextual filter with the same field's value from the current route's entity.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Dependencies:** views
- **Package:** Views (contrib)
- **Plugin:** `samefield_contextual_default` (`@ViewsArgumentDefault`), class `DefaultValue` extends `ArgumentDefaultPluginBase`
- **Options:** `multiple` (or/and/ignore), `overridden_entity_type`, `overridden_field_name`, `use_parent_term`
- **Runtime:** reads route parameter `<entity_type>`, extracts field value(s) auto-detecting the storage property; cache contexts `['url']`, max-age permanent
- **Config:** none of its own — configured inside a view's contextual filter; no routes/permissions

**Security:** no routes or permissions; a Views plugin operating within the view's own access. Reads only fields already exposed by the routed entity. No mutating or anonymous endpoints.

See [plugins/argument-default.md](plugins/argument-default.md)
