<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prevent Homepage Deletion — agent index

Two access hooks + one settings form. Blocks `delete` (and unpublishing) of the front/404/403
nodes and any extra listed paths unless the account has `delete_homepage_node`.

- **The settings form, the `protected_urls` config, which paths are protected by default** →
  [configure/protected-urls.md](configure/protected-urls.md)
- **The permission, exactly what it gates, and how the access hooks behave** →
  [permissions/delete-homepage-node.md](permissions/delete-homepage-node.md)

Key facts:
- Config: `prevent_homepage_deletion.settings` → `protected_urls` (a **string**: one path per
  line, each starting with `/`; no wildcards).
- Always protected, regardless of config: `system.site:page.front`, `page.404`, `page.403`,
  and whatever `path.matcher::isFrontPage()` says for the current request.
- Permission: `delete_homepage_node` (title "Delete homepage node", `restrict access: false`).
- Route / `configure`: `prevent_homepage_deletion.settings` →
  `/admin/config/system/prevent-homepage-deletion` (requires `administer site configuration`).
- Core's `bypass node access` overrules this module entirely.
- No services, no plugins, no Drush, no entity types.
