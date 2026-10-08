<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, Twig function & resolution mechanism

Service id `entity_fallback_value.manager` → `Drupal\entity_fallback_value\Service\EntityFallbackValueManager`
(`entity_fallback_value.services.yml`). It extends Twig's `AbstractExtension` and is tagged
`twig.extension`. Constructor args: `entity_fallback_value.plugin_manager`, `language_manager`,
`entity.repository`. It caches per-entity resolved values in a `\WeakMap` and reads the current
langcode once at construction.

## Install / enable

`drush en entity_fallback_value`. No config, no permissions. Enable **Token** too if you want the
token integration (see [tokens.md](tokens.md)); the token hook autowires the `token` service.

## Public methods (`EntityFallbackValueManager`)

- `getEntityFallbackValues($content_entity, $keys = NULL, $definitions = NULL): array`
  — the main entry point. Returns `[]` unless `$content_entity` is a `ContentEntityInterface`.
  If `$definitions` is an array → custom chains (`getEntityCustomFallbackValues()`); otherwise →
  the plugin-provided defaults (`getEntityDefaultFallbackValues()`).
- `getEntityCustomFallbackValues($content_entity, array $definitions = [], $keys = NULL)`
  — resolves the caller-supplied `['<key>' => ['<path1>', '<path2>', …], …]` map.
- `getEntityDefaultFallbackValues($content_entity, $keys = NULL): array`
  — merges the definitions of every plugin whose `applies()` matches this entity (see
  [plugin-type.md](../plugins/plugin-type.md)); result is memoized in the `\WeakMap`.
- `getTwigEntityFallbackValues($content_entity = NULL, $keys = NULL, $definitions = NULL, $use_current_language = TRUE)`
  — the Twig callback (registered by `getFunctions()` as `getEntityFallbackValues`). When
  `$use_current_language` is TRUE it returns `[]` if the entity has no translation in the current
  language, otherwise it calls `getTranslation($currentLangCode)` first, then delegates to
  `getEntityFallbackValues()`.
- `getOnlyKeys()` (protected) — with `$keys` set, filters the result via
  `array_intersect_key(..., array_flip($keys))`.

### PHP example

```php
$mgr = \Drupal::service('entity_fallback_value.manager');
$definitions = ['title' => ['field_override_title.value', 'title.value']];
$values = $mgr->getEntityCustomFallbackValues($node, $definitions);
// $values['title'] = first non-empty resolved value.
```

### Twig example

```twig
{% set data = getEntityFallbackValues(node) %}          {# plugin defaults #}
{{ data.title }}
```

## Resolution mechanism (`Traits\AccessNestedFieldsTrait`)

Used by both the manager and every plugin base. Given `['<key>' => [<path>, <path>, …]]`:

- `getEntityFallbackValuesFromDefinitions()` iterates keys → `getFallbackValue()`.
- `getFallbackValue()` tries each path in order; returns the first value that is **not** `empty()`;
  returns `NULL` if none match. Exceptions from a path are **swallowed** (`catch (\Exception) {}`),
  so a bad/missing path just falls through to the next.
- `getDefinitionValue()` — if the path `is_callable`, it is invoked as
  `call_user_func($callback, $content_entity, $key)` (`getValueFromCallback()`); otherwise the
  string path is split on `.` and walked by `getFieldValue()`.
- `getFieldValue()` recurses field-by-field: `reset()` the first segment, `$parent->get($field)`,
  reduce via `getFieldItemValue()`, then recurse into the remaining segments.
- `getFieldItemValue()` reduces a value to a leaf: an entity-reference list →
  `reset(referencedEntities())` (each passed through
  `entityRepository->getTranslationFromContext()`); a `ListInterface` → `->first()`; a
  `FieldItemInterface` → `->getValue()` (an array like `['value' => …]`); a `PrimitiveBase` →
  `->getValue()` (a scalar). A terminal `.value`/`.target_id`/etc. segment therefore yields a
  scalar string.
- `addDefinition(array &$defs, $definition, int $weight = 0)` — helper to splice a path into a
  definitions list at a position.

Notes: values are read straight from the field/typed-data API (`->get()`, `referencedEntities()`),
including across entity-reference hops; this is a developer/render helper, not an access layer.
Callables in a chain are developer-supplied code, not user/config input.
