<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Computed group fields + `group_select` widget

The module has three moving parts: an `entity_bundle_field_info` hook that defines the fields, a
computed `FieldItemList` that reads/writes Group relationships, and one field widget. There is no
config, no route, no permission, no service of its own.

## Field definition — `EntityHooks::attachGroupFields()`

File `src/Hook/EntityHooks.php`, attribute `#[Hook('entity_bundle_field_info')]` (with a
`#[LegacyHook]` procedural shim `entitygroupfield_lite_entity_bundle_field_info()` in
`entitygroupfield_lite.module` for older Drupal). It:

- Loops every `group_type` config entity (`entityTypeManager->getStorage('group_type')->loadMultiple()`).
- For each installed relation plugin on that group type (`$group_type->getInstalledPlugins()`), it
  matches the plugin's target: if the plugin has no bundle (`getEntityBundle() === FALSE`) it matches
  on entity type only; otherwise it matches entity type **and** bundle. Non-matching entity
  type/bundle → skip. So the field only appears where a relation plugin can actually attach.
- Defines a `BaseFieldDefinition::create('entity_reference')` named **`group_<group_type_id>`**
  with: `target_type = group`, `handler = default:group`, `group_type_id = <id>`,
  `handler_settings.target_bundles = { <id>: <id> }`, sort by `label` asc, `auto_create = FALSE`.
- Flags: `computed(TRUE)`, `customStorage(TRUE)`, `readOnly(TRUE)`, `translatable(FALSE)`.
- Cardinality = `$plugin->getGroupCardinality()`, or `CARDINALITY_UNLIMITED` when that is `0`.
- `setClass(EntityGroupFieldItemList::class)`; display-configurable on form + view, both defaulting
  to the *hidden* region (you enable it yourself on Manage form display).
- Label = `t('Attach to the %group group', ['%group' => $group_type->label()])` (placeholder-escaped).

Because fields are keyed by `group_<group_type_id>` and rebuilt from the current group types, adding a
group type exposes a new field after a cache/field rebuild.

## Read/write — `EntityGroupFieldItemList`

File `src/Field/EntityGroupFieldItemList.php` (`EntityReferenceFieldItemList` + `ComputedItemListTrait`).

- `computeValue()`: returns NULL for new/unsaved hosts or when no relation plugin matches the host
  type/bundle (`getGroupRelationTypePluginIds()`). Otherwise loads `GroupRelationship::loadByEntity()`
  and, for relationships whose `getGroupTypeId()` equals the field's `group_type_id`, creates one item
  per relationship pointing at `target_id = group id`.
- `preSave()`: deliberately empty — deferred so the host entity id exists.
- `postSave($update)`: when the value was computed, compares the submitted items against
  `getExistingRelationships()` (existing `group_relationship`s whose group bundle is in
  `handler_settings.target_bundles`). For each submitted group with no existing relationship it calls
  `$group->addRelationship($host_entity, $plugin_id)` (plugin id from
  `getGroupRelationshipPluginId()`); relationships that exist but were not resubmitted are collected
  into `$diff` and removed with `entityTypeManager->getStorage('group_relationship')->delete($diff)`.
  So the submitted set becomes the authoritative membership set for that group type.

## Widget — `GroupSelectWidget` (id `group_select`)

File `src/Plugin/Field/FieldWidget/GroupSelectWidget.php`, extends core `OptionsSelectWidget`,
`#[FieldWidget(id: 'group_select', label: 'Group select list', field_types: ['entity_reference'],
multiple_values: TRUE)]`. Injected services: `entity_type.manager`, `current_user`,
`group_relation_type.manager`, `group_permission.checker`.

- **Settings** (`defaultSettings()` / `settingsForm()` / `settingsSummary()`): `override_label`
  (textfield — overrides the field label) and `required` (checkbox). No config schema ships for these.
- **`formElement()`**:
  - Inside the Group creation wizard (`$form_state->get('group_wizard_id')`) it returns `[]` (hides
    itself) when the wizard's group bundle is one of the field's target bundles.
  - Applies `override_label` to `#title` and `required` to `#required`.
  - If fewer than 2 options, sets `#multiple = FALSE`; if exactly 1 option, converts the element to a
    `#type = checkbox` (`#return_value` = the single group id).
  - Loads the option groups and, per option, computes the relevant permission string
    (`create <plugin_id> relationship`, or `delete own|any <plugin_id> relationship` for a currently
    selected group, "own" decided by `group->getOwnerId() == current user`) and calls
    `groupPermissionChecker->hasPermissionInGroup()`. Options that fail get
    `#options_attributes[gid]['disabled'] = 'disabled'` (rendered by Form Options Attributes). If every
    option ends up disabled, the whole element gets `#access = FALSE`.
- **`massageFormValues()`**: drops rows with an empty `target_id`.

## Operating notes

- Options come from the field's `default:group` selection handler, so the list is the group-type's
  groups the current user may reference (view). The widget marks options the user cannot join/leave as
  unavailable and hides itself entirely inside the Group wizard.
- Membership changes take effect only when the **host entity is saved** (via `postSave`), not on
  option toggle. Not resubmitting a currently-attached group removes that relationship.
- No settings page: the only configuration is per-form-display widget settings on **Manage form
  display**. Enable the `group_<group_type_id>` field there and pick *Group select list*.
