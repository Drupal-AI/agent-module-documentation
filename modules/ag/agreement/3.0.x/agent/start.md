<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agreement (agreement) — agent index

Forces users in configured roles to accept a text agreement ("Terms of Service", AUP, NDA)
before they may use the site, and records each acceptance per user. Each agreement is a
**config entity** (`agreement`) with its own page path, target roles, text format, page
visibility and re-acceptance frequency. A request subscriber redirects targeted users to the
agreement page until they accept; acceptance is written to the `{agreement}` database table
(anonymous acceptance uses a cookie). Supports multiple agreements, anonymous agreements, and
expiring/periodic re-acceptance.

- Core `filter` dependency only; core `^10.3 || ^11`.
- Configure route: `entity.agreement.collection` → `/admin/config/people/agreement`.
- Defines 3 permissions; no drush commands; provides config schema; no plugin types (but ships
  a Views field plugin and migrate plugins).

Do:
- **Create/edit an agreement (roles, path, text, frequency, visibility, messages)** → [configure/agreements.md](configure/agreements.md)
- **Permissions and how they gate behavior** → [permissions/permissions.md](permissions/permissions.md)
- **Query/record acceptance programmatically (the handler service)** → [api/handler.md](api/handler.md)
- **Alter which agreement applies; mail on accept/revoke** → [hooks/alter.md](hooks/alter.md)
- **How enforcement works (redirect subscriber, destination handling)** → [events/subscriber.md](events/subscriber.md)
- **Reporting on who agreed (bundled Views + `{agreement}` table)** → [views/records.md](views/records.md)

Key facts:
- Config entity type: `agreement`; config prefix `agreement.agreement.*`; ships
  `agreement.agreement.default` (path `/agreement`, role `authenticated`, frequency `-1`).
- Services: `agreement.handler` (`Drupal\agreement\AgreementHandler`), `agreement_subscriber`
  (`Drupal\agreement\EventSubscriber\AgreementSubscriber`).
- Admin routes: `entity.agreement.collection`, `agreement.add`, `entity.agreement.edit_form`,
  `entity.agreement.delete_form` (all `_permission: administer agreements`). Each agreement
  also gets a dynamic acceptance route `agreement.<id>` at its own `path`.
- Permissions: `administer agreements` (restrict access), `bypass agreement`, `revoke own agreement`.
- DB table `{agreement}`: `id, type, uid, agreed, sid, agreed_date` (index `type_uid`).
- Settings keys (entity `settings` map): `frequency, title, format, submit, checkbox, success,
  revoked, failure, destination, recipient, roles[], reset_date, visibility{settings,pages[]}`.
- `frequency`: `-1` once, `0` every login (per session id), `.5` 12h, `1` daily, `365` yearly.
- `visibility.settings`: `0` = show on every page except listed, `1` = show on only listed pages.
- Hooks: `hook_agreement_handler_alter()`, `hook_mail()` (keys `notice`, `revoked`).
- Bundled Views: `agreements` (admin report), `user_agreements` (profile tab); Views field
  plugin `agreement_entity`; `hook_views_data()` on the `{agreement}` table.
- Installs at module weight `9999` so its subscriber runs late.
