# coffee hooks

Declared in `coffee.api.php` (registered via `hook_hook_info`, so it may live in
`MODULE.coffee.inc` or `MODULE.module`).

## `hook_coffee_commands()`
Return an array of extra items to show in the Coffee search box. Each item:
- `value` — the URL to navigate to (usually `Url::fromRoute(...)->toString()`).
- `label` — text shown in the result list.
- `command` — the command/trigger string a user types to reveal it (e.g. `:simple`, `:x Title`).

```php
function mymodule_coffee_commands() {
  $commands = [];
  $commands[] = [
    'value' => \Drupal\Core\Url::fromRoute('my.simple.route')->toString(),
    'label' => 'Simple',
    'command' => ':simple',
  ];

  // Surface Views results (e.g. frontpage nodes).
  if ($view = \Drupal\views\Views::getView('frontpage')) {
    $view->setDisplay();
    $view->preExecute();
    $view->execute();
    foreach ($view->result as $row) {
      $entity = $row->_entity;
      $commands[] = [
        'value' => $entity->toUrl()->toString(),
        'label' => 'Pub: ' . $entity->label(),
        'command' => ':x ' . $entity->label(),
      ];
    }
  }
  return $commands;
}
```
