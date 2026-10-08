<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ersv` selection plugin

`Drupal\ersv\Plugin\EntityReferenceSelection\SeparateSelectionAndValidation`
(`src/Plugin/EntityReferenceSelection/SeparateSelectionAndValidation.php`).

`@EntityReferenceSelection(id = "ersv", label = "Separate selection and validation",
group = "ersv", weight = 0)`. Extends core `SelectionPluginBase`; implements
`ContainerFactoryPluginInterface` and `SelectionWithAutocreateInterface`.

## Install / enable

`composer require drupal/ersv` then `drush en ersv`. Pulls in `drupal/ajax_dependency:^2.0`.
There is no settings page — the plugin is chosen and configured entirely in a field's settings.

## What it does

Core selection handlers use a single handler both to narrow the options a widget offers and to
validate the saved value. This plugin wraps **two** child handlers so those jobs can diverge —
typically a narrower *selection* than *validation* (e.g. offer only future events but accept any
event; or offer only reusable media but accept inline-created ones).

`__construct()` reads the field configuration and, when set, instantiates each child via
`createInstance()`:

- `$this->selectionPlugin`  ← `configuration['selection']['settings']['handler']` (+ `handler_settings`)
- `$this->validationPlugin` ← `configuration['validation']['settings']['handler']` (+ `handler_settings`)

`createInstance($pluginId, $configuration)` merges in `target_type` (from this plugin's own
`target_type`), `handler` and `entity => NULL`, then calls
`plugin.manager.entity_reference_selection->createInstance()` (service injected in `create()`).
Each child is therefore an ordinary core selection handler (`default`, `views`, `default:node`, …).

## Method delegation

- **Selection side** — `getReferenceableEntities($match, $match_operator, $limit)` and
  `countReferenceableEntities()` delegate to `$this->selectionPlugin` (empty array / `0` if none
  configured). This is what populates the widget's options / autocomplete.
- **Validation side** — `validateReferenceableEntities(array $ids)` and `entityQueryAlter(SelectInterface)`
  delegate to `$this->validationPlugin`. `entityQueryAlter()` also calls the parent first.
- **Autocreate** — `createNewEntity()` and `validateReferenceableNewEntities()` delegate to
  `$this->validationPlugin` only when it `instanceof SelectionWithAutocreateInterface`; otherwise
  they return `NULL` / `[]`. So autocreate follows the **validation** handler.
- `calculateDependencies()` merges the parent dependencies with each child handler's
  `calculateDependencies()` so config export tracks both handlers.

## Configuration array shape

`defaultConfiguration()` returns:

```
selection  => [ settings => [ handler => NULL, handler_settings => [] ] ]
validation => [ settings => [ handler => NULL, handler_settings => [] ] ]
target_bundles => []
```

The extra `settings` level is deliberate (comment in source): child plugin validation does not
use a subform state and expects that key. There is **no shipped config schema** — the field's
own storage/field config carries these values.

## Config form (`buildConfigurationForm()`)

Renders two fieldsets:

- **Selection** — *"Determines which items can be selected."*
- **Validation** — *"Determines which items are valid, even if they can no [longer] be selected
  anymore. Also, if applicable, which items can be created."*

Each fieldset has a required `handler` `select` whose options come from `handlerOptions()`, plus
a `handler_settings` container that embeds the chosen child handler's own
`buildConfigurationForm()`. `AjaxDependency::dependsOn()` (from `ajax_dependency`) wires each
`handler` select to its `handler_settings` so switching the handler rebuilds the nested settings.

`handlerOptions()` calls `SelectionPluginManager::getSelectionGroups($targetType)`, **skips the
`ersv` group itself** (no recursion), and lists only base plugins (`default`, `views`, …) or the
`group:target_type` variant, running each label through `Html::escape()`.

## Validation (`validateConfigurationForm()`)

For each of `selection` and `validation`, if a child handler was chosen it builds a
`SubformState` for that handler's `handler_settings` and calls the child's
`validateConfigurationForm()`. For the `validation` branch it additionally copies the child's
resolved `target_bundles` up to `settings.handler_settings.target_bundles` — matching the shape
`inline_entity_form`'s `InlineEntityFormSimple::isApplicable()` expects.

## Notes

- The whole point is that **validation can be broader than selection**; a value accepted by the
  validation handler but not offered by the selection handler is valid by design (e.g. autocreate
  or inline-entity-form flows). Reference access and query access are whatever the chosen child
  handlers enforce — identical to using those handlers directly.
- No plugin is configured ⇒ selection returns no options and validation accepts nothing; both
  handlers must be set for a working field.
