<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Babel — translation-type plugins

A translation-type plugin is a backend adapter: it knows how to *read* source strings and their existing
translations from a backend, and how to *write* a translation back. Babel itself stores nothing but the
index/status/lock tables; the plugin owns the real storage.

## Discovery
- Namespace: `Plugin\Babel\TranslationType`. Attribute: `#[TranslationType(id, label, status = TRUE, deriver = NULL)]`
  (`src/Plugin/Babel/TranslationType.php`).
- Manager: `Drupal\babel\Plugin\Babel\TranslationTypePluginManager` (service, parent `default_plugin_manager`,
  extra arg `@config.factory`). Alter hook: `hook_babel_translation_type_info(&$definitions)` (`babel.api.php`).
- Interface: `TranslationTypePluginInterface` — `getStrings(string $langcode, array $ids = []): array`
  (returns `Model\StringTranslation[]` keyed by source id) and
  `updateTranslation(StringTranslation $string, string $id, string $langcode, string $translation): void`.
  Extends `ConfigurableInterface` (plugins carry configuration). Base class `TranslationTypePluginBase`
  wires `BabelStorageInterface` + `StringsCollectorFactory` and syncs discovered sources into the index.
- `status` attribute arg is the default active-state a plugin suggests for its newly discovered sources.
- A plugin implementing `PluginFormInterface` gets a config subform on the Babel settings page.

## Model objects (`src/Model/`)
- `Source` — `string`, `context`; `getHash()` is the sha-256 of string+context and is the join key across
  the whole system. `status` = active flag. Plural variants are joined with `PoItem::DELIMITER`.
- `StringTranslation` — pairs a `Source` with an optional `Translation`; `getSourcePluralVariants()`,
  `getTranslatedPluralVariants()`, `isPlural()`, `isLocked()`.
- `Translation` — the target-language string.

## Built-in plugins
### `locale` — `TranslationType\Locale`
Bridges to the Locale module. Reads/writes via `locale.storage` (`StringStorageInterface`); source id is the
locale `lid`. Also exposes `updateCustomizedStatus($id, $langcode, $isLocked)` so locking a Babel translation
marks the `locales_target` row customized (called from `BabelTranslateForm::updateLocaleCustomizedStatus`).

### `config` — `TranslationType\Config`
Bridges to the configuration system. Reads translatable strings from config objects (via
`BabelConfigTranslatables`) and writes translations to the language config override storage
(`ConfigurableLanguageManagerInterface`). Covers config that core's Locale UI does not expose. Webform
configs are deliberately excluded at install.

## Adding a plugin
Create `Plugin\Babel\TranslationType\MyType` extending `TranslationTypePluginBase`, annotate with
`#[TranslationType(id: 'my_type', label: new TranslatableMarkup('My type'))]`, implement `getStrings()` /
`updateTranslation()`. Return `StringTranslation` objects built from `Source`/`Translation`; the base class
records each source in `babel_source`/`babel_source_instance`. A plugin can use a `deriver` to expose one
plugin instance per sub-target (see `babel_content_entity`'s `content_entity:<entity_type>` derivatives).

Multiple plugins may map to the same source hash (the same string appearing in code *and* config); saving a
translation for that hash writes it to **every** instance across all owning plugins
(`BabelTranslateForm::updateTranslation` loops `getSourceStringInstances($hash)`).
