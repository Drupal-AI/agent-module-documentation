Twig Tweak is a Twig extension that adds a set of convenient functions and filters (like `drupal_view()`, `drupal_block()`, `drupal_entity()`, `drupal_field()`, `image_style` and `token_replace`) so themers can render Drupal content directly from template files without writing a preprocess function.

---

Drupal's default Twig integration is intentionally minimal, so common theming tasks — embedding a view, rendering a block or region, printing a single field, replacing tokens, or generating an image-style URL — normally require PHP in a `*.theme` file. Twig Tweak closes that gap by registering one Twig extension (`Drupal\twig_tweak\TwigTweakExtension`) that exposes around twenty functions and eighteen filters usable inline in any template. Functions cover rendering: `drupal_view`, `drupal_block`, `drupal_region`, `drupal_entity`, `drupal_entity_form`, `drupal_field`, `drupal_menu`, `drupal_form`, `drupal_image`, plus helpers like `drupal_token`, `drupal_config`, `drupal_url`, `drupal_link`, `drupal_title`, `drupal_messages`, `drupal_breadcrumb`, `drupal_contextual_links`, and the debug helpers `drupal_dump`/`dd` and `drupal_breakpoint`. Filters cover transformation of values: `token_replace`, `preg_replace`, `image_style`, `transliterate`, `check_markup`, `format_size`, `truncate`, `view`, `with`, `data_uri`, `children`, `file_uri`, `file_url`, `entity_url`, `entity_link`, `translation`, and `cache_metadata` (plus an optional, off-by-default `php` filter). Rendering is delegated to dedicated view-builder services (block, region, entity, entity form, field, menu, image) that take care of access checks and cache metadata bubbling. Modules and themes can register their own functions, filters and tests through the `hook_twig_tweak_functions_alter`, `hook_twig_tweak_filters_alter` and `hook_twig_tweak_tests_alter` hooks. It also ships Drush/console commands to debug and validate Twig. There is no configuration UI — install it and the Twig helpers are immediately available.

---

- Embed a view (e.g. "who's new" block display) directly in a template with `drupal_view('who_s_new', 'block_1')`.
- Pass contextual filter arguments to an embedded view.
- Check whether a view returns any results using `drupal_view_result()` before rendering.
- Render a block plugin inline with `drupal_block('system_branding_block')`, optionally with custom configuration.
- Print a whole theme region from Twig with `drupal_region('sidebar_first')`.
- Render an entity by ID or UUID in a chosen view mode with `drupal_entity('node', 123, 'teaser')`.
- Embed an entity add/edit form via `drupal_entity_form('node', 1)`.
- Render a single field of an entity with `drupal_field('field_image', 'node', 1, 'teaser')`.
- Print a menu (optionally fully expanded) using `drupal_menu('main')`.
- Render an arbitrary Drupal form class with `drupal_form()`.
- Output an image by file id/UUID/URI, optionally with an image style, using `drupal_image()`.
- Replace a single token like `drupal_token('site:name')` or replace tokens in markup with the `token_replace` filter.
- Read a config value straight from a template with `drupal_config('system.site', 'name')`.
- Generate internal/external URLs and links with `drupal_url()` and `drupal_link()`, including access checks.
- Print the current page title, status messages, or breadcrumb with `drupal_title()`, `drupal_messages()`, `drupal_breadcrumb()`.
- Add contextual (edit) links to a rendered region with `drupal_contextual_links()`.
- Debug template variables with `drupal_dump(var)` / `dd()` or set an Xdebug breakpoint with `drupal_breakpoint()`.
- Apply an image style to a URI in Twig with the `image_style` filter.
- Truncate, transliterate, or `check_markup` a string safely from the template.
- Render an entity/field via the `view` filter (`node|view('teaser')`) instead of a preprocess hook.
- Add a property to a render array with the `with` filter (the opposite of core's `without`).
- Extract a file URI/URL from a field or media item with `file_uri` / `file_url`, OEmbed included.
- Build a data-URI (e.g. inline SVG) with the `data_uri` filter.
- Bubble up cache metadata from raw values using the `cache_metadata` filter.
- Get an entity's canonical or edit URL/link with `entity_url` / `entity_link`.
- Print a referenced entity in the correct language with the `translation` filter.
- Format a byte count for display with `format_size`, or loop over render-array children with `children`.
- Debug all registered functions/filters/tests with `drush twig-tweak:debug`.
- Register your own custom Twig functions, filters or tests via the alter hooks.
