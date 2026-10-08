# Alter hooks, theme hooks, Twig filter

## Integrator alter hooks (`selectify.api.php`)

Three `\Drupal::moduleHandler()->alter()` invocations let other modules steer Selectify. All three are
fired across the Form API, Views and Webform paths; the `$context['integration_type']` is one of
`form_api`, `views`, `webform` (field widgets do not fire these).

### `hook_selectify_widget_alter(string &$widget, array $context)`
Change (or disable, by setting `'none'`) the widget applied to a form/element **before** styling.
Invoked in `selectify_form_alter`, `_selectify_apply_css_selector_rules`,
`hook_preprocess_views_exposed_form`, and `selectify_webform_webform_element_alter`.
`$context`: `form_id`, `form`/`element` (by ref), `integration_type`, plus `view_name`/`display_id`
(Views) or `webform` (Webform).

```php
function mymodule_selectify_widget_alter(string &$widget, array $context): void {
  if ($context['integration_type'] === 'views' && $context['view_name'] === 'catalog') {
    $widget = 'selectify_searchable';
  }
}
```

### `hook_selectify_element_alter(array &$element, array $context)`
Modify a single select element before styling; set `$element['#selectify_skip'] = TRUE` to skip it.
Invoked in the Form API per-element walkers and the Webform element alter. `$context`: `widget`,
`form_id`, `element_key` (Form API), `webform_id`/`webform` (Webform), `integration_type`,
`css_selector` (when matched by a CSS rule).

### `hook_selectify_is_applicable_alter(bool &$applicable, array $context)`
Return `FALSE` to stop Selectify processing a whole form. Invoked once early in `selectify_form_alter`
(`integration_type = form_api`). `$context`: `form_id`, `form` (by ref), `integration_type`.

## Hooks Selectify itself implements (`selectify.module`)

Presentation/integration hooks (not integrator APIs): `hook_preprocess_html`, `hook_help`
(renders `README.md`), `hook_theme_suggestions_select_alter`, `hook_theme`,
`hook_preprocess_select__selectify_*` (5), `hook_preprocess_form_element`, `hook_preprocess_input`,
`hook_page_attachments`, `hook_page_attachments_alter`, `hook_preprocess_container`,
`hook_preprocess_views_exposed_form`, `hook_form_alter`. Submodule: `hook_webform_element_alter`,
`hook_form_alter`.

## Theme hooks & templates

`selectify_theme()` registers five `select` sub-hooks; `selectify_theme_suggestions_select_alter()`
adds the matching suggestion when the select carries a `selectify-apply-*` class:

| Theme hook | Template (`templates/`) | Triggered by class |
|---|---|---|
| `select__selectify_dropdown` | `select--selectify-dropdown.html.twig` | `selectify-apply-dropdown` |
| `select__selectify_dropdown_checkbox` | `select--selectify-dropdown-checkbox.html.twig` | `selectify-apply-checkbox` |
| `select__selectify_dropdown_searchable` | `select--selectify-dropdown-searchable.html.twig` | `selectify-apply-searchable` |
| `select__selectify_dropdown_tags` | `select--selectify-dropdown-tags.html.twig` | `selectify-apply-tags` |
| `select__selectify_dual` | `select--selectify-dual.html.twig` | `selectify-apply-dual` |

Shared partials live in `templates/partials/` (`_selectify-base.html.twig`,
`_selectify-widget-footer.html.twig`, and `partials/svg/*` icon partials). The common preprocess
`_selectify_preprocess_widget()` computes `unique_id`, `field_name`, `is_multiple`, `max_selected`,
`placeholder`, Views detection, theme classes, and `selectify_few_options` (hides "Clear" for ≤3
options).

## Twig filter

`selectify_clean_id` (from `SelectifyTwigExtension`) — sanitises a string to an HTML-id-safe value:

```twig
id="option-{{ clean_field_name }}-{{ option.value|selectify_clean_id }}"
```
