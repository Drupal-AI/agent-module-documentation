# Twig functions

Defined in `TwigTweakExtension::getFunctions()`. Use inline in any Twig template. Signatures below
are the important args; most rendering functions bubble cache metadata and run access checks.

| Function | Purpose / signature |
|---|---|
| `drupal_view(name, display, ...args)` | Embed a view display; extra args map to contextual filters (alias of `views_embed_view`). |
| `drupal_view_result(name, display, ...args)` | Get the raw view result rows (not printable) — e.g. test `|length`. |
| `drupal_block(id, config = {}, wrapper = true)` | Render a block plugin; pass config overrides; `wrapper=false` bypasses block.html.twig. |
| `drupal_region(region, theme = null)` | Render all blocks in a theme region. |
| `drupal_entity(entity_type, selector, view_mode = 'full', langcode = null, check_access = true)` | Render an entity by ID or UUID. |
| `drupal_entity_form(entity_type, id = null, form_mode = 'default', values = {}, check_access = true)` | Render an entity add/edit form. |
| `drupal_field(field_name, entity_type, id, view_mode = 'full', langcode = null, check_access = true)` | Render one field of an entity (view_mode may be a display-options array; not for Layout Builder view modes). |
| `drupal_menu(menu_name, level = 1, depth = 0, expand = false)` | Render a menu tree. |
| `drupal_form('Fully\\Qualified\\FormClass', ...args)` | Build and render a form. |
| `drupal_image(selector, style = null, attributes = {}, responsive = false, check_access = true)` | Render an image by file id / UUID / URI, optional image (or responsive) style. |
| `drupal_token(token, data = {}, options = {})` | Replace a single token, e.g. `drupal_token('site:name')`. |
| `drupal_config(name, key)` | Read a value from a config object. |
| `drupal_dump(var)` / `dd(var)` | Dump variable(s) via symfony/var-dumper; `dd()` with no arg dumps the whole context. |
| `drupal_title()` | Current route title (cached per URL). |
| `drupal_url(user_input, options = {}, check_access = false)` | Build a `Url` from an internal path / external URL / `?query` / `#fragment`. |
| `drupal_link(text, user_input, options = {}, check_access = false)` | Build a `Link`; supports drupal_url options plus attributes. |
| `drupal_messages()` | Render the status-messages placeholder. |
| `drupal_breadcrumb()` | Render the breadcrumb. |
| `drupal_breakpoint()` | Trigger an Xdebug breakpoint in the compiled template. |
| `drupal_contextual_links(id)` | Attach contextual (edit) links to a rendered region. |

Examples:

```twig
{{ drupal_view('who_s_new', 'block_1') }}
{{ drupal_block('system_branding_block', {label: 'Branding', use_site_name: false}) }}
{{ drupal_entity('node', 123, 'teaser') }}
{{ drupal_field('field_image', 'node', 1, 'teaser') }}
{{ drupal_image('public://ocean.jpg', 'thumbnail', {alt: 'Ocean'|t}) }}
{{ drupal_link('View'|t, 'node/1', {attributes: {target: '_blank'}}) }}
```

Full examples with every argument variant: source `docs/cheat-sheet.md`. Functions can be extended
via `hook_twig_tweak_functions_alter` (see hooks doc).
