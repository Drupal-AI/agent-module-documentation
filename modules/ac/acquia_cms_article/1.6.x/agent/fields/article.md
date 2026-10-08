# The Article content type

`acquia_cms_article` installs the `article` node type and its content model as **optional config**
(`config/optional/*`). Every config entity carries `dependencies.enforced.module: acquia_cms_article`,
so it is owned by this module and removed on uninstall. Because it is *optional* config, an item only
installs once its own dependencies (e.g. `media.type.image`, `taxonomy.vocabulary.categories`,
`node.type.person`, `search_api`, Site Studio) are present.

## Node type

- Config: `node.type.article` — name **Article**, `type: article`.
- Description: "A structured content type used for creating various types of articles."
- `new_revision: true`, `preview_mode: 0`, `display_submitted: false`.
- `third_party_settings`:
  - `acquia_cms_common`: `workflow_id: editorial`; `metatag.tag_types` (`basic`, `open_graph`, `schema_article`, `twitter_cards`); `search_index: content`; `subtype.field: field_article_type`, `subtype.facet: articles_article_type`; `sitemap_variant: default`; workbench email templates for the editorial transitions.
  - `menu_ui`: available menu `main`, parent `main:`.
  - `scheduler`: `publish_enable: true`, `unpublish_enable: true`, `publish_past_date: error`, vertical-tab display.

These namespaces are read by `acquia_cms_common` facades and by the Metatag / Simple Sitemap /
Scheduler / Content Moderation modules — this module only *declares* the values.

## Fields (`node.article`)

| Label | Machine name | Field type | Target | Card. | Required | Form widget |
|-------|--------------|-----------|--------|-------|----------|-------------|
| Body | `body` | `text_with_summary` | — | 1 | yes | `text_textarea_with_summary` |
| Image | `field_article_image` | `entity_reference` | media:`image` | 1 | no | `media_library_widget` |
| Media | `field_article_media` | `entity_reference` | media:`image` | −1 (unlimited) | no | `media_library_widget` |
| Article Type | `field_article_type` | `entity_reference` | taxonomy_term:`article_type` | 1 | no | `options_select` |
| Categories | `field_categories` | `entity_reference` | taxonomy_term:`categories` | — | no | `options_select` |
| Display Author | `field_display_author` | `entity_reference` | node:`person` | 1 | no | `entity_reference_autocomplete` |
| Tags | `field_tags` | `entity_reference` | taxonomy_term:`tags` | — | no | `entity_reference_autocomplete_tags` (auto-create) |

Storages shipped by this module: `field_article_image`, `field_article_media`, `field_article_type`,
`field_display_author`. The `body`, `field_categories` and `field_tags` **storages** are provided
elsewhere (core / `acquia_cms_common`); this module only attaches the field instances. The
`categories`/`tags` vocabularies and the `person` node type likewise come from `acquia_cms_common` /
`acquia_cms_person` — this is why those are hard dependencies.

Taxonomy vocabulary **defined here**: `article_type` (`taxonomy.vocabulary.article_type`, label
"Article Type").

## Displays

- **Form display**: `node.article.default` — fields grouped via `field_group` (`group_media`,
  `group_taxonomy`); includes Scheduler widgets (`publish_on`/`unpublish_on` =
  `datetime_timestamp_no_default`, `publish_state`/`unpublish_state` = `scheduler_moderation`),
  `moderation_state`, `path`, `simple_sitemap`, `url_redirects`. `promote`/`status`/`sticky` hidden.
- **View displays**: `default`, `card`, `horizontal_card`, `search_results`, `teaser`
  (`core.entity_view_display.node.article.*`). Default view mode renders `body`, `field_article_image`
  and `field_display_author` (both via `entity_reference_entity_view`); the other article fields are hidden.
- `language.content_settings.node.article` enables translation; `metatag.metatag_defaults.node__article`
  seeds metatag defaults; `pathauto.pattern.article` and `pathauto.pattern.article_taxonomy_path`
  provide URL alias patterns.

## Extending / overriding

Add or edit fields on the `article` bundle exactly as for any content type
(`/admin/structure/types/manage/article/fields`); the config travels with a normal config export.
To change a shipped value programmatically:

```php
// Example: make the Media field required.
$field = \Drupal::configFactory()->getEditable('field.field.node.article.field_article_media');
$field->set('required', TRUE)->save();
```

Note the module's own `hook_update_N` implementations (see [../hooks/integration.md](../hooks/integration.md))
already mutate several of these displays/fields on update — check there before assuming the installed
config matches `config/optional/` verbatim on an upgraded site.
