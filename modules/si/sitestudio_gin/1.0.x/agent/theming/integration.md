# How Site Studio Gin integrates the two

All logic is in `sitestudio_gin.module` + `sitestudio_gin.install`. No configuration.

## Gin detection

`sitestudio_gin_is_gin_or_gin_subtheme()` gets the active theme, collects its base-theme
extension keys plus its own name, and returns TRUE if `gin` is among them. Gin-specific behavior
is gated on this so nothing breaks under other admin themes.

## CSS overrides — `hook_preprocess_page`

- Always attaches `sitestudio_gin/sitestudio_gin-global-overrides`
  (`css/sitestudio-gin-global.css`).
- If Gin/subtheme active: also attaches `sitestudio_gin/sitestudio_gin-gin-overrides`
  (`css/gin-custom.css`), and on route
  `sitestudio-page-builder.layout_canvas.frontend_edit_component` unsets
  `$variables['page']['gin_secondary_toolbar']` so Gin's secondary toolbar is removed from the
  Site Studio editing iframe.

## Component Content form restyling

`sitestudio_gin_form_component_content_edit_form_alter()` (and `_add_form_alter`, which delegates
to it), only when Gin is active:

- Sets `$form['#theme'] = ['node_edit_form']` and attaches `claro/node-form`.
- Converts `advanced` to a container with `#accordion = TRUE`.
- Forces `meta` visible as a container; makes `changed`/`author` inline.
- Moves `revision_information` into the `meta` group as a container.

`hook_gin_content_form_routes()` returns `entity.component_content.{add_form,canonical,edit_form}`
so Gin applies its content-form layout to those routes.

## Install requirement

`sitestudio_gin_requirements('install')` (adapted from gin_toolbar) errors out if the `gin`
theme is not installed (unless Drupal is being installed with gin in the profile), preventing a
mis-configured install.
