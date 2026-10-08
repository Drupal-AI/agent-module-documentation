<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Label Override (field_label_override) — agent index

Overrides a field's **label per entity view display** (view mode) instead of once on the field
config. Pure hook module — no routes, services, permissions, or plugin types. It alters the core
**Manage display** form (`entity_view_display_edit_form`): for every field row whose Label setting is
a select list it appends three options — **Above (Overridden)**, **Inline (Overridden)**,
**- Visually Hidden (Overridden) -** (values `above_overridden`, `inline_overridden`,
`visually_hidden_overridden`). Picking one reveals an **Override label** textfield (maxlength 255)
and a **Preserve original label** checkbox; a spliced-in submit handler stores those on the display
component's `third_party_settings.field_label_override`.

At render time `hook_preprocess_field()` reads that third-party setting and swaps the value into the
field template. By default it replaces `$variables['label']`; when *Preserve original label* is on it
leaves `label` untouched and instead exposes the custom text as a **new** `label_override` Twig
variable for a theme's `field.html.twig` to place independently. The override string is a plain PHP
string, so core's `{{ label }}` in `field.html.twig` auto-escapes it on output, and it can only be
set by users who can edit the entity's Manage display (admin-trust).

- Depends on: `drupal:field`. Core: `^10 || ^11`. Package: `Fields`.
- No settings page / `configure` route — all configuration is **per field, per view display** on
  Manage display. Provides config schema; no permissions, no services, no drush, no plugin types.
- Attaches a theme CSS library `field_label_override/entity_view_display_form` to the display form.

## What you'd do → where

- **Set/override a field label for one view mode; understand the added options, storage, Twig
  variable and how to set it from code** → [fields/label-override.md](fields/label-override.md)

## Key facts (real machine names)

- Hooks: `hook_help` (route `help.page.field_label_override`),
  `field_label_override_form_entity_view_display_edit_form_alter`, `hook_preprocess_field`; plus the
  submit callback `field_label_override_form_submit`.
- Added Label `#options`: `above_overridden`, `inline_overridden`, `visually_hidden_overridden`.
- Third-party-settings key: `field_label_override` on an `entity_view_display` component; sub-keys
  `label_override` (string, ≤255) and `preserve_label` (bool).
- Twig variables: `label` (replaced) or `label_override` (added when `preserve_label` is on).
- Config schema id: `core.entity_view_display.*.*.*.content.*.third_party.field_label_override`.
- Library: `field_label_override/entity_view_display_form` (theme CSS `css/entity_view_display_form.css`).
- No routes / services / permissions / drush / plugin types. The `.module` has a dead `use` import for
  a non-existent `Drupal\field_label_override\Form\FieldLabelOverrideFormBase` (harmless — never
  referenced; there is no `src/`).
