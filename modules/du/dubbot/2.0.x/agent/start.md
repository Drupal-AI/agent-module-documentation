# DubBot — agent index

Integrates the external **DubBot** SaaS (accessibility, broken links, spelling, SEO, web
governance scans) into Drupal. Requires a DubBot account + **embed key**. Reports show on an
Overview page, an embeddable **report block** (`dubbot_report`), and an optional toolbar item
(submodule `dubbot_toolbar`). No fields/entities of its own; state = `dubbot.settings` config,
block placements, and role permissions.

- **Settings (embed key, API URL, report position, preview selector) + placing the report block** →
  [configure/settings.md](configure/settings.md)
- **Permissions: admin, report access, and per-pane tab permissions** →
  [permissions/permissions.md](permissions/permissions.md)
- **Services + the `hook_dubbot_domains_alter()` hook (client, domain negotiator, link generator)** →
  [api/services.md](api/services.md)

Key facts:
- Config object `dubbot.settings`: `embed_key`, `api_url` (default `https://api.dubbot.com`),
  `dialog_renderer` (`0`=Modal | `off_canvas`=Side | `off_canvas_top`=Top), `preview_selector`
  (default `#page`).
- Routes: `dubbot.overview` (`/admin/config/content/dubbot`), `dubbot.settings`
  (`…/dubbot/settings`), `dubbot.report`, `dubbot.icon`.
- Submodule `dubbot_toolbar` docs: [../modules/dubbot_toolbar/2.0.x/agent/start.md](../../modules/dubbot_toolbar/2.0.x/agent/start.md).
