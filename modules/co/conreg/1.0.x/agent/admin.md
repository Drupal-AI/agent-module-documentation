<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin / organizer management

All admin routes live under `admin/config/conreg/*` (setup) and `admin/members/*` (operations),
each gated by a specific permission (`conreg.routing.yml` + `conreg.permissions.yml`).

## Event setup (`admin/config/conreg/…`)
- `events` → `Form\Admin\EventList` — list/create events (perm `configure convention registration`).
- `clone/{eid}` → `Form\Admin\EventClone` — duplicate an event's config to a new one.
- `{eid}` → `Form\Admin\EventConfig` — the main per-event settings form (registration text,
  payments incl. Stripe key selection + validation, confirmation/thanks messages, member portal
  role, discounts). Writes config object `conreg.settings.{eid}`.
- `member-classes/{eid}` → `MemberClasses`, `member-types/{eid}` → `MemberTypes`,
  `addons/{eid}` → `EventAddOns` — define the membership classes, types and paid add-ons that shape
  the registration form (perm `configure convention add-ons` for add-ons).

An install auto-creates one open "Default event"; `EventStorage` loads events. `ConregConfig`
(`getConfig($eid)`) / `ConregOptions` / `ConregTable` are the config/option/table helpers.

## Member operations (`admin/members/…`)
- `list/{eid}/{display}/{page}` → `Form\Admin\AdminMembers` — the manage-members grid
  (approve/filter/paginate); `add/{eid}`, `edit/{eid}/{mid}` → `AdminMemberEdit`;
  `delete/{eid}/{mid}` → `MemberDelete` (soft delete, `is_deleted`); `transfer/{eid}/{mid}` →
  `MemberTransfer` (perm `manage convention members`).
- `email/{eid}/{mid}` → `MemberEmail` (single member); `bulk-email/{eid}` → `Form\Admin\BulkEmail`
  + `bulk-send/{mid}` → `BulkMailController::bulkSend` (perm `bulk email sending`). Email is sent
  through **Easy Email** templates (`ConregEmailSender`, `EmailTokenContext`, and the
  `conreg_registration_default` / `conreg_mcheck_*` Easy Email types installed in `config/install`).
- `checkin/{eid}/{lead_mid}` → `CheckInMembers` (perm `check in convention members`);
  `fantable/{eid}/{lead_mid}` → `FanTable` (on-site sign-up, perm `fan table registration`).
- `mailout/{eid}` → `MailoutEmails` and `mailout_export/{eid}/{methods}/{languages}/{fields}`
  (CSV download of member emails, perm `manage mailout lists`).
- Reporting controllers (`ConregController`): member summary, child-member ages,
  options/add-ons lists, and several `admin/config`-style summaries (by type, badge, day, payment
  method, amount paid, join date). Various `view membership *` permissions gate the private-data
  views; admin/portal/fantable list cells are escaped with `Html::escape()`.

## Permissions (selected)
`convention registration`, `fan table registration`, `member portal`,
`lookup registered member emails`, `view public members`, `check membership`,
`access conreg events`, `configure convention registration`, `configure convention add-ons`,
`bulk email sending`, `manage mailout lists`, `manage convention members`,
`check in convention members`, `view membership details|options|add-ons|summary`,
`view child members`, `view programme/volunteer membership details`. Field options can register
their own view permissions via `FieldOptionPermissions::permissions` (permission_callbacks).
