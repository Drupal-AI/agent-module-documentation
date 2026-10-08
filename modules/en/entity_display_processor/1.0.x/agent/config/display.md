<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, storage & the Manage-display UI

There is **no settings form and no config object of its own** — a processor choice is stored per
view display as a third-party setting, and the module only ships a schema plus a Field UI form
alter. Enable with `drush en entity_display_processor -y` (no dependencies).

## Where the choice is stored

On each `core.entity_view_display.<entity_type>.<bundle>.<view_mode>` config entity, under
third-party settings key `entity_display_processor` → `processor`:

```yaml
third_party_settings:
  entity_display_processor:
    processor:
      id: custom_classes
      settings:
        classes: 'my-class another-class'
```

`settings` is omitted when empty. Set/unset happens in `Hook\FieldUiForm::submit()` via
`setThirdPartySetting()` / `unsetThirdPartySetting()`.

## Schema — `config/schema/entity_display_processor.schema.yml`

- `core.entity_view_display.*.*.*.third_party.entity_display_processor` (mapping) → `processor`
  mapping with `id` (string) and `settings`, typed dynamically as
  `entity_display_processor_plugin.settings.[%parent.id]`.
- `entity_display_processor_plugin.settings.custom_classes` — mapping with a single `classes`
  string. **Each new plugin that has settings must add its own
  `entity_display_processor_plugin.settings.<plugin_id>` schema type** so config validates.

## The Manage-display form alter

`Hook\FieldUiForm` (`#[Hook('form_entity_view_display_edit_form_alter')]`,
`@see EntityViewDisplayEditForm`):

- Reads existing third-party settings from the display entity and builds a `details` element
  `entity_display_processor` (`#open` when a processor is already selected, `#tree = TRUE`).
- Inside it, `processor` is built by
  `Element\Drilldown::createElementFromPluginManager($title, $manager, $id, $sub_settings)`.
- Prepends a static submit handler `FieldUiForm::submit` to `$form['actions']['submit']['#submit']`
  so the processor id + settings are written into third-party settings before the display saves.
- `getEntityDisplay()` pulls the `EntityDisplayInterface` config entity from the form object.

This form is Field UI's display-edit form, so it is reachable only by users who can administer the
entity type's displays.

## The drilldown form element (internal)

`Element\Drilldown` (`#[FormElement('entity_display_processor_drilldown')]`, marked `@internal` —
may move/rename): a `select` of plugin ids plus an AJAX-swapped subform container.

- `createElementFromPluginManager()` builds the option list from
  `$plugin_manager->getDefinitions()` (`label` or the machine id) and uses
  `Callback\IdToSubform\PluginIdToSubform` as the `#create_subform` callback.
- `process()` builds the `select` (with `#empty_value = ''`), an AJAX handler using
  `Callback\ElementAjax\AjaxReplaceCallback` (wrapper id = `md5(serialize($parents))`), and a
  `container` `subform_container` whose `subform` is (re)built for the selected id.
- `PluginIdToSubform::__invoke($id, $settings, $subform_state)` calls
  `$pluginFactory->createInstance($id, $settings)` and, if the plugin is a `PluginFormInterface`,
  returns its `buildConfigurationForm()`; otherwise returns `[]`. On `PluginException` returns `[]`.
- `AjaxReplaceCallback::__invoke()` returns the sub-element via `NestedArray::getValue()` — a plain
  serializable callback object.

## Applying the effect

See [../plugins/entity_display_processor.md](../plugins/entity_display_processor.md): on entity view,
`Hook\EntityView::entityViewAlter()` loads the stored `{id, settings}` through the manager's
`getInstance()` and runs `process()` on the build.

## Test scaffolding (reference only, not shipped enabled)

`tests/modules/entity_display_processor_test` provides example plugins `WrapperDiv` /
`WrapperDivAlt`; kernel test `tests/src/Kernel/RenderTest` and
`tests/src/FunctionalJavascript/FieldUiTest` exercise rendering and the UI.
