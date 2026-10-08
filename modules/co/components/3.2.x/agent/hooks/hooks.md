# Hooks (components.api.php)

## `hook_components_namespaces_alter(array &$namespaces, string $theme)`
Alter the Twig namespaces for the active theme. Keys are namespace machine
names; values are arrays of directory paths **relative to the Drupal root**.
```php
function mymodule_components_namespaces_alter(array &$namespaces, string $theme) {
  $namespaces['new_namespace'] = ['libraries/new-components'];
  if ($theme === 'zen') {
    $namespaces['components'][] =
      \Drupal::service('extension.list.theme')->getPath('zen') . '/components';
  }
}
```

## `hook_protected_twig_namespaces_alter(array &$protectedNamespaces)`
Control which namespaces are protected (cannot be redefined). Keyed by
namespace machine name; each entry has `name`, `type` (module|theme|profile),
and `package`. Unset entries to allow them to be altered.
```php
function mymodule_protected_twig_namespaces_alter(array &$protectedNamespaces) {
  unset($protectedNamespaces['block']);              // allow overriding 'block'
  foreach ($protectedNamespaces as $name => $info) { // allow all themes
    if ($info['type'] === 'theme') {
      unset($protectedNamespaces[$name]);
    }
  }
}
```
