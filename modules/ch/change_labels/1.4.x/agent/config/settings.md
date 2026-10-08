<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Change labels — configuration & operation

No dedicated admin page (`configure` is null). Everything is set through **core** entity-display UIs
and stored as **third-party settings** in the relevant config entity. Two storage locations:

1. Per-widget settings → on the `core.entity_form_display.*` widget's `third_party_settings.change_labels`.
2. Per-form-display settings → on the `core.entity_form_display.*` entity's own
   `third_party_settings.change_labels`.

## Install / enable

- `drush en change_labels -y`. Requires Drupal core `^11.2`; no other module dependency
  (`hook_event_dispatcher` in `composer.json` is unused since 1.4.0 — uninstall it if nothing else
  needs it). No install hooks, no default config.

## Per-widget settings (Manage form display → the widget's settings gear)

Added by `ChangeAddAnotherLabel::addSettings` (hook `field_widget_third_party_settings_form`),
merging trait helpers. Fields shown depend on the widget/field:

- `field_label_overwrite` (textfield, always) — replace the widget's field label. Enter the literal
  token `<nolabel>` to hide the label (`ChangeFieldLabel::setNewLabel` → `#title_display = invisible`;
  file/address details wrappers get `visually-hidden` via `#process` →
  `processChangeFieldLabel` → `#pre_render` `overwriteLabel`). Applied in
  `field_widget_complete_form_alter` (`ChangeFieldLabel::alterFormFieldLabel`).
- `number_size` (textfield, only when the widget is core `NumberWidget`) — sets each value input's
  `#size`. `ChangeNumberField::addSettingsChangeNumberField` / `alterFormChangeNumberField`.
- `remove_label` (textfield, only when the widget is core `FileWidget`) — replaces the "Remove"
  button `#value`. `ChangeRemoveLabel` via a `#process` callback `processChangeRemoveLabel`.
- The next three appear only when the field storage **cardinality is not 1**:
  - `add_another` (textfield) — replaces the "Add another item" button `#value` (`add_more`).
  - `hide_add_another` (checkbox → stored as integer) — sets `add_more['#access'] = FALSE`.
  - `force_single_cardinality` (checkbox → integer) — sets the multi-value theme's `#cardinality = 1`,
    `#cardinality_multiple = FALSE`, and hides each row's `_weight`. Does **not** change stored
    cardinality — display only.

Widget-setting persistence uses core's field-widget third-party-settings mechanism (no custom
entity-builder). Schema: `field.widget.third_party.change_labels` in
`config/schema/change_labels.field.schema.yml`.

## Per-form-display settings (Manage form display → "Change labels" fieldset)

Added by `ChangeSubmitLabel::addSettingsForm` (hook `form_entity_form_display_form_alter`) and saved
by the `#entity_builders` callback `saveThirdPartySettings` (empty value ⇒ setting is unset):

- `submit_label` (textfield) — replaces the entity form's submit/"Save" button `#value`. Applied in
  `form_alter` (`ChangeSubmitLabel::formAlter`) only for `ContentEntityFormInterface` forms that have
  `actions.submit.#value`.
- `submit_message` (textfield, **EXPERIMENTAL**) — when set, `formAlter` appends
  `ChangeSubmitLabel::replaceMessage` to `#submit`; on save it deletes all `TYPE_STATUS` messages via
  the messenger and adds this one instead. Suppresses core's "X has been created/updated" messages.

Schema: `core.entity_form_display.*.*.*.third_party.change_labels` in
`config/schema/change_labels.schema.yml` declares only `submit_label`. `submit_message` is
read/written by `ChangeSubmitLabel` but has **no schema key**, so config export/validation will warn
about an unschematized value if it is set.

## Access / operation notes

- There are no module routes or permissions. Editing any of these labels requires the core
  permission that guards the corresponding display UI — e.g. `administer <entity type> form display`
  (Manage form display) — i.e. a site-builder/admin-level permission.
- All overrides are display-only: they change `#title` / button `#value` / `#size` / `#access` on
  render elements and (for `submit_message`) the status message. They do not alter machine names,
  stored field data, storage cardinality, or entity access.
- Config-managed: overrides live inside the `core.entity_form_display.*` config entities and export
  with `drush cex`.

## Config example (widget third-party settings on a form display)

```yaml
# core.entity_form_display.node.article.default.yml (excerpt)
content:
  field_members:
    third_party_settings:
      change_labels:
        field_label_overwrite: 'Team members'
        add_another: 'Add another team member'
        hide_add_another: 0
        force_single_cardinality: 0
# and, on the display entity itself:
third_party_settings:
  change_labels:
    submit_label: 'Publish story'
```
