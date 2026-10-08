# What Layout Builder ST overrides in core

The module adds no plugin type; it makes translation work by **decorating and replacing** core
Layout Builder services, plugins, and classes. Useful when debugging conflicts (e.g. another
module also overriding these) or extending behaviour.

## Services (`layout_builder_st.services.yml`)

| Service | Type | Purpose |
|---|---|---|
| `access_check.entity.layout_builder_translation_access` | access_check `_layout_builder_translation_access` | Allows the translate routes only on a translation (not the original). |
| `layout_builder.translate_block_component_subscriber` (`ComponentPluginTranslate`) | event_subscriber | Swaps translated component configuration in for the active language at render. |
| `layout_builder.route_subscriber` (`RouteSubscriber`) | event_subscriber | Alters core layout_builder routes. |
| `Drupal\layout_builder_st\DependencyInjection\ClassResolver` | **decorates** `class_resolver` | Lets the module substitute its own classes. |

## Plugin / class replacements (hooks in `layout_builder_st.module`)

| Core thing | Replaced with | Hook |
|---|---|---|
| `entity_view_display` entity class | `LayoutBuilderEntityViewDisplay` (auto-adds the translation field) | `hook_entity_type_alter()` |
| `layout_builder` entity form class (per fieldable type) | `OverridesEntityForm` | `hook_entity_type_alter()` |
| `block_content` `layout_builder_translate` form | `BlockContentInlineBlockTranslateForm` | `hook_entity_type_alter()` |
| `inline_block` block plugin class | `InlineBlock` (translation-aware) | `hook_block_alter()` |
| `overrides` section storage | `OverridesSectionStorage` (implements `TranslatableSectionStorageInterface`) | `hook_layout_builder_section_storage_alter()` |
| `layout_builder` render element | `Element\LayoutBuilder` | `hook_element_plugin_alter()` |
| `layout_builder_widget` field widget | `LayoutBuilderWidget` (+ accepts `layout_translation` field type) | `hook_field_widget_info_alter()` |

Note the module also runs `hook_module_implements_alter()` to force its
`hook_entity_type_alter()` to run **after** `layout_builder_entity_type_alter()`.

## Field type & data type

- Field type plugin `layout_translation` (`LayoutTranslationItem`, `no_ui`, cardinality 1,
  list class `LayoutTranslationItemList`).
- Data type `layout_translation` (`LayoutTranslationData`).
- Key constants: `OverridesSectionStorage::FIELD_NAME` (core override field
  `layout_builder__layout`) and `OverridesSectionStorage::TRANSLATED_CONFIGURATION_FIELD_NAME`
  = `layout_builder__translation`.

## Compatibility

`hook_requirements()` / `hook_modules_installed()` block coexistence with
`layout_builder_at` (Asymmetric Translations). If both are enabled the site shows a
requirements error — uninstall one.

## Extending

Because the section storage implements `TranslatableSectionStorageInterface` and behaviour is
driven by class replacement, extend by decorating the same services or subclassing the
replacement classes via the (decorated) `class_resolver`; there is no dedicated hook/plugin
API surface beyond the core Layout Builder one.
