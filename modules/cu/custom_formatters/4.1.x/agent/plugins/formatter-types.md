<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Formatters plugin types

The module defines **two** plugin types, both managed by `DefaultPluginManager` subclasses using
annotations.

## 1. `custom_formatters_formatter_type` — engines

- Manager: `FormatterTypeManager` (subdir `Plugin/CustomFormatters/FormatterType`, annotation
  `Drupal\custom_formatters\Annotation\FormatterType`, cache key
  `custom_formatters_formatter_type_plugins`).
- Base class: `FormatterTypeBase` (implements `FormatterTypeInterface`; optional
  `FormatterExtrasInterface`).
- Shipped engines: `Php`, `Twig`, `HTMLToken`, `FormatterPreset`.

Annotation fields (from the shipped `@FormatterType` docblocks): `id`, `label`, `description`, and
optionally `multipleFields` (e.g. PHP and Twig set `multipleFields = "true"` to receive all fields).

### Implementing an engine

Add `src/Plugin/CustomFormatters/FormatterType/MyEngine.php` extending `FormatterTypeBase`:

```php
/**
 * @FormatterType(
 *   id = "my_engine",
 *   label = "My engine",
 *   description = "…",
 * )
 */
class MyEngine extends FormatterTypeBase {
  // Render the field: return a render array or ['#markup' => ...].
  public function viewElements(FieldItemListInterface $items, $langcode, array $settings = []) { … }

  // Optional: label/config on the formatter add/edit form.
  public function settingsForm(array &$form, FormStateInterface $form_state): array { … }

  // Optional: CodeMirror mode for the `data` textarea (e.g. 'text/x-php', 'html_twig').
  protected function getCodeEditorMode(): ?string { return 'text/plain'; }

  // Optional: preview-tab debug options / data (see Php/Twig for the pattern).
  public function previewSettingsForm(): array { … }
}
```

The stored code/config is on `$this->entity->get('data')`. `$settings` is keyed by formatter-setting
field name (rendered), with `$settings['_raw']` holding unformatted values.

## 2. `custom_formatters_formatter_extras` — cross-cutting behavior

- Manager: `FormatterExtrasManager` (subdir `Plugin/CustomFormatters/FormatterExtras`).
- Base class: `FormatterExtrasBase` (interface `FormatterExtrasInterface`).
- Shipped: `Contextual`.

Formatter-extras plugins attach optional behavior/settings that apply across engines. Implement one the
same way (own annotation + base class) when you need to add shared options or alter processing without
writing a new engine.

## Field UI bridge (not a plugin type you implement)

`Plugin/Field/FieldFormatter/CustomFormatters` + `Plugin/Derivative/CustomFormatters` generate one core
field-formatter derivative per `formatter` config entity, which is how your engines appear in *Manage
display*. You don't implement these — creating a `formatter` entity is enough.
