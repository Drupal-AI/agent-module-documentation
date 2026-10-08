<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: service + import event

## Service `menu_migration.import_export`

Class `Drupal\menu_migration\Service\MenuMigrationService`. The tree read/rebuild engine used
by the plugins and Drush commands. Public methods:

| Method | Purpose |
|---|---|
| `getAvailableMenus()` | `[menu_id => label]` of all menus on the site (used to validate menu args). |
| `getMenuTree($menuName)` | Builds the nested array of `MenuLinkContent` links for a menu (what formats serialize). |
| `generateMenuItems(array $sourceItems, string $menuName, $parent = 0)` | Recreates `menu_link_content` links from a decoded tree, under `$menuName`, rooted at `$parent`. Fires `MenuImportEvent` per item. |
| `deleteExistingMenuItems(string $menuName)` | Clears a menu's existing content links (import rebuilds, it does not merge). |
| `createMenu(string $menuName): MenuInterface` | Creates a `menu` config entity if it does not exist (used by clone `--create-target`). |

```php
$svc = \Drupal::service('menu_migration.import_export');
$tree = $svc->getMenuTree('main');           // serialize this with a Format plugin
$svc->deleteExistingMenuItems('main_copy');
$svc->generateMenuItems($tree, 'main_copy'); // rebuild into another menu
```

Note: import is **destructive per menu** — `generateMenuItems` is normally preceded by
`deleteExistingMenuItems`, so importing a menu replaces its current content links.

## `MenuImportEvent` — rewrite items on import

`generateMenuItems()` dispatches `Drupal\menu_migration\Event\MenuImportEvent` (event name
constant `MenuImportEvent::IMPORT_MENU_ITEM = 'menu_migration_import_item'`) for **each** menu
item just before it is created. Subscribe to mutate the item array (e.g. rewrite link URIs,
swap a domain, drop items).

```php
use Drupal\menu_migration\Event\MenuImportEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyMenuSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [MenuImportEvent::IMPORT_MENU_ITEM => 'onImportItem'];
  }
  public function onImportItem(MenuImportEvent $event): void {
    // Read/replace nested values on the item being imported.
    $uri = $event->getNestedValue(['link', 0, 'uri']);
    if ($uri) {
      $event->setNestedValue(['link', 0, 'uri'], str_replace('old.example', 'new.example', $uri));
    }
    // $event->getMenuName() is the destination menu.
  }
}
```

Event helpers: `getMenuItem()`, `getMenuName()`, `getNestedValue(array $parents)`,
`setNestedValue(array $parents, mixed $value)`. The module's own `ImportSubscriber`
(`menu_migration.import_subscriber`) is registered on this event; there is a subject-token
constant `MenuImportEvent::IMPORT_MENU_SUBJECT_TOKEN = '[SUBJECT]'` for placeholder handling.
