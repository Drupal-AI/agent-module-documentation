<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity View Mode Normalize adds serialization normalizers that render an entity through a Drupal view mode, so REST/Views/Search API output carries the view mode's configured, formatter-rendered fields rather than raw stored values.

---

Entity View Mode Normalize plugs into Drupal's serialization pipeline (the core `serialization`/`rest` normalizer system) with a set of normalizers that reshape entity output around a **view mode**. Instead of the default one-field-per-stored-value dump, an entity is serialized field-by-field using the fields enabled in a chosen view display's content region, and each field is run through its view-mode formatter — so a formatted text field returns rendered markup, a link field returns `{title, url}`, an entity-reference field returns IDs, labels, or the fully recursed referenced entity depending on its display formatter, and file fields gain absolute/relative URLs. The view mode is chosen per request via a `?_view_mode=<machine_name>` query parameter, or fixed per field/row via serialization context.

It is meant for building read APIs whose JSON shape follows your Manage Display configuration: configure a view mode once and both single-entity REST responses and Views REST exports return that shape. Two Views row plugins ship for the "data" (REST export) display type — "Entity (with view mode)" for normal entity views and "Search API: source entity for search index" for indexing view-mode-rendered content into Search API. An optional submodule, `telephone_validation_normalize`, adds a normalizer for telephone fields validated by the Telephone Validation module. The module depends on core `rest`; recursive paragraph output additionally needs Entity Reference Revisions / Paragraphs, and the country/select-list output uses core's country manager.

---

- Render an entity through a view mode in REST responses.
- Return formatter-rendered field output instead of raw stored values.
- Pick the view mode per request with `?_view_mode=teaser`.
- Serialize only the fields enabled in a view mode's display.
- Get rendered markup for formatted text fields.
- Return link fields as `{title, url}`.
- Return entity-reference fields as target IDs (`entity_reference_entity_id` formatter).
- Return entity-reference fields as labels (`entity_reference_label` formatter).
- Recurse into referenced entities with their own view mode (`entity_reference_entity_view` formatter).
- Serialize paragraphs / entity_reference_revisions fields recursively.
- Emit file fields with `url` (relative) and `absolute_url`.
- Output select/list fields as `{selected, options}` for building form widgets.
- List all countries as options for `address_country` fields.
- Build a Views REST export whose rows are view-mode-rendered entities.
- Add the "Entity (with view mode)" row plugin to a data display.
- Choose the row's view mode in the Views row settings form.
- Push view-mode-rendered entity JSON into a Search API index.
- Use the "Search API: source entity for search index" row plugin.
- Collapse single-cardinality fields to a scalar instead of a one-item array.
- Return multi-value fields as arrays.
- Serialize the current-language translation of referenced entities.
- Fall back to core serialization when no matching view display exists.
- Normalize E.164 telephone fields into `{country_code, nation_phone_number}` (submodule).
- Provide a country dialing-code lookup list alongside telephone values (submodule).
- Feed a decoupled / headless front end display-driven JSON.
- Keep the JSON shape aligned with editors' Manage Display settings.
- Serve teaser vs full representations of the same entity from one endpoint.
