# Hook: `domain_path_redirect_field_widget_redirect_source_form_alter()`

Implemented in `domain_path_redirect.module`. This is
`hook_field_widget_WIDGET_TYPE_form_alter()` for the `redirect_source` widget (the source-path widget
supplied by the Redirect module).

## What it does

- Returns immediately unless the form's entity is a `domain_path_redirect` (so it never touches the
  plain Redirect module's own source widget).
- Adds a `#field_prefix` (`<div id="domain-path-prefix">`) before the source path input.
- When the redirect's `domain` field is set, fills that prefix with the domain's base path
  (`$domain->getPath()`), so the editor sees the domain the "from" path is scoped to (e.g.
  `http://example2.com/` shown before the path box).

```php
function domain_path_redirect_field_widget_redirect_source_form_alter(&$element, FormStateInterface $form_state, $context) {
  $entity = $form_state->getFormObject()->getEntity();
  if ($entity->getEntityTypeId() != 'domain_path_redirect') {
    return;
  }
  $element['path']['#field_prefix'] = ['#type' => 'html_tag', '#tag' => 'div', '#attributes' => ['id' => 'domain-path-prefix']];
  if (!$entity->domain->isEmpty()) {
    $element['path']['#field_prefix']['#value'] = $entity->domain->entity->getPath();
  }
}
```

The prefix is also refreshed live by the form's `updatePreview()` AJAX callback when the domain
autocomplete changes (see [configure/redirects.md](../configure/redirects.md)). The styling that keeps
the prefix inline comes from the `drupal.domain_path_redirect.admin` library
(`css/domain_path_redirect.admin.css`).

This is the only hook the module implements; it does not invoke any hooks of its own for other modules.
