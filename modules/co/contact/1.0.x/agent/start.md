<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact (contact) — agent index

Site-wide contact forms + personal (user-to-user) contact forms. **This is core's `contact`
module continued in contrib**: `core_version_requirement: '>11.3'`, so it installs only on
Drupal 11.4+, where core stopped shipping it. On Drupal ≤ 11.3 you get the identical core module
instead — same machine name, same routes, same config names.

- **Forms, settings, routes, and the config objects** →
  [configure/forms-and-settings.md](configure/forms-and-settings.md)
- **Permissions, per-form permissions, personal-tab access rules** →
  [permissions/permissions.md](permissions/permissions.md)
- **Mail handling, flood control, and the services/APIs to call** →
  [api/mail-and-messages.md](api/mail-and-messages.md)
- **Hooks it implements and the alter points it offers** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- **`contact_form`** — config entity, `config_prefix: form` (so `contact.form.{id}`),
  `bundle_of: contact_message`, admin permission `administer contact forms`,
  `config_export`: `id`, `label`, `recipients`, `reply`, `weight`, `message`, `redirect`.
  Route provider `EntityPermissionsRouteProvider` adds a per-form permissions page at
  `/admin/structure/contact/manage/{contact_form}/permissions`.
- **`contact_message`** — content entity, `bundle_entity_type: contact_form`,
  **`storage` handler is `ContentEntityNullStorage`** → messages are never stored;
  `MessageForm::save()` calls `save()` only so contrib can swap the storage handler in.
  `field_ui_base_route: entity.contact_form.edit_form`, so Field UI hangs off the form edit page.
- Routes: `/contact` (`contact.site_page`, permission `access site-wide contact form`),
  `/contact/{contact_form}` (`_entity_access: contact_form.view`),
  `/user/{user}/contact` (`_access_contact_personal_tab: TRUE`),
  admin under `/admin/structure/contact`.
- `contact.settings`: `default_form` (`feedback`), `flood.limit` (5), `flood.interval` (3600),
  `user_default_enabled` (true). The shipped `personal` form has empty recipients — recipients
  come from the contacted user.
- Service `contact.mail_handler` (`MailHandler`, also aliased to `MailHandlerInterface`),
  access check `access_check.contact_personal`, logger channel `contact`.
- Extras: `contact_link` Views field, `ContactMessageResource` REST resource (`EntityResource`
  subclass limited to POST), D6/D7 migrations (`contact_category`, `d6_contact_settings`,
  `d7_contact_settings`), five help topics.
- `contact.skip_procedural_hook_scan: true` — all hooks live in OO `#[Hook]` classes under
  `src/Hook/`; do not look for a procedural `contact_*` hook in `contact.module`.
