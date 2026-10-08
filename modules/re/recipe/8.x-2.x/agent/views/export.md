<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recipe export via Views (module `recipe`)

Recipe adds one Views **display** plugin and two **style** plugins so a view can serve recipes as
RecipeML XML or as plain text at their own path with the correct `Content-Type`.

## Display plugin `recipe` (`Plugin/views/display/Recipe`)

`@ViewsDisplay(id = "recipe")`, extends `PathPluginBase`, implements
`ResponseDisplayPluginInterface`; `returns_response = TRUE`, `uses_route = TRUE`. AJAX and pager
disabled. `getType()` = `recipe`. `buildResponse()` renders into an empty `CacheableResponse`
(status 200) so the style plugin can set the Content-Type header, and throws
`NotFoundHttpException` when the rendered output is empty. `defineOptions()` defaults the style to
`recipeml`, disables the row plugin, and adds an `Attach to` option (which other displays expose
the alternate-format link). `preview()` wraps output in `<pre>`/`#plain_text` during live preview.
This is the same "response display" pattern core uses for the RSS/feed display.

## Style plugin `recipeml` (`Plugin/views/style/RecipeML`)

`@ViewsStyle(id = "recipeml", theme = "recipe_view_recipeml", display_types = {"recipe"})`.
`usesFields = TRUE`, no row plugin, no grouping. Options form maps view fields to RecipeML slots:
`title_field` (required), `version_field`, `source_field`, `time_fields` (checkboxes; must be
integers), `yield_qty_field`, `yield_unit_field`, `description_field`, `ingredients_field`
(required), `directions_field` (required). `render()` builds a `#rows` array per result; when more
than one `time_fields` is selected it appends a computed **Total time** row (sum, "minutes").
`attachTo()` adds an `alternate` `text/xml` `<link>` to the source display.
`template_preprocess_recipe_view_recipeml()` sets `Content-Type: text/xml; charset=utf-8` (except
in live preview) and adds an `xml:lang` attribute per recipe. Template
`recipe-view-recipeml.html.twig` emits `<recipeml version="0.5">` with `<recipe>`/`<menu>`
wrappers.

## Style plugin `recipe_plain_text` (`Plugin/views/style/PlainText`)

`@ViewsStyle(id = "recipe_plain_text", theme = "recipe_view_plain_text")`. Options:
`wordwrap_width` (default 75), `hide_empty`, `row_separator` (default `"====\n\n"`, tags stripped).
`template_preprocess_recipe_view_plain_text()` sets `Content-Type: text/plain; charset=utf-8`,
runs each field through `_recipe_prepare_plain_text()` (`strip_tags()` + `&deg;` → `\xB0` + trim)
and `wordwrap()`.

## Shipped views (`config/optional/`, need core `views`)

- `views.view.recipes` — recipe listing page.
- `views.view.recipeml` — RecipeML export using the `recipe` display + `recipeml` style.
- `views.view.recipe_plain_text` — plain-text export.
- `modules/ingredient/config/optional/views.view.ingredients` — ingredient listing.

Views schema for the styles lives in `config/schema/recipe.views.schema.yml`.

## Notes

- Field values placed into RecipeML/plain-text come from `style_plugin->getField()` (rendered,
  filtered field output); the RecipeML template prints them through Twig autoescaping into XML.
- The plain-text style strips tags before output; RecipeML relies on the field render pipeline and
  Twig escaping for safety.
