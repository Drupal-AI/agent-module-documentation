<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# efs plugin type — `extra_field_formatter`

The core extension point. An "Extra field formatter" plugin renders one pseudo-field placed on an
entity view or form display.

## Discovery & manager

- Manager: `ExtraFieldFormatterPluginManager` (`src/ExtraFieldFormatterPluginManager.php`), service
  **`plugin.manager.efs.formatters`** (`efs.services.yml`, `parent: default_plugin_manager`).
- Discovery subdir `Plugin/efs/Formatter`, interface `ExtraFieldFormatterPluginInterface`,
  annotation `Drupal\efs\Annotation\ExtraFieldFormatter`. Alter hook **`extra_field_formatter_info`**
  (`alterInfo`), cache key `extra_field_formatter_plugins`.
- `processDefinition()` adds `provider_type` and `definition_path` (the provider module's path) to
  each definition.

## Annotation — `@ExtraFieldFormatter`

`src/Annotation/ExtraFieldFormatter.php` properties: `id`, `label` (Translation), `description`
(Translation), `supported_contexts` (array — any of `"display"`, `"form"`). Only plugins whose
`supported_contexts` include the current context appear in the add-field select
(`ExtraFieldAddForm::buildForm()`).

## Interface — `ExtraFieldFormatterPluginInterface`

Extends `PluginInspectionInterface` + `ContainerFactoryPluginInterface`. Methods:

- `view(array &$build, EntityInterface $entity, EntityDisplayBase $display, string $view_mode, ExtraFieldInterface $extra_field)`
  — return a render array (or `[]` to render nothing). Called from `efs_entity_view_alter()` /
  `efs_form_alter()`.
- `settingsForm(EntityDisplayFormBase $view_display, array $form, FormStateInterface $form_state, ExtraFieldInterface $extra_field, string $field)`
  — the per-placement configuration form shown in the Field UI cog.
- `settingsSummary(string $context)` — array of strings summarising current settings.
- `defaultContextSettings(string $context)` (static) — default settings, keyed by name.
- `isApplicable(string $entity_type_id, string $bundle)` — filters where the plugin may be added.

## Base class — `ExtraFieldFormatterPluginBase`

`src/ExtraFieldFormatterPluginBase.php` extends core `PluginSettingsBase` and gives working defaults:

- `create()` builds `new static($configuration, $plugin_id, $plugin_definition)` — override it to
  inject services (see stock `FieldMirror`, `View`, `TokenizerWysiwyg`).
- `view()` returns `[]`; `defaultSettings()` returns `['weight' => 0]`; `defaultContextSettings()`
  returns `[]`; `isApplicable()` returns `TRUE`.
- `settingsForm()` renders a single `weight` number field; `settingsSummary()` returns the plugin
  label + weight.
- Helper `getFieldDefinitionsAsOptions(EntityDisplayFormBase $view_display, $type = NULL)` — builds a
  select of the display's `FieldConfig` fields, optionally filtered by field type.
- Settings are held in `$this->settings`; the runtime hooks call `setSettings()` before `view()`.

## How to write a plugin

1. In your module, create `src/Plugin/efs/Formatter/MyThing.php` extending
   `ExtraFieldFormatterPluginBase`.
2. Annotate it:

   ```php
   /**
    * @ExtraFieldFormatter(
    *   id = "my_thing",
    *   label = @Translation("My thing"),
    *   description = @Translation("Renders my thing."),
    *   supported_contexts = { "display" }
    * )
    */
   ```

3. Implement `view()` to return a render array. **You own output safety and access**: escape
   variable text (e.g. `Html::escape()` / `#plain_text`, or a `#theme`/`#markup` of already-safe
   markup), and check field/entity access before rendering restricted data — the module does not do
   this for you.
4. Optionally override `defaultContextSettings()`, `settingsForm()`, `settingsSummary()`,
   `isApplicable()`, and `create()` for DI.
5. Rebuild caches. The plugin appears in the **Add extra field** form on Manage display / Manage form
   display for matching contexts/bundles.

## Runtime wiring (summary)

`efs_entity_view_alter()` and `efs_form_alter()` load the `extra_field` config entity for each
placement, `createInstance()` the plugin, apply its stored settings (falling back to
`defaultContextSettings()`), call `view()`, and inject the result into `$build[$name]` /
`$form[$name]` at the component's weight. View output is wrapped with `#cache max-age = PERMANENT`.
See [config/extra-fields.md](../config/extra-fields.md) for the full hook flow.
