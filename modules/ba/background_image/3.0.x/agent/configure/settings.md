# Configuring Background Image

## Settings form
Route `background_image.settings` → `/admin/config/media/background_image`
(`BackgroundImageSettingsForm`, a `ConfigFormBase`; gated by core
`administer site configuration`). It edits **only** `base_class` today — the prefix used for all
generated CSS classes (default `background_image`). Everything else in `background_image.settings`
is edited in config/YAML, not the form (there is a `@todo` to expose more).

## `background_image.settings` (config/install)
- `defaults` — default per-image settings applied to new background images:
  - `blur`: `type` (0 none, 1 on-scroll, 2 on-scroll+full-viewport, 3 always), `radius`, `speed`.
  - `dark` (bool), `full_viewport` (bool).
  - `preload.background_color` (hex, default `#ffffff`).
  - `text`: `format` (default `full_html`) + `value` (overlay text).
- `entities` — map of entity type → bundle → `{enable, embed, require, group}` controlling where a
  background image field/embed is offered (ships with node article/page, user, view; all disabled).
- `css.base_class` (default `background-image`) and `css.retina_rules` (the DPR media queries).
- `image_style`: `preload` (`background_image_preload`), `fallback` (`background_image_lg`),
  `responsive` (`background_image`). Matching image styles + a `background_image` responsive style
  ship in `config/optional`.

Override in code as usual, e.g. in `settings.php`:
`$config['background_image.settings']['image_style']['fallback'] = 'my_style';`

## Uploading images (Media)
Images are uploaded as a **`background_image` media type** (the 3.x rewrite delegates image
handling to Media + image styles). Individual background image settings (blur, full_viewport, dark,
overlay text, preload color) live on the add/edit form of each background image item, not in global
settings.

## The BackgroundImage entity
Content entity, table `background_image_field_data`. Base fields: `image` (image), `media`
(entity_reference to media), `label`, `type` (list_integer — see the `TYPE_*` constants:
GLOBAL=-1, ENTITY=0, ENTITY_BUNDLE=1, PATH=2, ROUTE=3, VIEW=4), `target` (string_long), `settings`
(map), plus `uid`/`created`/`changed`. `type`+`target` determine where the image applies; the
manager resolves the best match for the current request in `getBackgroundImage()`.

## Choosing where an image shows — Context
The module registers a **Background Image context reaction** (`Plugin/ContextReaction/BackgroundImage`,
id `background_image`). Create a Context (Context module), add conditions (path, route, entity
bundle, etc.), and add the "Background Image" reaction to select the image for that context. Two
blocks are also available: `background_image` and `background_image_text` (overlay text).

## Rendering / theming
- `hook_system_info_alter` adds a **"Background Image" region** to every theme; the
  `region--background-image.html.twig` template renders it.
- `hook_preprocess_html` adds `<base_class>-dark` and/or `<base_class>-full-viewport` classes to the
  `<body>` based on the resolved image's `field_dark` / `field_full_viewport`.
- CSS is built from a `*.css.twig` template. Put `background_image.css.twig` in your theme's
  `templates/` to override it, or point elsewhere with
  `hook_background_image_css_template_alter()` (see [../api/hooks.md](../api/hooks.md)).
- Color picking uses the bundled **jscolor** library, loaded from the jsDelivr CDN with a
  Subresource-Integrity hash (`background_image.libraries.yml`).
