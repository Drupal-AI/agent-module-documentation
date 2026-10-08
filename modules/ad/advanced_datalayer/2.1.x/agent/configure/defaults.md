# Configure datalayer page variables (defaults)

You assign values to datalayer **tags** per page context using `advanced_datalayer_defaults`
config entities. No `configure` route in info.yml, but the UI lives at
`/admin/config/search/advanced-datalayer/page-variables`.

## The config entity

`advanced_datalayer.advanced_datalayer_defaults.<context>` — schema
`advanced_datalayer.advanced_datalayer_defaults.*` (`id`, `label`, `tags`). `tags` is a map of
`tag_plugin_id => value` (each value validated by
`advanced_datalayer.advanced_datalayer_tag.[%key]`). The module installs one per page context:

| Context id | Applies to |
|---|---|
| `global` | Every supported page (merged into all). |
| `front` | The front page. |
| `node` | Node canonical pages. |
| `taxonomy_term` | Taxonomy term pages. |
| `403` / `404` | Access-denied / not-found pages. |
| `login` / `register` | User login / registration pages. |
| `pass` | Password-reset page. |

Read one back:

```bash
drush cget advanced_datalayer.advanced_datalayer_defaults.node
# -> id: node, label: Node, tags: { <tag_id>: '<value with tokens>' , ... }
```

## Set a tag value (scriptable)

```php
$d = \Drupal::entityTypeManager()
  ->getStorage('advanced_datalayer_defaults')->load('node');
$tags = $d->get('tags');
$tags['page_Name'] = '[node:title]';       // tag id => value (tokens allowed)
$d->set('tags', $tags)->save();
```

The config entity class (`AdvancedDatalayerDefaults`) also offers `hasTag($id)`, `getTag($id)`,
and `overwriteTags(array $tags)`.

## Admin routes (all require `administer advanced datalayer defaults settings`)

| Route | Path | Purpose |
|---|---|---|
| `entity.advanced_datalayer_defaults.collection` | `/admin/config/search/advanced-datalayer/page-variables` | List all page contexts. |
| `entity.advanced_datalayer_defaults.add_form` | `.../page-variables/add` | Add a context. |
| `entity.advanced_datalayer_defaults.edit_form` | `.../page-variables/{id}` | Edit a context's tag values. |
| `entity.advanced_datalayer_defaults.delete_form` | `.../page-variables/{id}/delete` | Delete a context. |
| `advanced_datalayer.settings` | `.../page-variables/settings` | Module settings form. |

## Values, tokens & translation

- Tag **values are strings that may contain tokens** (e.g. `[node:title]`,
  `[node:field_category]`), resolved at render time against the current route entity by
  `advanced_datalayer.token` (uses `token` + `token.entity_mapper`).
- A tag whose plugin is `translatable: TRUE` is resolved in the current content language;
  otherwise it is resolved in the site default language.
- A tag defined `show_empty: FALSE` is omitted when its resolved value is empty.

## Per-entity values (the field)

The module also provides an `advanced_datalayer` **field type** + widget + (empty) formatter, so
an individual entity can carry its own datalayer tag values in addition to the context defaults.
Add the field to a bundle and set values on the entity edit form.

## Note

Out of the box the module defines **no tags**. Enable `example_advanced_datalayer` for sample
tags/groups, or provide your own — see [../plugins/tags-and-groups.md](../plugins/tags-and-groups.md).
