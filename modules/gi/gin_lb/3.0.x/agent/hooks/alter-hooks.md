<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks gin_lb invites (`gin_lb.api.php`)

Two alter hooks, both boolean flags, both documented in `gin_lb.api.php`.

## `hook_gin_lb_is_layout_builder_route_alter(&$gin_lb_is_layout_builder_route)`

Invoked from `ContextValidator::isLayoutBuilderRoute()` **after** its own check
(`preg_match('/^(layout_builder\.([^.]+\.)?)/', $routeName)`). Use it to tell the module that a
route it would not recognise is nonetheless a Layout Builder screen — the canonical case being
Layout Builder embedded in Page Manager.

```php
function MYMODULE_gin_lb_is_layout_builder_route_alter(&$gin_lb_is_layout_builder_route) {
  $route_match = \Drupal::routeMatch();
  if ($route_match->getRouteName() === 'entity.page.add_step_form'
    && $route_match->getParameter('step') === 'layout_builder') {
    $gin_lb_is_layout_builder_route = TRUE;
  }
}
```

Turning this TRUE is what makes `hook_page_attachments()` attach the module's libraries and
`ThemeSuggestionsAlter` add `toolbar__gin_lb` and the hook-level suggestions for that request.
The result is memoised per request in `ContextValidator::$isLayoutBuilderRoute`.

## `hook_gin_lb_show_toolbar_alter(&$gin_lb_show_toolbar)`

Alters the flag that decides whether the Gin LB toolbar is rendered — use it to hide the toolbar
on an embedded Layout Builder screen where it would be redundant.

```php
function MYMODULE_gin_lb_show_toolbar_alter(&$gin_lb_show_toolbar) {
  if (\Drupal::routeMatch()->getRouteName() === 'entity.page.add_step_form') {
    $gin_lb_show_toolbar = FALSE;
  }
}
```

## Not a hook, but the other extension point

Themes are expected to *stand down* rather than hook in. If your front-end theme implements
`hook_theme_suggestions_alter()` it will fight gin_lb's suggestions; the README's fix is to
early-return on the module's marker:

```php
function MYTHEME_theme_suggestions_alter(array &$suggestions, array $variables, $hook) {
  if (isset($variables['element']['#gin_lb_form'])) {
    return;
  }
}
```

`gin_lb_module_implements_alter()` already moves gin_lb's `form_alter`, `suggestions_alter` and
`preprocess` implementations to run **last**, so it wins over most modules — but not over a
theme.
