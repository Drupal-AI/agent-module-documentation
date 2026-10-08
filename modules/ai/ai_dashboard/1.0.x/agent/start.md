<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ai_dashboard — agent start

Replaces AI Core's **Admin → Configuration → AI** page (`/admin/config/ai`) with a
Layout-Builder **Dashboard** for the drupal/ai ecosystem. No routing.yml of its own: a
`RouteSubscriber` overrides route `ai.settings.menu` (path `/admin/config/ai`, permission
**`administer ai`**) so its controller renders the `ai_dashboard` Dashboard config entity.
Depends on `ai`, `dashboard`, `project_browser`. No permissions, no Drush, `configure` = null
(reached through AI Core's route). Version 1.0.x.

The dashboard (`dashboard.dashboard.ai_dashboard`) places six blocks: Setup, Features,
Status, Extensions, Configuration, Documentation.

- **Configure the dashboard, its blocks, and the recommended-recipes source** → [configure/ai_dashboard.md](configure/ai_dashboard.md)
- **Add a documentation link (the `ai_documentation` YAML plugin type) / the ProjectBrowserSource** → [plugins/ai_dashboard.md](plugins/ai_dashboard.md)
- **Check provider setup status from code (`AiSetupStatus` service)** → [api/ai_dashboard.md](api/ai_dashboard.md)
