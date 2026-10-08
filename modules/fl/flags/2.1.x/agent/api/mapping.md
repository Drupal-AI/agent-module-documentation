# Flags API: theme hook, mapping services, config entities

## The `flags` theme hook
Registered by `FlagsHooks::theme()` (invoked via `flags_theme()` in `flags.module`). Render a flag
from a code:
```php
$build['flag'] = [
  '#theme' => 'flags',
  '#code' => 'fr',          // country or language code
  '#source' => 'country',   // 'country' | 'language' (or any 'flags.mapping.X' service)
  // optional: '#tag' => 'span', '#attributes' => [...]
];
$build['#attached']['library'][] = 'flags/flags';  // needed for the sprite CSS
```
`flags_preprocess_flags()` calls `flags.mapping.{source}->map($code)`, adds classes `flag` and
`flag-<mappedcode>`, plus any extra classes from the mapping service. An unknown `source` (no
matching `flags.mapping.{source}` service) throws `\InvalidArgumentException`. The template
(`templates/flags.html.twig`) emits an empty `<{{ tag }} {{ attributes }}></{{ tag }}>` (default
tag `span`) and self-attaches `flags/flags`.

## Mapping services
- `flags.mapping.country` → `Drupal\flags\Mapping\Country`
- `flags.mapping.language` → `Drupal\flags\Mapping\Language`

Both extend `BaseMapping` (`FlagMappingInterface`), constructed with `@config.factory`:
- `map($value)` → trim + lowercase the code; if a mapping config entity exists for it, return its
  `flag` (lowercased); else return the code itself.
- `getOptionAttributes(array $options)` → `Attribute` objects carrying `data-class` of
  `flag flag-<mapped>` (+ extra classes) for decorating select options.
- `getExtraClasses()` → extra CSS classes (used by subclasses/submodules).

## Mapping override config entities
- `country_flag_mapping` (config prefix `flags.country_flag_mapping.*`) and
  `language_flag_mapping` (`flags.language_flag_mapping.*`).
- Fields (schema `flags.schema.yml`): `source` (the input code, also the entity id/label via
  `FlagMapping::id()`/`label()`) and `flag` (the target flag/territory code). Abstract base
  `src/Entity/FlagMapping.php`; `setFlag()`/`setSource()` normalise. Access via
  `FlagMappingAccessController` → `AccessResult::allowedIfHasPermission('administer flag mapping')`.
- Create one to remap a code, e.g. language `en` → flag `gb`. Managed via the flags_ui submodule.

## FlagsManager & language helper
- `flags.manager` (`FlagsManager`): `getList()` returns 250+ `code => translated name` pairs
  (from `getStandardList()`, `natcasesort`-ed), run through `hook_flags_alter($list)` so other
  modules can add/remove entries.
- `flags.language_helper` (`FullLanguageManager`): merges predefined + site-configured languages.

## `hook_flags_alter`
```php
function mymodule_flags_alter(array &$flags) {
  $flags['xx'] = t('My territory');
}
```
