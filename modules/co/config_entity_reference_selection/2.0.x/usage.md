<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config entity reference selection derives a `config:<entity_type>` EntityReferenceSelection handler for every configuration entity type, so an entity_reference field can be restricted to a hand-picked subset of that type instead of offering every one that exists.

---

Core's `DefaultSelection` handler will happily reference configuration entities (image styles, view modes, text formats, workflows, user roles, menus, vocabularies, views, block types, and any config entity a contrib module defines), but it offers **all** of them, plus every one added later, with no way to narrow the list. This module fills that gap with a single base plugin — id `config`, extending `DefaultSelection` — carrying a **deriver** (`Plugin/Derivative/ConfigEntityReferenceSelection`) that walks `entityTypeManager->getDefinitions()` and emits one derivative per entity type whose class implements `ConfigEntityInterface`. The result is a family of selection handlers named `config:image_style`, `config:node_type`, `config:user_role`, `config:view`, and so on — one per config entity type on the site. Point a field's "Reference method" at the matching handler and its settings form gains an **Allowed …** multi-select listing every entity of that type; whatever you pick is stored as `handler_settings.filter.allowed_ids` (a keyless sequence, enforced in `validateConfigurationForm`). `buildEntityQuery()` then adds `->condition(<id key>, allowed_ids, 'IN')` on top of core's query when the list is non-empty — an empty list means "allow all". Because the constraint lives in field configuration it exports and deploys with the site rather than living in a developer's head. Two refinements are worth knowing: the options list only shows entities that pass `$entity->access('view label')`, and each option's label is produced by dispatching a `LabelDisplayEvent` (constant `config_entity_reference_selection_label_display`) so other code can rewrite it — the module's own `FieldConfigLabelDisplaySubscriber` uses this to render `field_config` options as "Entity type - Bundle - Field" instead of a bare, ambiguous field label. Auto-create is force-disabled (`$form['auto_create']['#access'] = FALSE`) since you cannot invent new config entities from a content form. No dependencies, no permissions, no routes, no UI beyond the standard field-settings form; core requirement `^10.1 || ^11 || ^12`.

---

- Limit an image-style reference field to three approved styles rather than all forty.
- Restrict a "view mode" reference to a curated set of display modes.
- Offer content editors a short list of text formats through a reference field.
- Constrain a workflow reference to the two workflows a section actually uses.
- Limit a user-role reference field to a subset of roles.
- Reference only a handful of the site's many Webforms (or any config-entity type a module adds).
- Restrict a menu reference to the menus relevant to one content type.
- Curate which views a "related view" reference field may target.
- Offer a controlled set of block types for a Layout Builder-style field.
- Restrict a vocabulary reference to specific taxonomy vocabularies.
- Keep a select list short and stable as contrib modules add more config entities.
- Prevent newly added config entities from silently appearing as field options.
- Present a subset of configuration entities as a simplified select for editors.
- Reference a chosen set of filter formats, languages, or date formats.
- Build a "presentation choice" field that offers three card styles and no more.
- Ship the allowed-list constraint in exported field configuration across environments.
- Point a field at `config:<type>` programmatically and set `filter.allowed_ids` in code.
- Rewrite the option labels for a config type by subscribing to the `LABEL_DISPLAY` event.
- Disambiguate `field_config` reference options with entity-type/bundle/field labels (built in).
- Hide config entities an editor lacks "view label" access to from the allowed-list picker.
- Reduce editor error by removing irrelevant configuration choices from a reference widget.
- Offer a controlled set of entity view/form displays or view modes as reference targets.
- Replace a hard-coded allowed-values list with a maintainable, config-driven reference field.
