<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Sitestudio component processor

## Enable it
1. Ensure Acquia Site Studio and Search API are installed and an index exists.
2. On the index's **Fields** UI, add a field for the property **Sitestudio Components** (`sitestudio_components_value`, type `search_api_html`).
3. Adding the field auto-activates the processor `sitestudio_component_item`; it runs on the next index operation.

## Per-field configuration (`SitestudioComponentsProperty::buildConfigurationForm`)
- **Enable all sitestudio components** (`sitestudio_components.all_components`) — default TRUE; indexes text from every component.
- Vertical tabs per `cohesion_component_category`, each with:
  - **Enable full <category> category** (`components[<cat>:<class>].full_category`)
  - Per-component checkboxes to include a single component's text.
- Custom components come from `cohesion_elements.custom_component.discovery`; config components from `cohesion_component` storage.

## Extraction logic (`SitestudioComponentsItem::addFieldValues`)
- Finds `cohesion_entity_reference_revisions` fields on the item's node.
- Loads the referenced `cohesion_layout`, decodes JSON with `LayoutCanvas::getJsonValuesDecodedArray()`.
- `retrieveComponentsUuid()` selects component UUIDs per config (all / category / single, recursing into children).
- `retrieveComponentsInfoFromUuid()` reads the canvas `model`, skips `settings`/numeric/media-reference/single-word values, strips tags and decodes entities from richtext (`{text: ...}`), concatenates the rest.
- Everything is wrapped in `try/catch (\Throwable)`: logs an error, and during post-request ("index immediately") indexing adds a warning so the item is re-indexed at cron instead of marked done.

## Agent notes
- The plugin is `hidden`+`locked`: you don't enable it directly, you add its property as a field.
- No config schema of its own beyond the per-field processor settings.
