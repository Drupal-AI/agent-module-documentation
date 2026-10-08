<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Fallback Value (entity_fallback_value) — agent index

Developer API that resolves a **content-entity value from a prioritized list of field paths**
(first non-empty wins). A chain can traverse entity references and nested typed data with dot
syntax (`field_override_title.value`, `paragraph_thumbnail.field_description`) or contain a PHP
callable. Exposed via a service, a Twig function and tokens. Package `Custom`. License
GPL-2.0-or-later. Core `^8.8 || ^9 || ^10 || ^11`. Version 1.1.2.

- **No** config UI, **no** permissions, **no** config schema, **no** `.install`, **no** routes/forms,
  **no** own plugins. It is a plugin type + a service (Twig extension) + a token hook + a Drush generator.
- info.yml declares **no** dependencies, but the token hook (`src/Hook/Token.php`) autowires the
  `token` service — the **Token module must be enabled** for `[<entity>:efv_*]` tokens (and, in
  practice, for the module to build its container). Twig/PHP access do not need Token.

## Solution docs

- **The `entity_fallback_value.manager` service, the Twig function, and the field-resolution
  mechanism (`AccessNestedFieldsTrait`)** → [api/service.md](api/service.md)
- **The EntityFallbackValue plugin type (annotation, abstract base, plugin manager, `applies_on`)
  and the `drush generate plugin:entity_fallback_value` generator** → [plugins/plugin-type.md](plugins/plugin-type.md)
- **The token integration (`[<entity>:efv_<key>]`)** → [api/tokens.md](api/tokens.md)

## Provided services / plugins (from source)

- Service `entity_fallback_value.manager` → `Service\EntityFallbackValueManager` (a `twig.extension`;
  args: plugin manager, `language_manager`, `entity.repository`).
- Service `entity_fallback_value.plugin_manager` → `PluginManager\EntityFallbackValuePluginManager`
  (parent `default_plugin_manager`). Discovery dir `Plugin/entity_fallback_value`; annotation
  `EntityFallbackValuePluginAnnotation` (`id`, `applies_on`); interface
  `EntityFallbackValuePluginInterface`.
- Twig function `getEntityFallbackValues(entity, keys=null, definitions=null, use_current_language=true)`.
- Tokens `[<entity>:efv_<key>]` for keys returned by each plugin's `getEntityFallbackDefinitions()`.
- Drush generator `plugin:entity_fallback_value` (`src/Drush/Generators/`).
