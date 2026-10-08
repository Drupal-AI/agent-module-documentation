<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AutoConfigFormBase — building a schema-driven settings form

Class: `Drupal\auto_config_form\AutoConfigFormBase` in `src/AutoConfigFormBase.php`, `abstract`,
extends `\Drupal\Core\Form\ConfigFormBase`. `composer require drupal/auto_config_form` and enable
the module; it has no dependencies and nothing to configure itself.

## Minimal usage

1. Your module already has a config object with a schema, e.g. `config/schema/my_module.schema.yml`:

   ```yaml
   my_module.settings:
     type: config_object
     label: 'My module settings'
     mapping:
       foo:
         type: string
         label: 'How much foo?'
       bar:
         type: boolean
         label: 'Whether to run bar.'
   ```

2. Create `src/Form/ConfigForm.php`:

   ```php
   namespace Drupal\my_module\Form;
   use Drupal\auto_config_form\AutoConfigFormBase;
   class ConfigForm extends AutoConfigFormBase {
     protected function getSchemaKey(): string {
       return 'my_module.settings';
     }
   }
   ```

3. Add your own route + access + optional menu link (the module ships none):

   ```yaml
   my_module.settings:
     path: '/admin/config/my-module/settings'
     defaults:
       _form: 'Drupal\my_module\Form\ConfigForm'
       _title: 'My module settings'
     requirements:
       _permission: 'administer site configuration'
   ```

That is the whole integration. `getFormId()` returns the literal `'settings_form'` — override it if
you mount more than one such form.

## The one abstract method

- `getSchemaKey(): string` — the config object name to edit. It feeds `getEditableConfigNames()`
  (returns `[$this->getSchemaKey()]`), `getImmutableConfig()` (`configFactory->get()`), and
  `getEditableConfig()` (`config()` — always without overrides). This key is set in your PHP
  subclass; it is never taken from the request.

## How the form is built

- `create()` pulls the `config.typed` service into `$this->typedConfigManager` (throws
  `RuntimeException` if missing).
- `buildForm()` calls `typedConfigManager->getDefinition(getSchemaKey())` and loops
  `$schema['mapping']`, skipping `langcode` and `_core`, then delegates to
  `createFormElementFromConfigSchemaDefinition($key_path, $definition)`.
- That method `match`es `$definition['type']`:
  - `string` → `buildStringElement()` → `#type => textfield`
  - `boolean` → `buildBooleanElement()` → `#type => checkbox`
  - `integer` | `float` → `buildNumberElement()` → `#type => number` (+ `Range` → `#min`/`#max`)
  - `mapping` → `buildGroupElement()` → `#type => fieldset`, `#tree => TRUE`, recurses into children
  - default → `buildNotImplementedElement()` → a read-only `container` explaining the type is
    unsupported and linking the issue queue; it prints default/original/overridden values escaped
    with `htmlspecialchars()`.

## Common element attributes (`getCommonElementAttributes()`)

Applied to string/boolean/number elements:

- `#title` ← `definition['title'] ?? definition['label']`.
- `#default_value` ← current editable config value at the dotted key path.
- `#description` ← schema `description` (or `label`) plus any override message, joined with `<br>`.
- `#config_target` ← `"<schema_key>:<dotted.key.path>"` — this is what lets core's `ConfigFormBase`
  save the value, so **you do not write a `submitForm()`**.
- Constraints: `Length` → `#maxlength`; `NotBlank` / `NotNull` → `#required`.

## settings.php overrides

`createFormElementFromConfigSchemaDefinition()` compares the immutable config value
(`ImmutableConfig::get()`, which includes overrides) with `ImmutableConfig::getOriginal(..., FALSE)`.
`getOverriddenMessage()` returns an inline note (`This config value is overridden as: <code>…</code>`)
when they differ, so admins see that editing the field will not change the effective (overridden)
value.

## Customizing

Override any `build*Element()` method to change a single widget type, or override `buildForm()`
itself to add extra elements around the generated ones. `buildActionsElement()` produces the
standard "Save configuration" submit button.

## Notes

- The generated fields come straight from your schema `mapping`, so document keys with `label` /
  `title` / `description` to get labeled, described fields.
- Sequences and other complex types are not implemented — they render the read-only placeholder,
  not an editable widget.
- Drupal 10 vs 11: the branches differ only in how `$typedConfigManager` is typed; on Drupal 10 use
  the 1.x branch, on Drupal 11 use 2.x.
