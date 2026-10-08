<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js Extras — details

## Computed `content_translations` field

`next_extras_entity_base_field_info(EntityTypeInterface $entity_type)` adds a computed, unlimited
base field `content_translations` to the **node** entity type **when `content_translation` is
enabled**:

```php
$fields['content_translations'] = BaseFieldDefinition::create('content_translations')
  ->setLabel(t('Content Translations'))
  ->setCardinality(FieldStorageDefinitionInterface::CARDINALITY_UNLIMITED)
  ->setComputed(TRUE);
```

Backed by the field plugins `Drupal\next_extras\Plugin\Field\FieldType\ContentTranslationsItem` and
`ContentTranslationsFieldItemList` (a `content_translations` field type). It surfaces the node's
translations to a decoupled front end (e.g. via JSON:API).

## Legacy "Revalidate" third-party settings (deprecated)

`next_extras_form_next_entity_type_config_edit_form_alter()` adds an **Experimental** details group to
the `next_entity_type_config` edit form containing:

- **Revalidate** checkbox → third-party setting `next_extras.revalidate` (bool).
- **Paths** textarea (visible when Revalidate is checked) → `next_extras.revalidate_paths` (string,
  one path per line, e.g. `/blog`).

The form shows a **DEPRECATED** warning ("See On-demand Revalidation"). Stored via an entity builder:

```php
$entity->setThirdPartySetting('next_extras', 'revalidate', (bool) $form_state->getValue('revalidate'));
$entity->setThirdPartySetting('next_extras', 'revalidate_paths', $form_state->getValue('revalidate_paths'));
```

Read/set in code:

```php
$c = \Drupal\next\Entity\NextEntityTypeConfig::load('node.article');
$c->getThirdPartySetting('next_extras', 'revalidate');        // bool
$c->getThirdPartySetting('next_extras', 'revalidate_paths');  // string
$c->setThirdPartySetting('next_extras', 'revalidate', TRUE)->save();
```

Config schema: `next.next_entity_type_config.*.third_party.next_extras` → `{ revalidate: bool,
revalidate_paths: string }`. The parent's `next_update_9105()` migrates an enabled `revalidate` to the
`path` revalidator; prefer the parent's `path`/`cache_tag` revalidators for new work.

## `NextCacheInvalidator` service (legacy)

`next_extras.cache_invalidator` (`Drupal\next_extras\NextCacheInvalidator`, args:
`next.entity_type.manager`, `http_client`, `logger.channel.next_extras`) provides
`getSitesToInvalidate($entity)` and `invalidatePath($path, $sites)` HTTP-based invalidation. The
procedural helper `_next_extras_invalidate_entity_cache()` is explicitly **deprecated**.
