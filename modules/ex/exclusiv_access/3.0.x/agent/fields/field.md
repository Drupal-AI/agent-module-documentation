<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exclusiv Access field (type / widget / formatter)

The module ships one field plugin trio, all keyed to field type `exclusiv_access_field_type`.

## Field type — `ExclusivAccessFieldType`
`src/Plugin/Field/FieldType/ExclusivAccessFieldType.php`, `@FieldType(id="exclusiv_access_field_type", default_widget="exclusiv_access_field_widget", default_formatter="exclusiv_access_field_formatter")`.

- Storage: one column `value` (`int`, `size => tiny`) — a boolean "activate" flag. `propertyDefinitions()` exposes `value` as a boolean.
- `isEmpty()` returns TRUE when `value` is NULL or FALSE (unchecked = empty).
- `generateSampleValue()` returns a pseudo-random boolean (`time() % 2`).
- **Token lifecycle — `postSave($update)`:** when `value == 1`, reads State key `exclusiv_access`; if no token exists yet for this `entity_type`/`entity_id`, generates one with `new Random(); $random->name(32)` and writes it back to State (`\Drupal::state()->set('exclusiv_access', $state)`). Then builds the canonical absolute URL, appends `?token=<token>`, and shows it via `\Drupal::messenger()->addMessage('Exclusiv URL : @link')`. An existing token is reused (not regenerated) on later saves. Note: it only ever **adds** a token — unchecking the box does not delete the stored State entry (see api/access-check.md for how that affects gating).

## Widget — `ExclusivAccessFieldWidget`
`src/Plugin/Field/FieldWidget/ExclusivAccessFieldWidget.php`, `@FieldWidget(id="exclusiv_access_field_widget")`. Extends `WidgetBase`; injects core `state` via `create()`.

- `formElement()` builds a `#type => details` group titled "Exclusiv Access Control", `#group => 'advanced'` (shows in the entity form's advanced/sidebar tabs).
- `value`: a checkbox labelled "activate", default from the stored item.
- `token`: shown only when a token already exists in State for the entity — a **disabled** textfield displaying the current token (read-only reference so editors can copy it).

## Formatter — `ExclusivAccessFieldFormatter`
`src/Plugin/Field/FieldFormatter/ExclusivAccessFieldFormatter.php`, `@FieldFormatter(id="exclusiv_access_field_formatter", label="Empty formatter")`. `viewElements()` returns `[]` — deliberately outputs nothing, so the flag/token never renders on the entity display.

## Form alters — `exclusiv_access.module`
For fields of this type:
- `hook_form_field_storage_config_edit_form_alter`: hides/disables the cardinality container (field is effectively single-value).
- `hook_form_field_config_edit_form_alter`: hides/disables the "required" and "default value" elements and blanks any `#default_value` in the default-value widget (defaults are managed by the module, not the field config UI).

## Operating it
1. Enable the module (`drush en exclusiv_access -y`); core `field` is the only dependency.
2. On the target bundle, **Manage fields → Add field → Exclusiv Access** (`exclusiv_access_field_type`). Cardinality/required/default are locked by the alters above.
3. Edit an entity, open the "Exclusiv Access Control" group, tick "activate", save. The save message contains the tokenised URL to share; re-editing shows the token in the disabled field.
