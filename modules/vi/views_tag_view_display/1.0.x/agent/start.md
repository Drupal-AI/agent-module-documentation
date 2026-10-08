<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# views tag views display (views_tag_view_display) — agent index

**A Views display extender that stores comma-separated tags per display, plus a service to read them for programmatic display discovery.**

- **Version:** 1.0.x — core `^10 || ^11`; depends on `views`.
- **Extender:** `ViewsTagViewDisplayExtender` (id `views_tag_view_display`) — textarea of comma-separated tags per display; registered in `views.settings.display_extenders` on install, removed on uninstall.
- **Service:** `views_tag_view_display.tags` → `getList(string $view_name, $display_id): array` returns the exploded tag list (empty array if missing).
- **Use:** enable module → edit view → display advanced settings → "Display view Tags" → save; read via the service in custom code.
- **Security:** metadata only, configured in the Views UI (needs `administer views`); no routes, queries, or runtime endpoints. See [api/service.md](api/service.md).
