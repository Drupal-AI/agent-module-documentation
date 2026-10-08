<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Select list with create button" widget

## Install & enable

```bash
composer require drupal/entity_reference_select_create
drush en entity_reference_select_create -y
```

Only requires Drupal core (`^10 || ^11`). No contrib deps, no sub-modules, no permissions of its
own, no Drush commands, no config/settings page.

## Enable it on a field

Plugin `EntityReferenceSelectCreateWidget` (id **`entity_reference_select_create`**, label
*"Select list with create button"*) applies to **`entity_reference` fields** and is a
multiple-values widget (`multiple_values = TRUE`).

UI path: *Structure → (entity type) → (bundle) → Manage form display* → set the reference field's
widget to **"Select list with create button"** → click the gear to set the options below.

## Widget settings (`defaultSettings()` / `settingsForm()`)

| Setting | Default | Meaning |
|---|---|---|
| `target_bundle` | `''` | Which bundle the button creates. A `select` is shown **only when the field's `handler_settings['target_bundles']` has more than one entry**; with exactly one allowed bundle the widget uses it automatically. |
| `form_mode` | `'default'` | Form display mode rendered inside the modal. `settingsForm()` builds the option list from `EntityDisplayRepositoryInterface::getFormModes($target_type)` plus `default`. |
| `button_label` | `'Add'` | Text on the create button. |

Inherited select settings come from `OptionsSelectWidget` (via `parent::settingsForm()`).
`settingsSummary()` appends the form mode and button label to the standard summary.

Note: these widget settings have **no config schema** in the module, so strict config-schema
tooling may flag the form-display config; the settings still save and work.

## What the widget renders (`formElement()`)

1. Calls `parent::formElement()` to build the core select element.
2. Resolves the bundle: the `target_bundle` setting, or — if empty and the field allows exactly one
   bundle — that single `target_bundles` entry. If no bundle can be resolved, it returns the plain
   select with **no** button.
3. Reads `target_type` from the field storage, `form_mode` and `button_label` from settings.
4. Builds a URL to route **`entity_reference_select_create.modal_form`** with
   `{entity_type, bundle, form_mode, field_name}`.
5. Adds `data-ersc-field="{field_name}"` to the select's attributes and appends an `#suffix`: an
   `<a class="button use-ajax" data-dialog-type="modal" data-dialog-options="…">` link. The URL,
   dialog options JSON (`{"width":500,"modal":true}`) and button label are passed through
   `htmlspecialchars()`.
6. Attaches libraries `core/drupal.dialog.ajax` and
   `entity_reference_select_create/entity-reference-select-create`.

## The modal route & controller

Route (`entity_reference_select_create.routing.yml`):

```
entity_reference_select_create.modal_form
  path: /admin/entity-reference-select-create/{entity_type}/{bundle}/{form_mode}/{field_name}
  _controller: EntityReferenceSelectCreateController::form
  _permission: access content
```

`EntityReferenceSelectCreateController::form(entity_type, bundle, form_mode, field_name)`:

- Validates the **entity type** (`entityTypeManager()->getDefinition()`, catches
  `PluginNotFoundException`).
- Validates the **bundle**: if the entity type has a bundle entity type, the bundle must load.
- Validates the **field_name**: scans `EntityFieldManagerInterface::getFieldMap()` for an
  `entity_reference` field of that name whose storage `target_type` matches `entity_type` and whose
  `handler_settings['target_bundles']` is `NULL` (all bundles) or includes `bundle`.
- Creates the entity (`storage->create([bundle_key => bundle])`) and enforces
  **`$entity->access('create', $this->currentUser())`** — an editor lacking create permission for
  the target type/bundle gets an error message, not the form.
- Normalizes `form_mode`: an unregistered mode falls back to `default`; if the requested mode has no
  registered form class, the entity type's `default` form class is registered on the fly for it.
- Returns `entityFormBuilder()->getForm($entity, $form_mode)` — the target entity's **standard
  creation form** for that form mode.

## Submit & AJAX round-trip

`hook_form_alter()` in `entity_reference_select_create.module` runs only when the current route is
`entity_reference_select_create.modal_form`. It:

- hides `advanced`, `revision_log`, `meta`, `menu`, `footer` form regions (`#access = FALSE`);
- adds `#ajax` (callback `entity_reference_select_create_modal_submit`, event `click`) to
  `actions['submit']`;
- stores the field name in form state.

`entity_reference_select_create_modal_submit()` returns an `AjaxResponse`. On no validation errors
it reads the just-saved entity from the form object and adds two commands: `CloseDialogCommand`
and `SelectCreateOptionCommand($field_name, $entity->id(), $entity->label())`.

`SelectCreateOptionCommand::render()` emits `{command: 'entityReferenceSelectCreate', field_name,
id, label}`. Client-side (`js/entity-reference-select-create.js`), the matching
`Drupal.AjaxCommands.prototype.entityReferenceSelectCreate` finds every
`select[data-ersc-field="…"]` (via `CSS.escape`) and appends `new Option(label, id, true, true)` —
a selected, default-selected option. The reference is persisted when the **host** form is saved.

## Form modes

To limit which fields appear in the modal, create a dedicated form display mode for the referenced
entity type at *Structure → (entity type) → Manage form display → Add form mode*, then enter its
machine name in the widget's **Form mode** setting. If that mode has no form class, the controller
falls back to the default form automatically.
