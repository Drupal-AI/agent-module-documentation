<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Twig Formatter (custom_twig_formatter) — agent index

A single field formatter that renders a field by **evaluating admin-written Twig code**, with every
field on the entity exposed to that template as a variable. Package `Fields`. Depends only on core
**`field`**. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.1.0-alpha1.

- **The formatter: field types, settings, the render context, and how to set it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `CustomTwigFormatter` (id **`custom_twig_markup`**, label *"Custom Twig markup"*), in
  `src/Plugin/Field/FieldFormatter/CustomTwigFormatter.php`, extending core `FormatterBase`.
- Applies to a **wide list of core field types** (declared in the `@FieldFormatter` annotation):
  boolean, changed, created, comment, daterange, datetime, decimal, entity_reference, email, file,
  file_uri, image, integer, language, link, list_integer, list_float, list_string, float, string,
  string_long, text, text_long, text_with_summary, telephone, timestamp, uri.
- **No** field type, **no** widget, **no** routes, **no** permissions of its own, **no** services,
  **no** Drush, **no** hooks, **no** submodules. Config schema for the formatter setting is provided
  (`config/schema/custom_twig_formatter.schema.yml`).

## Mechanism (from source)

- `create()` injects `entity_type.manager`, `entity_field.manager`, the **`twig`** service, and
  `module_handler`.
- `defaultSettings()` = `['custom_twig_markup' => '']`. `settingsForm()` renders a **Twig code**
  `textarea` plus two read-only "Replacement patterns" detail lists documenting the available field
  variables for the bundle.
- `viewElements()` builds `$context` = every field on the entity keyed by field machine name
  (`$entity->getFields()`), plus `label` (the field label, or a `field_display_label` third-party
  override when that module exists). It then calls
  `$this->twig->createTemplate($this->getSetting('custom_twig_markup'))->render($context)` and emits
  the result as `#markup` in a `#type => 'markup'` element. For `file` fields it also attaches
  `file/drupal.file`.
- The Twig string is stored in the **view-display config entity** (`core.entity_view_display.*`),
  under the field's `settings.custom_twig_markup`; setting it requires the entity type's
  **"administer … display"** permission. It exports/imports with configuration.

## Settings (formatter, `defaultSettings()`)

`custom_twig_markup` (default `''`) — the Twig template string. Schema type `string`. Full detail,
the render-context variable list, and a config-export example in
[fields/formatter.md](fields/formatter.md).

## Notes / caveats

- The exception `catch (Twig_Error $error)` in `viewElements()` references the **Twig 1** class name,
  which does not exist under Drupal's Twig 3 (`\Twig\Error\Error`); a template error therefore is not
  caught by that block. Validate templates when authoring.
- Field variables are the raw `FieldItemList` objects, so templates typically use `{{ field_x.value }}`
  / `{{ field_x.0.value }}` (or field-type-specific properties) rather than the bare variable.
- The formatter is chosen per view display in *Manage display*; there is no global settings form.
