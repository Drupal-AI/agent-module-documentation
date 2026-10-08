<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extraction plugin system & the four built-in extractors

## Aggregation flow

`ClassesExtractorManager::getAllClasses()` (service `classes_extractor.manager`):

1. `\Drupal::service('plugin.manager.classes_extractor')->getDefinitions()` — discover all
   `@ClassesExtractor` plugins.
2. For each: `createInstance($id)->getClasses()` (returns `array`).
3. Each returned class string is `preg_split('/[\s|]+/', $class)` and merged.
4. `array_unique(array_filter($classes, 'strlen'))` → `implode(' ', …)` — returns one
   **space-separated string** of unique, non-empty tokens.

Both the API controller (`getClasses()`) and the Drush command (`cec`) call `getAllClasses()`.
The Drush command additionally writes the string to the configured `file_path`.

## The recursive config-walker: `recursiveGetClasses(array $settings, array &$classes)`

Shared helper used by the entity-display and views plugins. It walks a config array and, for
non-array leaves:

- If the **key** contains the substring `class` or `classes` and the value is a non-empty string:
  if the value contains newlines, each line is split and, for lines shaped `something|label`, only
  the part before `|` is kept (per line); lines are re-joined with spaces; the value is appended.
- If the **key** contains `attributes` and the value is a string shaped like
  `class|test best,data-id|2`, it splits on `,` then `|`, and for pairs whose first element is
  exactly `class` merges the space-split second element into the class list.

Note: the substring match is loose (any key containing "class" matches, e.g. `classname`,
`css_class`, `field_class_list`).

## Built-in plugins (`src/Plugin/ClassesExtractor/`)

| Plugin id | Reads | Notes |
|-----------|-------|-------|
| `ds_classes_extractor` (`DsClassesExtractor`) | `\Drupal::config('ds.settings')->get('classes')` → merges `['region']` + `['field']` | Display Suite global classes. No `moduleExists('ds')` guard — returns `[]` harmlessly if `ds.settings` is empty/absent. |
| `editor_formatter_classes_extractor` (`EditorFormatterClassesExtractor`) | `FilterFormat::load('basic_editor')` → `filter_html` filter's `settings.allowed_html`; regex `class="([^"]*)"` over it | **Hard-codes the format id `basic_editor`.** If that format doesn't exist, `$filterFormat` is `NULL` and `->filters(...)` throws a fatal — see caveat below. |
| `entity_display_classes_extractor` (`EntityDisplayClassesExtractor`) | all `entity_view_display` entities: `getComponents()`, DS third-party `fields`/`layout`/`regions`, `field_group` third-party settings, and (if `layout_builder` enabled) `layout_builder` `sections` | Uses `recursiveGetClasses()` on each; iterates Layout Builder `SectionComponent::get('configuration')`. Injects `ClassesExtractorManager` + `entity_type.manager` via `ContainerFactoryPluginInterface`. |
| `views_classes_extractor` (`ViewsClassesExtractor`) | all `view` config entities via `recursiveGetClasses($view->toArray(), …)` | Collects CSS classes configured on Views (row/field/style class options). |

### Functional caveats worth knowing

- `EditorFormatterClassesExtractor` will **fatal** on any site lacking a text format literally named
  `basic_editor` (no null check before `->filters()`). Because `getAllClasses()` has no per-plugin
  try/catch, one throwing plugin breaks the whole endpoint/command.
- `EntityDisplayClassesExtractor::getClasses()` references `$layoutBuilderSections` in a `foreach`
  even when `layout_builder` is disabled (the variable is only assigned inside the
  `moduleExists('layout_builder')` branch) → undefined-variable warning / `foreach` on null on
  sites without Layout Builder.
- `ViewsClassesExtractor` does `$classes[] = $this->classExtractorManager->recursiveGetClasses(...)`;
  `recursiveGetClasses()` returns `void`, so it appends `NULL` entries (filtered out later by
  `array_filter('strlen')` during aggregation). Harmless but sloppy — the actual collection happens
  via the `&$classes` reference it passes.

## Adding a custom extractor

Drop a class into `src/Plugin/ClassesExtractor/` (or any module's) namespace `Plugin/ClassesExtractor`:

```php
namespace Drupal\my_module\Plugin\ClassesExtractor;

use Drupal\classes_extractor\ClassesExtractorBase;

/**
 * @ClassesExtractor(
 *   id = "my_classes_extractor",
 *   label = @Translation("My Classes Extractor")
 * )
 */
class MyClassesExtractor extends ClassesExtractorBase {
  public function getClasses(): array {
    return ['my-class another-class'];
  }
}
```

Return either individual tokens or space/`|`-separated strings; the manager splits and dedupes.
For services, implement `ContainerFactoryPluginInterface::create()` (as the entity-display/views
plugins do). No config UI to register plugins — discovery is automatic once the module is enabled
and caches are cleared. Definitions are cached in `cache.default` under `classes_extractor_plugins`.

## Output / consumption

- `drush cec` writes the space-separated list to the `file_path` config value (raw, as stored — the
  form's `DRUPAL_ROOT . '/'` prefix is display-only and is **not** prepended by the command, so the
  effective target is whatever string the admin saved, relative to the Drush CWD if not absolute).
- `GET /api/v1/classes-extractor` (needs `administer site configuration`) returns
  `{"classes":"…"}` as a cacheable JSON response.
