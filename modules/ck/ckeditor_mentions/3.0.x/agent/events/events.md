# Events

`src/Events/CKEditorEvents.php` defines three event names. Two fire when an entity containing a
mention is saved; one fires while suggestions are being built.

| Constant | Name string | Event object | When |
|---|---|---|---|
| `CKEditorEvents::MENTION_FIRST` | `ckeditor_mentions.mention` | `CKEditorMentionsEvent` | `hook_entity_insert` on any entity — for each mention found in its text fields |
| `CKEditorEvents::MENTION_SUBSEQUENT` | `ckeditor_mentions.mention_subsequent` | `CKEditorMentionsEvent` | `hook_entity_update` on any entity — for each mention found |
| `CKEditorEvents::SUGGESTION` | `ckeditor_mentions.suggestion_event` | `CKEditorMentionSuggestionsEvent` | inside `MentionsTypeBase::buildResponse()`, before suggestions are returned to the autocomplete |

Dispatch of the two mention events is done by service
`ckeditor_mentions.mention_event_dispatcher` from `ckeditor_mentions.module`'s
`hook_entity_insert` / `hook_entity_update` (see [api/services.md](../api/services.md)). Note the
name pair is slightly counter-intuitive: **insert → MENTION_FIRST**, **update → MENTION_SUBSEQUENT**.

## Event objects
- `CKEditorMentionsEvent` (`implements CKEditorMentionEventInterface`): `getEntity()` (the entity that was saved), `getMentionedEntity()` (the referenced entity), `getPlugin()` (the `MentionsTypeInterface`). Setters exist for each.
- `CKEditorMentionSuggestionsEvent`: `getKeyword()` (the typed match), `getSuggestions()` / `setSuggestions()` — a subscriber can filter, reorder, or replace the autocomplete list.

## Subscribe (typical use — notify a mentioned user)
```php
use Drupal\ckeditor_mentions\Events\CKEditorEvents;
use Drupal\ckeditor_mentions\Events\CKEditorMentionsEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MentionNotifier implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [CKEditorEvents::MENTION_FIRST => 'onMention'];
  }
  public function onMention(CKEditorMentionsEvent $event): void {
    $mentioned = $event->getMentionedEntity(); // e.g. a user
    $source    = $event->getEntity();          // node/comment it was mentioned in
    // …send a message / flag / etc.
  }
}
```

## Rules / ECA
`ckeditor_mentions.rules.events.yml` exposes the two mention events to Rules and ECA under
category **Mentions**, with context `entity`, `mentionedEntity`, and `plugin`:
- `ckeditor_mentions.mention` — "After mentioning entity"
- `ckeditor_mentions.mention_subsequent` — "After mentioning entity all except first time"

This is the no-code path to react to a mention (send an email, create a message) without writing
an EventSubscriber.
