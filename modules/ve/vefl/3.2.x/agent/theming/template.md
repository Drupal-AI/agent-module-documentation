# Theming — the exposed form template

VEFL renders through its own theme hook and lets you override the template like any exposed form.

## Theme hook & preprocess

- `hook_theme()` registers **`vefl_views_exposed_form`** (render element `form`).
- `hook_theme_registry_alter()` inserts core's `template_preprocess_views_exposed_form` **before**
  `template_preprocess_vefl_views_exposed_form`, so the standard exposed-form variables are
  prepared first.
- `template_preprocess_vefl_views_exposed_form(&$variables)`:
  1. reads `$form['#vefl_configuration']` (set by `VeflTrait::exposedFormAlter()`), which carries
     `layout` (`id`, `settings`) and `regions` (region id → list of widget ids);
  2. moves each form element (filters and `actions`) into its region, restoring filter `#title`
     from `$form['#info']` labels;
  3. instantiates the chosen layout via `plugin.manager.core.layout` and calls `$layout->build($regions)`;
  4. replaces `$variables['form']` with the built, region-structured render array.

`VeflTrait::exposedFormAlter()` also sets `$form['#theme']` to the view-specific suggestions via
`$view->buildThemeFunctions('vefl_views_exposed_form')`.

## Overriding the template

Because the theme hook uses standard Views suggestions, you can override with the usual exposed
form template names in your theme:

- `views-exposed-form.html.twig`
- `views-exposed-form--<VIEWNAME>.html.twig`
- `views-exposed-form--<VIEWNAME>--<DISPLAYNAME>.html.twig`

The module's own base template is `templates/vefl-views-exposed-form.html.twig`, and the
`vefl_onecol` layout renders through `layouts/onecol/vefl-onecol.html.twig`. Since widgets are
already grouped into layout regions, a custom template mainly wraps/labels those regions.
