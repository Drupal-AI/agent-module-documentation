<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `empty_fields` plugin type

Empty Fields defines its own plugin type so you can add custom empty-field renderers.

## Plugin infrastructure

| Piece | Value |
|---|---|
| Plugin manager service | `plugin.manager.empty_fields` (`EmptyFieldsPluginManager`, `parent: default_plugin_manager`) |
| Annotation | `@EmptyField` (`Drupal\empty_fields\Annotation\EmptyField`, keys `id`, `label`) |
| Plugin namespace | `Plugin/EmptyFields` (in any module) |
| Base class | `EmptyFieldPluginBase` (implements `EmptyFieldPluginInterface`, `ConfigurableInterface`) |
| Interface | `EmptyFieldPluginInterface` |

## Methods to implement

- `react(array $context)` — **required**; return a render array shown in place of the empty
  field. `$context` includes `entity`, `display`, `view_mode`, `field_name`.
- `settingsSummary()` — **required**; short text shown on the Manage display summary line.
- `settingsForm(array $form, FormStateInterface $form_state)` — optional; return a settings form
  (its values are saved under the component's `third_party_settings.empty_fields.settings` and
  passed back as `$this->configuration`).
- `defaultConfiguration()` — optional; default settings.

Configuration flows through `ConfigurableInterface`
(`getConfiguration`/`setConfiguration`/`defaultConfiguration`), merged via `NestedArray::mergeDeep`.

## Example

```php
namespace Drupal\my_module\Plugin\EmptyFields;

use Drupal\empty_fields\EmptyFieldPluginBase;

/**
 * @EmptyField(
 *   id = "dash",
 *   label = @Translation("Em dash")
 * )
 */
class EmptyFieldDash extends EmptyFieldPluginBase {
  public function react(array $context) {
    return ['#markup' => '—'];
  }
  public function settingsSummary() {
    return $this->t('Shows an em dash for empty values');
  }
}
```

Clear caches and the new handler appears in the "Empty value behavior" select on every field's
formatter settings.

## Reference plugins (in the module)

- `text` (`EmptyFieldText`) — configurable `empty_text`, token-replaced in `react()`.
- `nbsp` (`EmptyFieldNbsp`) — returns `['#markup' => '&nbsp;']`.
- `broken` (`Broken`) — the hidden fallback used when a saved handler id no longer exists; it is
  excluded from the selectable options list.

## Config schema for plugin settings

Per-handler settings are validated by a dynamic schema type
`empty_fields.settings.[%parent.handler]` (e.g. `empty_fields.settings.text` → `empty_text`), so
a custom handler with settings should declare its own `empty_fields.settings.<id>` schema.
