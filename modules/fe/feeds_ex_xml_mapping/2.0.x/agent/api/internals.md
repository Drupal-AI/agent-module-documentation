# Internals (for custom code)

Three small classes plus two procedural hooks in `.module`. Nothing here is a public API you would
call directly; this documents how the override is wired so you can extend or debug it.

## Hooks (`feeds_ex_xml_mapping.module`)

- `hook_feeds_parser_plugins_alter()` — replaces the XML parser plugin's `form['feed']` class with
  `Drupal\feeds_ex_xml_mapping\Feeds\Parser\Form\XmlParserFeedForm`, so the per-feed form is used on
  Feed add/edit.
- `hook_form_feeds_mapping_form_alter()` — on the feed type *Mapping* form, and only when the parser
  id is `xml`, adds the *Override mapping per feed* details with the `source` /
  `source_configuration` checkboxes; prepends `feeds_ex_xml_mapping_form_feeds_mapping_form_submit`
  which persists them as third-party settings on the feed type.

## `Feeds\Parser\Form\XmlParserFeedForm` (extends `ExternalPluginFormBase`)

The per-feed form. `const MODULE_NAME = 'feeds_ex_xml_mapping'` (third-party-settings namespace).

- `buildConfigurationForm(form, form_state, ?FeedInterface $feed)` — returns `[]` (no form) unless
  the feed type has `source` enabled. Builds the *Context* field and the per-target XPath table. Uses
  hidden `#parents` under `plugin → parser → mappings → {field} → xpath|map|skip|unique|settings` so
  the values slot into the feeds parser's expected structure. For configurable targets (with
  `source_configuration` on) it instantiates the target plugin via
  `plugin.manager.feeds.target` and embeds its `buildConfigurationForm()`.
- `validateConfigurationForm()` — delegates to each feed-type plugin implementing
  `MappingPluginFormInterface::mappingFormValidate()`; skips if no mappings submitted.
- `submitConfigurationForm()` — rebuilds the submitted values into the feed-type-style structure
  (`context`, `mappings`, `custom_sources`, per-target `unique`/`settings`) and stores them on
  `$feed->get('config')` under key `xml_parser`. Custom source ids are `xpath_{field}_{property}`.

## `Util\XmlMappingHelper` (static helpers)

- `getMappingsFromFeedType(FeedTypeInterface): array` — reads the feed type's current mappings +
  parser sources/custom_sources and returns them in the same custom shape the per-feed form stores,
  so a **new** feed's form can be pre-populated with the type's defaults.
- `getFieldMappings(string $field_name, array $mappings): array` — pulls one target's entry out of a
  stored mappings array.

## `EventSubscriber\UpdateMappingsSubscriber`

Subscribes to `FeedsEvents::INIT_IMPORT` at priority **1024** (runs before feeds_ex's own lazy
subscriber and before parsing). `updateMappings(InitEvent $event)`:

- Only acts when the feed type's parser id is `xml`.
- Reads `$feed->get('config')[0]['xml_parser']`; returns early if empty (no override for this feed).
- Calls `$feed_type->setMappings($mappings['mappings'])`, `$feed_type->set('custom_sources', …)`,
  and overwrites `parser_configuration.context.value`. If a legacy `sources` key is present it also
  sets `sources` / `parser_configuration['sources']` (compat with feeds_ex issue #3209655).

The mutation is on the in-memory feed type for that import run only; the persisted feed type config
is not changed.
