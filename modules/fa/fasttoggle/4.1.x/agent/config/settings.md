<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fasttoggle settings form and config

## Settings form

Route `fasttoggle.settings` → `/admin/config/system/fasttoggle`, permission `administer fasttoggle`
(`fasttoggle.routing.yml`). Form: `FasttoggleSettingsForm` (`src/Form/FasttoggleSettingsForm.php`,
extends `ConfigFormBase`, form id `fasttoggle_settings`, editable config `fasttoggle.settings`). A
menu link (`fasttoggle.links.menu.yml`) places it under `system.admin_config_system`.

The form has a single element:

- `label_style` — `#type => radios`:
  - `0` — Status labels that reflect the current state (e.g. "Published", "Sticky").
  - `1` — Action labels that show what a click does (e.g. "Unpublish", "Promote").

`submitForm()` saves `label_style` into `fasttoggle.settings` and shows a confirmation message.

## Config object

`config/install/fasttoggle.settings.yml`:

```yaml
label_style: 1
```

Default is `1` (action labels). Schema (`config/schema/fasttoggle.schema.yml`):
`fasttoggle.settings` is a `config_object` with one `integer` mapping `label_style`.

`label_style` is read in two places: `FasttoggleController::toggle()` (for the replacement link label)
and the link-builder helpers in `FasttoggleHooks` (for the initial link label). See
[../hooks/links-and-bundle-settings.md](../hooks/links-and-bundle-settings.md).

## Per-bundle third-party settings (where toggles are enabled)

Which toggles actually appear is not set on this form — it is set per bundle and stored as `fasttoggle`
third-party settings on the bundle config entities. Schema:

- `node.type.*.third_party.fasttoggle` — booleans `status`, `promote`, `sticky`.
- `comment.type.*.third_party.fasttoggle` — boolean `status`.

These checkboxes are added to the content-type / comment-type edit forms by the hooks (see
[../hooks/links-and-bundle-settings.md](../hooks/links-and-bundle-settings.md)); each defaults to `0`.

## Permissions

`fasttoggle.permissions.yml` defines `administer fasttoggle` (this settings form) and `use fasttoggle`
(the toggle route and whether the links render). Both have `restrict access: FALSE`.
