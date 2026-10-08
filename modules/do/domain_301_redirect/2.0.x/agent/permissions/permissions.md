<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# domain_301_redirect permissions

Two permissions, both `restrict access: true` (`domain_301_redirect.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer domain 301 redirect` | The settings form (`/admin/config/search/domain-301-redirect`). Enable/disable, set the main `domain`, and configure the page include/exclude list. |
| `bypass domain 301 redirect` | Exempts the holder from redirection. In `DomainRedirectEventSubscriber::responseHandler()`, if `currentUser()->hasPermission('bypass domain 301 redirect')` the redirect is skipped entirely for that user. Useful for staff/editors who need to reach the site on a non-canonical domain. |

Notes:
- Because bypass is checked per request and the redirect response is cached with the
  `user.permissions` context, bypass and non-bypass users get correctly separated cached
  responses.
- Neither permission gates the `domain_301_redirect.check` route — that uses an HMAC `token`
  (see `configure/settings.md`), not a permission.
