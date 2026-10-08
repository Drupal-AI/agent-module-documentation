<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets a Drupal site that the Content Sync (Sync Core) backend cannot reach directly — e.g. a local dev environment behind a firewall — participate in syndication by having the site poll the backend for pending requests instead of receiving inbound calls.

---

Normally the Sync Core backend pushes requests inbound to a registered site's REST endpoints, which requires the site to be publicly reachable. This submodule inverts that for private/local environments: the site periodically asks the backend for queued requests and processes them itself. A `RequestHandlerController` (route `cms_content_sync_private_environment.private_environment` at `/admin/config/services/cms_content_sync/private-environment`, permission `administer cms content sync`) handles the request processing, and it can be driven two ways: on cron (`hook_cron` calls `RequestHandlerController::processRequests()` when enabled) or via the Drush command `cms_content_sync_private_environment:poll` (alias `cspep`). The Drush command takes a `limit` argument (`watch`, `all`, or a fixed number) and options `--pollInterval` (seconds, for `watch` mode, default 15) and `--host` (override the self-request host). It requires Basic Auth to be enabled and configured for Content Sync. It has no configuration entity, no permission of its own and no plugins.

---

- Sync content to/from a local DDEV/Lando dev site the backend cannot reach from the internet.
- Run Content Sync from behind a corporate firewall or NAT without opening inbound ports.
- Poll the Sync Core backend for pending requests on cron.
- Continuously watch for sync requests with `drush cspep watch --pollInterval=15`.
- Process all currently-queued requests once with `drush cspep all`.
- Process a fixed number of pending requests with `drush cspep 10`.
- Enable a staging environment on a private network to pull production content.
- Develop against real syndicated content locally without a public URL.
- Override the self-request host with `--host` when Drupal's internal hostname differs.
- Keep a firewalled site in sync via scheduled cron polling instead of inbound webhooks.
- Test Content Sync flows on a laptop that has no public DNS.
- Avoid exposing a development site publicly just to receive sync callbacks.
- Integrate a secured internal editorial site into a wider syndication network.
- Drain a backlog of queued sync operations after a private site was offline.
- Run one-off pulls into a private environment from CI using the poll command.
- Support agencies developing multi-site setups locally against a shared backend.
- Bridge an air-gapped-ish environment to Content Sync through outbound polling only.
- Combine with Basic Auth so the polling site authenticates to the backend securely.
