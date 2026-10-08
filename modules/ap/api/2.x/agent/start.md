<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API (api) — agent index

**Parses PHP source branches (Doxygen/Drupal conventions) into content entities and renders browsable, searchable API reference pages; the engine behind api.drupal.org.**

- **Version:** 2.x
- **Core:** ^9 || ^10 || ^11 · **Package:** Development · **Configure:** `api.settings` (`/admin/config/development/api`)
- **Dependencies:** views, block, comment, link, options, pathauto:pathauto
- **Permissions:** `access API reference` (all `/api/...` display + search routes), `administer API reference` (settings, wizard, comments, branch parse). Neither granted to anonymous by default.
- **Key services:** `api.parser` (queue-backed source parser, uses `@http_client`, `@file_system`), `api.utilities`, breadcrumb builder, `SafeMarkup` Twig extension, legacy-file path processor.
- **Entities:** Project, Branch, PhpBranch, ExternalBranch, DocBlock (+ DocFile/DocFunction/DocClassMember/DocNamespace/DocReference/DocOverride), PhpDocumentation, ExternalDocumentation.
- **Drush:** `src/Commands/ApiCommands.php` (parse/reparse/maintenance).
- **Security:** every display and admin route is permission-gated; branch source paths/URLs are admin-configured (not request-derived), so the parser's `file_get_contents`/HTTP-client reads are not a request-driven SSRF. A public docs site must deliberately grant `access API reference` to anonymous. No anonymous mutating endpoints.

See [configure/setup.md](configure/setup.md) and [drush/commands.md](drush/commands.md)
