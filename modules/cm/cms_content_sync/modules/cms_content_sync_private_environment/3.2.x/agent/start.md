<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMS Content Sync - Private Environment — agent index

Lets a Drupal site that the Content Sync **Sync Core cannot reach inbound** (a local dev box, a
firewalled/NAT'd environment) take part in syndication by **polling** the Sync Core for queued HTTP
requests and replaying them against itself, instead of receiving inbound pushes. Requires Basic Auth
to be configured for Content Sync. Submodule of Content Sync — parent index
[`../../../../3.2.x/agent/start.md`](../../../../3.2.x/agent/start.md).

Dependency: `cms_content_sync`. No settings page (`configure` = null), no permission of its own, no
plugins.

- **`RequestHandlerController` (polling API), cron, the status route, enabling polling** → [api/request-handler.md](api/request-handler.md)
- **The `poll` Drush command** → [drush/commands.md](drush/commands.md)

Key facts:
- Route `cms_content_sync_private_environment.private_environment` →
  `/admin/config/services/cms_content_sync/private-environment`
  (`Controller\RequestHandlerController::view`, permission `administer cms content sync`) — shows the
  pending-request count only.
- Polling is a Sync Core feature flag `FEATURE_REQUEST_POLLING`, toggled with
  `RequestHandlerController::enable()` / `disable()` (enable it from the parent's Advanced settings).
- `hook_cron` (`cms_content_sync_private_environment_cron`) processes pending requests when enabled,
  logging a summary to the `cms_content_sync_private_environment` channel.
- Drush command `cms_content_sync_private_environment:poll` (alias `cspep`).
- `hook_uninstall` calls `RequestHandlerController::disable()` to turn polling back off.
