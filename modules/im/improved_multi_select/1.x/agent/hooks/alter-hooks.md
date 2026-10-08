<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks

The module invokes two `hook_*_alter()` hooks from `improved_multi_select_page_attachments()`.
There is no `.api.php` file; these are the only extension points, discovered in the `.module`.

## `hook_improved_multi_select_activated_alter(bool &$activated, array $context)`

Called after the module decides whether to activate on the current page, **before** the
library is attached. Lets you force-enable or force-disable per page. `$context` contains:

- `url` — the trimmed `url` config value.
- `request_path` — the current request URI.
- `selectors` — the parsed `selectors` config (array of non-empty lines).

```php
function mymodule_improved_multi_select_activated_alter(&$activated, array $context) {
  // Never enhance the admin content overview.
  if (str_starts_with($context['request_path'], '/admin/content')) {
    $activated = FALSE;
  }
}
```

## `hook_improved_multi_select_attached_alter(array &$drupal_settings, array $context)`

Called only when activated, just before attaching. `$drupal_settings` is the payload that
becomes `drupalSettings.improved_multi_select` — you can rewrite `selectors`, `filtertype`,
`orderable`, the `buttontext_*` labels, `placeholder_text`, etc.

```php
function mymodule_improved_multi_select_attached_alter(array &$drupal_settings, array $context) {
  // Only enhance the tags field on this request, with regex filtering.
  $drupal_settings['selectors'] = ['#edit-field-tags'];
  $drupal_settings['js_regex'] = TRUE;
}
```

Both are ordinary alter hooks — implement them in `mymodule.module` (or a `hook_*` Hook class)
and clear cache. No service or event subscriber is involved.
