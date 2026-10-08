<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lifecycle behaviors (hooks implemented in `meta_entity.module`)

These fire automatically for host and meta entities; integrators should know them.

| Hook | Behavior |
|------|----------|
| `hook_entity_insert` | For each meta type with `auto_create` enabled for the host's type/bundle (`getTypesWithAutoCreation()`), creates and saves a linked meta entity, logging a debug message. |
| `hook_entity_delete` | When any content entity is deleted, every meta entity targeting it (across all meta types, via each repository) is deleted — cascade cleanup so no orphan metadata remains. |
| `hook_entity_presave` | For a `MetaEntityInterface` with an empty `label` and a set `target`, computes a default label `"<host label> <host singular type> (<meta type label>)"`. |
| `hook_entity_bundle_field_info` | Exposes the computed reverse-reference `entity_reference` field on host bundles for every mapping entry that set a `field_name` (see fields doc). |
| `hook_theme` + `template_preprocess_meta_entity` | Registers the `meta_entity` theme hook and `templates/meta-entity.html.twig`; the template renders `label` (linked when not the page) and `content`. |

## Cache invalidation (`MetaEntity` entity class)

- `getCacheTagsToInvalidate()` merges the **host** entity's cache tags into the meta entity's, so
  cache tooling treats them together.
- `invalidateTagsOnSave()` invalidates the host's cache tags on every meta-entity save (new or
  update) — updating a counter refreshes the host's rendered output without re-saving the host.

## Reverse-field save wiring (`MetaEntityReverseReferenceItemList`)

When a new host is created together with its meta entity through the reverse field, `preSave()` /
`postSave()` set the meta entity's `target` to the host once the host id exists (postSave re-saves
the meta entity if the id was not yet available at preSave).

## Update hooks worth noting (`meta_entity.install` / `.post_update.php`)

- `meta_entity_update_8001` migrates old `mapping` values to the `{field_name, auto_create}` shape.
- `8002`/`8003` install `langcode`/`default_langcode` and convert storage to make meta entities
  translatable; `8004` fixes Views configs from base table `meta_entity` to `meta_entity_field_data`.
- `meta_entity_post_update_8002` batches meta entities' `langcode` to match their target's language.
