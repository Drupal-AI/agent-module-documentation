<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The compression-reload mechanism

## Interface contract

`ViewsReferenceExtrasCompressionReload` implements
`Drupal\viewsreference\ViewsReferenceCompressionInterface` (from the parent module) plus
`ContainerInjectionInterface`. The interface is two methods:

```php
public function compress(array $viewsreference, ViewExecutable $view): array;
public function uncompress(array $viewsreference, ViewExecutable $view): array;
```

Both receive the `#viewsreference` render-element array the parent formatter builds, which
contains: `data` (serialized per-plugin setting values), `enabled_settings`, and the pointer
fields `parent_entity_type`, `parent_entity_id`, `parent_revision_id`, `parent_entity_langcode`,
`parent_field_name`, `field_item_delta`.

## Service override

`viewsreference_extras.services.yml` re-declares the parent's service id, so the whole site uses
this class instead of `Drupal\viewsreference\ViewsReferenceCompression`:

```yaml
services:
  viewsreference.compression:
    class: Drupal\viewsreference_extras\ViewsReferenceExtrasCompressionReload
    arguments: ['@entity_type.manager', '@current_user']
```

Constructor dependencies: `EntityTypeManagerInterface` and `AccountProxyInterface` (current user).

## Where it is called

The parent `viewsreference.module` calls the service:

- `viewsreference_views_pre_render()` — on an AJAX-enabled, non-attachment, non-preview view,
  calls `compress()` and stashes the result under
  `#attached.drupalSettings.views.ajaxViews[views_dom_id:*].viewsreference`. That is what the
  Views AJAX request carries back to the server.
- `hook_views_pre_view` (in `viewsreference_views_pre_view()`) — on the return AJAX request, calls
  `uncompress()` to restore `#viewsreference` before each enabled setting plugin's `alterView()`
  runs.

## compress()

```php
unset($viewsreference['data']);        // drop the bulky serialized settings
unset($viewsreference['compressed']);  // drop any prior parent-style payload
$json = Json::encode($viewsreference); // the small pointer that remains
return ['reload' => UrlHelper::compressQueryParameter($json)];
```

Only the pointer travels in the URL, gzip-packed into a single `reload` parameter — bounded in
size no matter how many options the field defines. (Parent, by contrast, keeps `data` and packs
the lot into `compressed`, which is what overflows to 414.)

## uncompress()

1. If there is no `reload` key, return the array unchanged (nothing to do).
2. `UrlHelper::uncompressQueryParameter()` + `Json::decode()` recover the pointer array.
3. Load the parent entity: `getStorage($reload['parent_entity_type'])` then
   `loadRevision($reload['parent_revision_id'])` when a revision id is present **and** the storage
   is a `RevisionableStorageInterface`, otherwise `load($reload['parent_entity_id'])`.
4. If the entity is `TranslatableInterface` and has the recorded `parent_entity_langcode`
   translation, switch to it — so translation-dependent settings (e.g. language-restriction
   filters) re-derive from the correct translation rather than the default one.
5. **Access + field guard, all-or-nothing in one `if`:** the entity must be a
   `FieldableEntityInterface`, must have `parent_field_name`, must pass
   `$entity->access('view', $this->currentUser)`, and must return the field item list. Only then
   is `data` rebuilt.
6. Re-read `data` from the field item(s): iterate the item list, honour `field_item_delta` (skip
   other deltas on a multi-value field), and
   `unserialize($item->getValue()['data'], ['allowed_classes' => FALSE])`.
7. Return the reconstructed `$reload` array (now including `data`) as the restored
   `#viewsreference`.

## Safety notes baked into the code

- **`allowed_classes' => FALSE`** on the unserialize → no PHP object injection even though `data`
  originates from stored field content.
- **Explicit `access('view')` check** before re-reading field data — a guard the parent service
  lacks. The in-code comment states the intent: *"Double-check access ... in case the user manages
  to manipulate the compressed query string to result in a different entity ID."* So a tampered
  `reload` pointer cannot pull settings out of an entity the current user cannot view.
- View **display access** is still enforced by Views' own access plugin at execution time; this
  service only reconstructs the settings array.
