# Generate / read tags in code

Service `metatag.manager` (`Drupal\metatag\MetatagManagerInterface`).

```php
/** @var \Drupal\metatag\MetatagManagerInterface $m */
$m = \Drupal::service('metatag.manager');

// Tag values stored on an entity's metatag field (raw, no defaults).
$tags = $m->tagsFromEntity($node);

// Tag values merged with the default-inheritance chain (what will render).
$tags = $m->tagsFromEntityWithDefaults($node);

// Just the inherited defaults for the entity.
$defaults = $m->defaultTagsFromEntity($node);

// Turn a tag value array into a render array of processed elements…
$elements = $m->generateElements($tags, $node);
// …or raw #attached html_head elements (tokens replaced, cache metadata bubbled).
$raw = $m->generateRawElements($tags, $node);
```

Other useful methods: `sortedGroups()`, `sortedTags()`, `sortedGroupsWithTags()` (plugin
definitions for building forms), and `form($values, $element, $token_types, …)` to embed
the tag-entry form in your own form.

Related services: `metatag.token` (token replacement with entity mapping),
`metatag.trimmer` (length trimming), `plugin.manager.metatag.tag`,
`plugin.manager.metatag.group`. Normally tags render automatically for entity canonical
routes; call the manager directly only for custom pages or programmatic output.
