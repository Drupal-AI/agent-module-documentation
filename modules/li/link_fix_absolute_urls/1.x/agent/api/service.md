<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the LinkProcessor service

The module's entire logic lives in one service, exposed for reuse.

- **Service id:** `link_fix_absolute_urls.link_processor`
- **Class:** `Drupal\link_fix_absolute_urls\LinkProcessor` (`src/LinkProcessor.php`)
- **Constructor args (services.yml):** `@path_alias.manager` (`AliasManagerInterface`), `@entity_type.manager` (`EntityTypeManagerInterface`)
- **Public method:** `process(ContentEntityInterface $entity): bool`

## What `process()` does (`src/LinkProcessor.php:51`)
1. Computes the site base URL: `Url::fromRoute('<front>', [], ['absolute' => TRUE])->toString()`, then `stripPrefixes()` removes `http://`, `https://`, `www.` (`:56`–`:59`).
2. Iterates `$entity->getFieldDefinitions()`; acts only on fields where `$field->getType() == 'link'` and `$entity->hasField($field_name)` (`:62`–`:69`).
3. For each field item, `$url = $item->getUrl()`; only external URIs (`$url->isExternal()`) are considered (`:71`–`:76`). Off-site links are ignored.
4. `stripPrefixes()` the item URI, then require it to start with the (prefix-stripped) base URL via `strpos($uri, $base_url) === 0` (`:80`–`:83`). Otherwise skip.
5. `$bare_path = str_replace($base_url, '', $uri)` (`:86`), then map it:
   - `file_exists($bare_path)` true → `internal:/<bare_path>` (local file) (`:89`).
   - empty `$bare_path` → `internal:/` (front page) (`:95`).
   - else prepend `/`, resolve aliases with `aliasManager->getPathByAlias('/<bare_path>')`; if it resolves to a different raw path, run `getInternalPath($raw_path)`, else `getInternalPath('/<bare_path>')` (`:100`–`:120`).
6. `getInternalPath()` (`:150`): builds `Url::fromUri('internal:'.$path)`. If routed and the route has parameters and the entity type is `node`, loads it via `entityTypeManager->getStorage('node')` and returns `entity:node/<id>`; other routed types return `internal:<path>`; unrouted/invalid paths fall back to `internal:<path>` as-is.
7. When a new URI is produced it calls `$item->setValue(['uri' => $new_path, 'title' => $item->get('title')->getValue()])` — **title is preserved** — and marks `$changed = TRUE` (`:124`–`:130`).
8. Returns `$changed`. **It does NOT save the entity.** In presave the mutated values are picked up by the save already in progress.

## Automatic trigger
`link_fix_absolute_urls_entity_presave()` calls the service on every save. It short-circuits when the entity lacks a public `getFieldDefinitions()` and skips `\Drupal\redirect\Entity\Redirect` (`link_fix_absolute_urls.module:28`–`:51`). No configuration selects which fields/entities are processed — all `link` fields on all such entities are.

## Bulk-fixing existing content
Presave only fixes links on future saves. To repair links already stored, re-save the entities. Either just call `$entity->save()` (the presave hook runs), or call the service explicitly and save only when it reports a change:

```php
$changed = \Drupal::service('link_fix_absolute_urls.link_processor')->process($entity);
if ($changed) {
  $entity->save();
}
```

The README recommends doing this from a `hook_post_update_NAME()` to migrate a whole site's content.
