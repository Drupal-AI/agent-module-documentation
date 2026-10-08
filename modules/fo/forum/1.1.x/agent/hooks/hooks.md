# Hooks, theming & validation

Forum ships **no `forum.api.php`** — it invites no custom `hook_forum_*` hooks. You extend
it through (a) core theme hooks it defines, (b) the standard entity hooks it reacts to, and
(c) its validation constraint. All module hooks are implemented as methods on
`\Drupal\forum\Hook\ForumHooks` and `\Drupal\forum\Hook\ForumViewsHooks` (attribute-based
`#[Hook(...)]`).

## Theme hooks (override these to reskin the board)

Defined in `ForumHooks::theme()`; override with a Twig template of the same name or a
`THEME_preprocess_HOOK()` in your theme:

| Theme hook | Renders |
|---|---|
| `forums` | the whole forum listing (subforums + topics + pager) — template `forums.html.twig` |
| `forum_list` | the table of forums/containers with counts and last post |
| `forum_icon` | the new/updated/hot/sticky status icon per topic |
| `forum_submitted` | the "submitted by X, date" line |
| `forum_topic` | a topic's title link + submitted info |

`ForumHooks` also implements `hook_theme_suggestions_forums()` (adds
`forums__<tid>` suggestions so you can template one forum differently) and
`hook_preprocess_block()` (adds forum context to the two forum blocks).

## Entity hooks forum implements (behavior you inherit)

- `hook_ENTITY_TYPE_presave/insert/update/predelete` for **nodes** — assigns the forum
  term when posting from inside a forum and keeps `{forum}` / `{forum_index}` in sync.
- `hook_ENTITY_TYPE_insert/update/delete` for **comments** — updates last-post/index data.
- `hook_node_storage_load` — attaches forum data to loaded forum nodes.
- `hook_entity_type_build` / `hook_entity_bundle_info_alter` /
  `hook_entity_bundle_field_info_alter` — register the forum term forms, set the forum URI
  callback, and attach the `ForumLeaf` constraint to `taxonomy_forums`.
- `hook_form_taxonomy_vocabulary_form_alter`, `hook_form_taxonomy_term_form_alter`,
  `hook_form_node_form_alter` — tailor the vocab/term/node forms for forum use.

## Validation: `ForumLeaf` constraint

`\Drupal\forum\Plugin\Validation\Constraint\ForumLeaf` is added to the `taxonomy_forums`
field: a forum topic must reference a **leaf** forum (`forum_container = 0`), never a
container. Saving a topic that points at a container fails validation. Reuse it by adding
the `ForumLeaf` constraint to any term-reference field.

## Migration

`\Drupal\forum\Plugin\migrate\process\ForumVocabulary` is a migrate process plugin used by
the D6/D7 → D11 forum upgrade path to map the legacy forum vocabulary.
