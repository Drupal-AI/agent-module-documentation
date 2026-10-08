# Hooks — `moderation_sidebar.api.php`

## `hook_moderation_sidebar_alter(array &$build, EntityInterface $entity)`

Invoked at the end of `ModerationSidebarController::sideBar()` (via
`$this->moduleHandler()->alter('moderation_sidebar', $build, $entity)`), just before the sidebar
render array is returned. `$build` is the sidebar render array (keys include `info`, `actions`
with `actions.primary` and `actions.secondary`); `$entity` is the default or latest revision of
the moderated entity. Use it to add, remove, or modify buttons and markup for specific entity
types.

```php
use Drupal\Core\Entity\EntityInterface;

function mymodule_moderation_sidebar_alter(array &$build, EntityInterface $entity) {
  if ($entity->getEntityTypeId() === 'node') {
    // Add a custom button to the primary actions.
    $build['actions']['primary']['my_action'] = [
      '#type' => 'link',
      '#title' => t('My action'),
      '#url' => \Drupal\Core\Url::fromRoute('mymodule.action', ['node' => $entity->id()]),
      '#attributes' => ['class' => ['moderation-sidebar-link', 'button']],
    ];
  }
}
```

The module also implements `hook_theme()` exposing four templates you can override:
`moderation_sidebar_container`, `moderation_sidebar_info`, `moderation_sidebar_revision`, and
`moderation_sidebar_translations` (in `templates/`).
