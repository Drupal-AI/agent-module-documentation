# Duplicating entities & bundles

## Duplicate a config bundle (and its fields)
`entity.bundle_entity_duplicator` service (`BundleEntityDuplicator`):

```php
$duplicator = \Drupal::service('entity.bundle_entity_duplicator');
// Clone a bundle config entity + all its field config to a new bundle id/label.
$duplicator->duplicate($node_type, 'article_copy', 'Article copy');
```

It copies the bundle entity, its base field overrides, and attached `field_config` /
`field_storage_config`, so the new bundle is fully usable. `EntityDuplicateSubscriber` keeps
referencing config in sync during duplication.

## React to entity duplication
When a content entity is duplicated (e.g. via the module's duplicate form action), an
`EntityDuplicateEvent` fires:

```php
public static function getSubscribedEvents() {
  return [EntityEvents::ENTITY_DUPLICATE => 'onDuplicate']; // 'entity.duplicate'
}
public function onDuplicate(EntityDuplicateEvent $event) {
  $new    = $event->getEntity();        // the new (unsaved) copy
  $source = $event->getSourceEntity();  // the original
  // adjust the copy before it is saved, e.g. clear a unique field.
}
```

## Duplicate form action
`EntityDuplicateFormTrait` / `EntityDuplicateController` add a "Save as new" flow to entity
forms (exposed via the duplicate route from the route providers).
