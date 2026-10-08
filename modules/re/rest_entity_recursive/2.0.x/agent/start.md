<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Entity Recursive (rest_entity_recursive) — agent index

Registers a new REST serialization format, **`json_recursive`**, that returns a content
entity with all of its fields **and referenced entities inlined recursively** in one response
(to a configurable depth), instead of returning references as bare target ids. Pure
Serialization/REST plumbing: no route, config object, permission, Drush command, or plugin type.

- **Version** 2.0.6-rc8 (branch 2.0.x; project has no stable release). Core `^8 || ^9 || ^10 || ^11`.
- **Dependencies** none declared in `.info.yml`, but requires core **Serialization** + **REST**
  (or another `_format`-emitting route) to be usable. `configure`: none.
- **Submodules** (documented separately): `rest_media_recursive`, `rest_menu_recursive`,
  `rest_paragraphs_recursive`.
- Compatibility caveat: on core 10.2+/11.x the recursion normalizer fatals on class load —
  see [api/json-recursive-format.md](api/json-recursive-format.md#compatibility-caveat-verified-on-core-1145).

## Solutions

- **Request an entity + its references in one call, control depth** → [api/json-recursive-format.md](api/json-recursive-format.md)
- **Shape the output (exclude fields, disable expanding a type) / write a custom normalizer / use the submodules** → [api/customize.md](api/customize.md)

## Key facts

- Format: `json_recursive` · request with `?_format=json_recursive` · MIME `application/json-recursive`.
- Depth: query param `max_depth` (default `10`; `0` = root entity only). Bounded by depth counter only (no visited-set).
- Service ids: `rest_entity_recursive.encoder.json_recursive`, `rest_entity_recursive.normalizer.content` (priority 9), `rest_entity_recursive.normalizer.reference` (priority 10).
- Classes: `Encoder\JsonRecursiveEncoder`, `Normalizer\ContentEntityNormalizer`, `Normalizer\ReferenceItemNormalizer`, `RestEntityRecursiveServiceProvider`.
- Serialization context keys read: `current_depth`, `max_depth`, `root_parent_entity`, `settings[<entity_type>]['exclude_fields']`, `settings[<entity_type>]['disable']`.
- Access is re-checked per field (`$field->access('view')`) and per referenced entity (`$entity->access('view')`); denied items collapse to bare targets / are dropped, so trees can be partial.
- Adds synthetic `entity_type` and `entity_bundle` keys to every serialized entity.
