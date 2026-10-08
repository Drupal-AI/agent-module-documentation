<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActiveCampaign Dashboard (activecampaign_dashboard) — agent index

Submodule of **activecampaign**. Adds three **read-only** admin pages that list ActiveCampaign
campaigns, contacts and lists via the parent module's `activecampaign.api` service. Package
`Automated marketing`. Depends on `activecampaign:activecampaign`. Core `^10.2 || ^11`. Version
1.0.0-rc1 (dir `1.0.x`). GPL-2.0-or-later.

- **The three dashboard pages, routes, permission, the base class** →
  [dashboard/pages.md](dashboard/pages.md)

## What it provides

- **One permission** `access activecampaign dashboard` (`.permissions.yml`) — gates all pages.
- **Routes** (`.routing.yml`):
  - `activecampaign.dashboard` `/admin/activecampaign` → core `SystemController::systemAdminMenuBlockPage`
    (the menu landing).
  - `activecampaign.dashboard.contacts` `/admin/activecampaign/contacts` → `Form\ActiveCampaignContacts`.
  - `activecampaign.dashboard.lists` `/admin/activecampaign/lists` → `Form\ActiveCampaignLists`.
  - `activecampaign.dashboard.campaigns` `/admin/activecampaign/campaigns` → `Form\ActiveCampaignCampaigns`.
  - all `_permission: 'access activecampaign dashboard'`.
- **Base form** `Form\ActiveCampaignDashboard` (`FormBase`) injects `activecampaign.api`,
  `pager.manager`, `pager.parameters`. `buildForm()` renders a `#type => table` + core pager from
  `getTableData($page, 20)`; the base `getTableData()` returns empty and each subclass overrides it.
  `submitForm()` is a no-op — the pages never write.
- **Subclasses**: `ActiveCampaignContacts` → `api->getContacts()` (Email/First/Last/Created);
  `ActiveCampaignCampaigns` → `api->getCampaigns()` (Name/Date/Sends + open/click/bounce/unsubscribe
  rates via `convertToRate()`); `ActiveCampaignLists` → `api->getLists()` (Name/Subscribers/Active).
  Name/email cells become `Link`s to the ActiveCampaign app (`api->createUrlToContact/Campaign`, or
  the list's own `url`). If the API returns a string error, it is shown via `messenger()->addError()`.
- **Menu/tasks**: `.links.menu.yml` (section + 3 children under `system.admin`),
  `.links.task.yml` (3 local tasks). Library `activecampaign_dashboard/admin_menu`
  (`css/admin-menu.css`) + an SVG icon.
- **No** config, **no** entities, **no** Drush, **no** writes.
