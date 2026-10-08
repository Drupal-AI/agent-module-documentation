<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Perimeter (Drupal Perimeter Defence) — agent index

Bans the IP of any visitor who triggers a 404 for a URL matching a suspicious
regex list. Banning is done through core **Ban** (`ban.ip_manager` → `ban_ip`
table). Requires the `ban` module. Config object: `perimeter.settings`. Settings
form route `perimeter.settings` at `/admin/config/system/perimeter`.

- **Configure it** — patterns, whitelist, flood threshold/window, drush config, routes, permissions: [configure/settings.md](configure/settings.md)
- **How the ban logic works / call it in code** — the event subscriber, ban service, flood key: [api/ban-logic.md](api/ban-logic.md)
- **Hooks** — Honeypot integration it implements; it defines no hooks of its own: [hooks/hooks.md](hooks/hooks.md)

Manage/unban banned IPs on core Ban's page `/admin/config/people/ban` (route `ban.admin_page`).
