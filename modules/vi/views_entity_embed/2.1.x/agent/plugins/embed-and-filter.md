<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EmbedType, filter, tag & routes

## EmbedType `embed_views`

`src/Plugin/EmbedType/EmbedViews.php` — `@EmbedType(id = "embed_views", label = "Views")`,
extends `EmbedTypeBase`. Its configuration form provides the four `type_settings` keys stored
on an embed button:

| Key | Meaning |
|---|---|
| `filter_views` (bool) | restrict which Views are selectable |
| `views_options` (array) | allowed View ids (when `filter_views`) |
| `filter_displays` (bool) | restrict which display plugins are selectable |
| `display_options` (array) | allowed display plugin classes (when `filter_displays`) |

`getAllViews()` lists enabled Views; `getAllDisplays()` lists display plugins. Default icon is
`js/plugins/drupalviews/views_entity_embed.svg`.

## Filter `views_embed`

`src/Plugin/Filter/ViewsEmbedFilter.php` — `@Filter(id = "views_embed", title = "Display
embedded views", type = TYPE_TRANSFORM_REVERSIBLE)`.

- `process()` only runs when the text contains both `data-view-name` and `data-view-display`.
  It loads the HTML, xpath-queries `//drupal-views[@data-view-name and @data-view-display]`, and
  for each match calls `buildViewsEmbed()`, renders it, merges cache metadata, and replaces the
  node. A load failure throws `EntityNotFoundException`.
- `buildViewsEmbed()` reads `data-view-name`, `data-view-display`, and JSON `data-view-arguments`
  (`override_title`, `title`, `filters`), then `Views::getView()->setDisplay()`, applies the
  title override, sets contextual arguments from `filters`, runs `preExecute()`/`execute()`, and
  returns a render array wrapped by `#theme_wrappers => ['views_entity_embed_container']`.

## The `<drupal-views>` element

Required attributes: `data-view-name`, `data-view-display`. Optional: `data-view-arguments`
(JSON), plus embed/align/caption attributes (`data-embed-button`, `data-align`, `data-caption`).

## Rendering hooks (`views_entity_embed.module`)

- `views_entity_embed_theme()` registers `views_entity_embed_container`
  (template `templates/views-entity-embed-container.html.twig`).
- `template_preprocess_views_entity_embed_container()` renders the embedded View and passes the
  embed context (including the title override) through.
- `hook_preprocess_views_view()` applies `data-title` when `data-override-title` is set.

## Routes (`views_entity_embed.routing.yml`)

- `views_entity_embed.dialog` / `.settings` → `/views-entity-embed/dialog/{editor}/{embed_button}`
  (form `ViewsEmbedDialog`, access `_embed_button_editor_access`).
- `views_entity_embed.edit_embedded_view` → `/entity-embed/edit-embedded-view/{type}`
  (`EditEmbeddedView::edit`, returns a redirect).

There are also CKEditor 4 (`DrupalViews`) and CKEditor 5 (`DrupalEntity`) plugin wrappers, but
you interact with the feature through the filter, the button, and the `<drupal-views>` tag.
