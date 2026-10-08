# Extending translation detection (event + interface)

Two extension points let you override whether a given menu link counts as "translated" for the current
language.

## `HasTranslationEvent` (recommended)

Constant: `Drupal\menu_block_current_language\Event\Events::HAS_TRANSLATION`
= `'menu_block_current_language.has_translation'`.

Dispatched once per link (after the module's built-in detection) inside `filterLanguages()`. Subscribe to
force a link visible or hidden:

```php
// src/EventSubscriber/MyMenuSubscriber.php
use Drupal\menu_block_current_language\Event\Events;
use Drupal\menu_block_current_language\Event\HasTranslationEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyMenuSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [Events::HAS_TRANSLATION => 'onHasTranslation'];
  }
  public function onHasTranslation(HasTranslationEvent $event): void {
    $link = $event->getLink();               // \Drupal\Core\Menu\MenuLinkInterface
    // Force external/custom links to always show:
    if ($link->getProvider() === 'my_module') {
      $event->setHasTranslation(TRUE);
    }
  }
}
```

`HasTranslationEvent` methods: `getLink()`, `hasTranslation(): bool`, `setHasTranslation(bool): self`,
`setLink(MenuLinkInterface): self`. If `hasTranslation()` is FALSE after the event, the tree element is
set to `AccessResult::forbidden()`.

## `MenuLinkTranslatableInterface`

Implement `Drupal\menu_block_current_language\MenuLinkTranslatableInterface` on a custom
`MenuLinkInterface` plugin to declare translation state directly (checked when the link is not a
`MenuLinkContent`, not a Views link, and its title is not a `TranslatableMarkup`):

```php
public function hasTranslation(string $langcode): bool {
  return isset($this->pluginDefinition['translations'][$langcode]);
}
```

Returning FALSE hides the link for `$langcode`.

## Built-in detection order (from `MenuLinkTreeManipulator::hasTranslation()`)

1. `MenuLinkContent` → entity `hasTranslation()` (non-translatable entities pass).
2. Title is `TranslatableMarkup` → `locale` string-storage lookup (default language passes).
3. `ViewsMenuLink` → view language config override exists for the language.
4. `MenuLinkTranslatableInterface` → its own `hasTranslation()`.
5. Otherwise → TRUE (visible).

The service is `menu_block_current_language_tree_manipulator`
(`Drupal\menu_block_current_language\MenuLinkTreeManipulator`), args: language_manager,
entity_type.manager, config.factory, event_dispatcher, locale.storage.
