# Hooks & service API

## Hooks (`background_image.api.php`)
All receive the current `BackgroundImageInterface` entity (and often the associated entity) in
context. Implement in a `.module` file.

- `hook_background_image_css_template_alter(array &$variables, string &$template_filename, BackgroundImageInterface $bg)`
  — change the `*.css.twig` template used and/or its variables (`base_class`,
  `background_image_class`, `fallback_url`, `media_queries[]`). By default a
  `background_image.css.twig` in an active/base theme's `templates/` dir is auto-used; set
  `$template_filename` to point elsewhere.
- `hook_background_image_build_alter(array &$element, array &$context)` — alter the rendered
  background image render array after it's built. `$context['background_image']`,
  `$context['entity']` (may be unset). E.g. float an extra field over the image.
- `hook_background_image_text_build_alter(array &$element, array &$context)` — alter overlay text
  render element *before* tokenization (`$element['#text']`, plus `token_data`/`token_options`).
- `hook_background_image_text_after_build_alter(array &$element, array &$context)` — alter overlay
  text *after* tokenization (e.g. strip empty tags left by unmatched tokens).

## Service: `background_image.manager`
Class `Drupal\background_image\BackgroundImageManager` (also `BackgroundImageManager::service()`).
Key methods (`BackgroundImageManagerInterface`):
- `getBackgroundImage($langcode = NULL, array $context = [])` — resolve the background image entity
  (and cacheability) for the current route/context; returns `[$media, $cacheability]`.
- `view($background_image, $view_mode = 'full', $langcode = NULL)` — render array for an entity.
- `alterEntityForm(array &$form, FormStateInterface $form_state)` — inject background-image controls
  into an entity form.
- `colorSampleFile(?FileInterface $file, $default)` / `colorSampleImage(ImageInterface, $default)` —
  average-color (hex) of an image; `colorIsDark($hex)` — bool.
- `getBaseClass()` — the configured CSS base class; `useMinifiedCssUri()` — bool.

## Tokens
The module implements `hook_token_info`/`hook_token_info_alter`/`hook_tokens` and reorders its own
token implementation last via `hook_module_implements_alter`, so background image tokens resolve
with full context. Overlay text runs through token replacement (see the text alter hooks above).
