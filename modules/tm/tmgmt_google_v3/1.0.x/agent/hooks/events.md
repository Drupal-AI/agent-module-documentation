# Events: PostTranslationEvent

The module dispatches one event so other modules can post-process each translated string right
after it comes back from Google (before it is saved onto the job item).

## `PostTranslationEvent`

Class `Drupal\tmgmt_google_v3\Event\PostTranslationEvent` (extends Symfony `Event`).
Event name constant: `PostTranslationEvent::POST_TRANSLATION` = `'post_translation'`.

Dispatched inside `requestJobItemsTranslation()` for every translatable segment, after HTML
entities are decoded, with the segment **key** (the flattened field name) and the **translated
text**.

| Method | Purpose |
|---|---|
| `getTranslationKey(): string` | the segment key / field name being translated. |
| `getTranslatedText(): string` | the current translated text. |
| `setTranslatedText(string): void` | replace the translated text (your change is what gets saved). |

## Subscribe

```php
// my_module.services.yml
services:
  my_module.google_v3_post:
    class: Drupal\my_module\EventSubscriber\GoogleV3PostSubscriber
    tags: [{ name: event_subscriber }]
```

```php
use Drupal\tmgmt_google_v3\Event\PostTranslationEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class GoogleV3PostSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [PostTranslationEvent::POST_TRANSLATION => 'onPostTranslation'];
  }
  public function onPostTranslation(PostTranslationEvent $event): void {
    $text = $event->getTranslatedText();
    // e.g. fix a token, restore markup, normalise whitespace...
    $event->setTranslatedText($text);
  }
}
```

Use it to repair markup/tokens Google may have altered, enforce terminology beyond glossaries, or
adjust per-field formatting. This is the module's only extension point (no Drupal hooks, no
`.api.php`).
