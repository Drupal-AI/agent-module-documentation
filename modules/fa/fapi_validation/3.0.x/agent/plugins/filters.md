<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter plugins (FapiValidationFilter)

Plugin type discovered from `Plugin/FapiValidationFilter` in any module. Attribute:
`Drupal\fapi_validation\Attribute\FapiValidationFilter` (`id`, optional `label`, `description`, `deriver`); legacy
annotation `Drupal\fapi_validation\Annotation\FapiValidationFilter` also supported. Interface:
`FapiValidationFiltersInterface::filter($value): string`. Manager: `FapiValidationFiltersManager`.

Filters are declared as plain string ids in an element's `#filters` array. They run **before** validators
(`FapiValidationService::process` prepends the filter callback) and mutate the value in both `$element['#value']`
and `$form_state`. Each filter takes the current value and returns the transformed value.

## Bundled filters (src/Plugin/FapiValidationFilter/)

| id | behaviour (from source) |
|----|-------------------------|
| `numeric` | `preg_replace('/[^0-9]+/', '', $value)` — strip non-digits. |
| `trim` | trim leading/trailing whitespace. |
| `ltrim` | trim leading whitespace. |
| `rtrim` | trim trailing whitespace. |
| `machine_name` | transliterate → lowercase → `preg_replace` non-`[a-z0-9_]` to `_` (uses core `transliteration` service via DI). |
| `ucfirst` | uppercase first character. |
| `ucwords` | uppercase first character of each word. |
| `uppercase` | uppercase all characters. |
| `lowercase` | lowercase all characters. |
| `strip_tags` | `strip_tags($value)` — remove all HTML tags. |
| `html_entities` | `htmlentities(html_entity_decode($value))` — decode then re-encode entities. |

Filters transform submitted input for storage/normalisation convenience; they are input transforms, not a
substitute for escaping output at render time. `machine_name` is the one filter using dependency injection
(`ContainerFactoryPluginInterface`) to pull the `transliteration` service.

## Adding your own

Create `src/Plugin/FapiValidationFilter/YourFilter.php` implementing `FapiValidationFiltersInterface` with the
attribute, then reference its `id` in `#filters`. Example in [../api/rules-and-engine.md](../api/rules-and-engine.md).
