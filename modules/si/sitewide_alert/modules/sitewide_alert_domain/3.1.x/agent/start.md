<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sitewide Alert Domain — agent index

Experimental submodule of **sitewide_alert** (see `../../../../3.1.x/agent/start.md`).

Scopes alerts to specific domains on a multi-domain (Domain Access) install. It
**decorates** the parent's `sitewide_alert.sitewide_alert_manager` service with
`SitewideAlertDomainManager` (decoration priority 9), filtering the alerts for a
request by the current negotiated domain.

Depends on `sitewide_alert`, `domain`, and `domain_entity` — install and
configure Domain Access + Domain Access Entity first. After
`drush en sitewide_alert_domain -y`, enable domain support for the
`sitewide_alert` entity type at `/admin/config/domain/entities`, then expose the
Domain Access field on the alert form. No config form, permissions, or schema of
its own.
