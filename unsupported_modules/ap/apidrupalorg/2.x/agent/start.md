<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API.Drupal.org (apidrupalorg) — agent index

**Site-specific customizations for api.drupal.org on top of the API module: a D7 comments importer, an external-documentation inbound path processor, and a footer-message block.**

- **Version:** 2.x
- **Core:** ^9 || ^10 || ^11 · **Package:** Drupal.org · **Configure:** `apidrupalorg.import`
- **Dependencies:** views, api:api
- **Route:** `apidrupalorg.import` `/admin/config/development/apidrupalorg/import` — requires `administer comments,administer users,administer API reference` (all three).
- **Services/plugins:** `apidrupalorg.path_processor.external_documentation` (inbound path processor), `src/Plugin/Block/FooterMessage.php`, `src/Form/ImportForm.php`.
- **Security:** the only route is the importer, gated behind three admin permissions simultaneously; no anonymous or mutating endpoints; path processor only rewrites request paths, block renders static markup.

See [configure/import.md](configure/import.md)
