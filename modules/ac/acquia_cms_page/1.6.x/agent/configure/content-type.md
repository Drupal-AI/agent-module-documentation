<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the Page content type and its config

This module has **no settings form** (no `*.routing.yml`, no config object of its own). Everything
it "configures" is shipped as installed config under `config/optional/` and imported when the module
is enabled. To change behavior you edit the content type / displays like any other node bundle, or
override the config below via drush/PHP.

## Content type: `node.type.page`

| Setting | Value |
|---|---|
| `name` | Page |
| `type` | `page` |
| `description` | "An unstructured content type that provides unique landing pages - e.g., a homepage, or marketing event landing page." |
| `new_revision` | `true` |
| `preview_mode` | `0` (disabled) |
| `display_submitted` | `false` |

Enforced/module deps of the type: `acquia_cms_common`, `menu_ui`, `scheduler` (and `acquia_cms_page`
enforced). Third-party settings on the type:

- **`acquia_cms_common`** — `workflow_id: editorial` (Content Moderation editorial workflow),
  `search_index: content`, `sitemap_variant: default`, metatag `tag_types` enabled (`basic`,
  `open_graph`, `schema_article`, `twitter_cards`), and `workbench_email_templates`
  (`back_to_draft`, `to_archived`, `to_published`, `transition_to_review`). This is the glue that
  ties Page into the shared `acquia_cms_common` layer.
- **`menu_ui`** — `available_menus: [main]`, `parent: 'main:'`.
- **`scheduler`** — `publish_enable: true`, `unpublish_enable: true`, `publish_past_date: error`,
  `publish_touch: true`, `expand_fieldset: when_required`, `fields_display_mode: vertical_tab`.

## Form display: `node.page.default`

Enabled widgets (weight order): `title` (string_textfield), `body`
(text_textarea_with_summary, 9 rows, summary hidden), `langcode`, `field_categories`
(options_select), `field_page_image` (media_library_widget), `field_tags`
(entity_reference_autocomplete_tags), `moderation_state`, `uid`, `created`, `path`, `url_redirects`,
`simple_sitemap`, `translation`, and the Scheduler widgets (`publish_on`/`unpublish_on` =
`datetime_timestamp_no_default`, `publish_state`/`unpublish_state` = `scheduler_moderation`,
`scheduler_settings`). A **field_group** fieldset `group_taxonomy` wraps `field_categories` +
`field_tags`. `promote`, `status`, `sticky` are hidden. Form-display module deps include
`content_moderation`, `field_group`, `media_library`, `scheduler`,
`scheduler_content_moderation_integration`.

## View displays (view modes wired)

| Mode | Notable content |
|---|---|
| `default` | `field_page_image` (referenced media view mode `large_super_landscape`), `links`, moderation control; body/tags/categories hidden |
| `card` | `body` (text_trimmed, 600), `field_page_image` (`small_landscape`) |
| `horizontal_card` | `body` (text_summary_or_trimmed, 600), `field_page_image` (`small_landscape`) |
| `teaser` | `body` (`smart_trim`, 128 chars), `field_page_image` (`teaser`) |
| `search_results` | `body` (`smart_trim`, 128 chars), `field_page_image` (`teaser`) |
| `search_index` | only `links` + moderation control; all fields hidden |

`teaser`/`search_results` formatters require the `smart_trim` module (a common Acquia CMS dep).

## Related installed config

- **`pathauto.pattern.page`** — alias pattern `[node:title]`, selection `entity_bundle:node` =
  `page`, weight `-5`.
- **`metatag.metatag_defaults.node__page`** — default meta/OG/Twitter/Schema tags built from
  `[node:summary]`, `[node:field_categories]`, `[node:field_tags]`, `[node:title]`,
  `[node:url:absolute]`, and `[node:field_page_image:entity:image:entity:url]`
  (`twitter_cards_type: summary_large_image`, `schema_article_type: Article`).
- **`language.content_settings.node.page`** — content translation enabled, `untranslatable_fields_hide: 1`.
- **Site Studio pack** — `config/pack_acquia_cms_page/` holds Cohesion content templates
  (`node_page_card` / `_full` / `_horizontal_card` / `_search_results` / `_teaser`) imported only
  when `acquia_cms_site_studio` is installed.

## Adjust via drush / PHP

```bash
# Inspect / export the shipped config
drush config:get node.type.page
drush config:get core.entity_view_display.node.page.card
```

```php
// Example: change the Page description.
\Drupal::configFactory()->getEditable('node.type.page')
  ->set('description', 'My landing page type')
  ->save();
```

Note: many of these config entities carry `dependencies.enforced.module: [acquia_cms_page]` (and, for
Layout Canvas, `acquia_cms_site_studio`), so they are removed if the module is uninstalled. There is
no config *schema* directory in this module — schema for these objects comes from core/contrib
(node, field, pathauto, metatag, cohesion).
