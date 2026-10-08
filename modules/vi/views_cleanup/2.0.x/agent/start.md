<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Cleanup (views_cleanup) — agent index
**Developer services + a Drush command to bulk clean up, replace and add Views filters, fields and dependencies.**

- **Version:** 2.0.x
- **Core:** ^10
- **Services:** `views_cleanup.filter_cleanup`, `.filter_replacement`, `.filter_add`, `.aggregate_views_filter_option`, `.denpendencies` (module dep cleanup), `.fields_cleanup`.
- **Drush:** `ViewsCleanupCommands` (tag `drush.command`).
- **Routes / permissions:** none.

**Security:** No web surface — services and a Drush command only; intended for update hooks / CLI. Methods rewrite Views config directly, so run in a controlled deployment context. No security findings.

See [api/services.md](api/services.md).
