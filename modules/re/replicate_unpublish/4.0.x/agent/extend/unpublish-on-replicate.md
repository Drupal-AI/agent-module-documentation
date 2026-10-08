# Unpublish-on-replicate behavior

## The subscriber

`src/EventSubscriber/ReplicateUnpublishNode.php` implements `EventSubscriberInterface` and
listens on Replicate's alter event:

```php
public static function getSubscribedEvents(): array {
  return [ReplicatorEvents::REPLICATE_ALTER => [['setUnpublished']]];
}
```

`setUnpublished(ReplicateAlterEvent $event)`:

1. `$clone = $event->getEntity();` — bail unless `$clone instanceof \Drupal\node\Entity\Node`.
2. Loop `\Drupal::service('language_manager')->getLanguages()` (all enabled languages).
3. For each `$langcode`, if `$clone->hasTranslation($langcode)`, get that translation and
   `->set('status', Node::NOT_PUBLISHED)`.

It only mutates the in-memory clone that Replicate is about to save — it does not save the node
itself; Replicate persists it afterward. Nothing is done for non-node entities.

## Extending or overriding

- **Cover other entity types** (media, taxonomy, custom): write your own subscriber on
  `ReplicatorEvents::REPLICATE_ALTER` and set the relevant published field, or decorate the
  `replicate_unpublish.replicate_node` service. There is no config toggle for entity type.
- **Only unpublish some bundles / conditionally**: replace the service with a subclass that adds
  your bundle/field checks before calling `set('status', …)`.
- **Also reset workflow/moderation state**: react to the same event and set your
  `moderation_state` field — this module does not touch Content Moderation.
- There are no hooks, no `*.api.php`, and no settings; behavior is entirely in this one subscriber.
