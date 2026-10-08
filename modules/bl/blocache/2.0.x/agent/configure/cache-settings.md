# Configure per-block cache settings (Blocache)

Blocache has **no settings page** (`configure: null`). You set cacheability per block, on that
block's configuration form, or directly in the block config entity. The UI only appears for users
with the **`administer block cache`** permission.

## Where it is stored

Config entity: `block.block.<block_id>`. Blocache writes two third-party settings under the
`blocache` namespace:

```yaml
third_party_settings:
  blocache:
    overridden: true          # bool — the master switch; overrides only apply when TRUE
    metadata:
      max-age: 300            # int seconds; -1 = permanent (forever), 0 = not cacheable
      contexts:               # sequence of cache-context strings
        - 'url.path'
        - 'user.roles'
      tags:                   # sequence of cache-tag strings (may contain tokens if token module on)
        - 'node:5'
        - 'config:system.site'
```

Schema: `block.block.*.third_party.blocache` (in `config/schema/blocache.schema.yml`).

- **max-age** semantics: `-1` → `Cache::PERMANENT` (only cache-tag invalidation), `0` → not
  cacheable (also triggers the page cache kill switch on pages containing the block), positive → TTL
  in seconds.
- Contexts entered with an argument are stored joined by `:` (e.g. `url.query_args:page`). The form
  splits/joins these (`Blocache::prepareContextsToStorage()` / `prepareContextsFromStorage()`).
- `array_filter()` is applied on save, so empty contexts/tags are dropped.

## Via the UI

1. Edit any placed block (Appearance → Block layout → the block's *Configure*, or
   `/admin/structure/block/manage/<id>`).
2. Find **Cache Settings**, tick **Override cacheability metadata**.
3. Fill the **Max-Age**, **Contexts**, and **Tags** vertical tabs. Use **Add tag** for extra tags.
4. Save the block.

## Via drush / PHP (scriptable)

```php
$block = \Drupal\block\Entity\Block::load('bartik_search');   // your block id
$block->setThirdPartySetting('blocache', 'overridden', TRUE);
$block->setThirdPartySetting('blocache', 'metadata', [
  'max-age'  => 0,            // make this block non-cacheable
  'contexts' => ['url.path'],
  'tags'     => ['node_list'],
]);
$block->save();
```

Read it back:

```bash
drush cget block.block.<id> third_party_settings.blocache
```

Or in PHP: `$block->getThirdPartySetting('blocache', 'overridden')` and
`$block->getThirdPartySetting('blocache', 'metadata')`.

To disable the override, set `overridden` to FALSE (or unset both keys with
`unsetThirdPartySetting('blocache', 'overridden'|'metadata')`, as `BlocacheMetadata::unsetOverrides()`
does) and save. When `overridden` is FALSE the block falls back to its default (code-defined)
cacheability — Blocache does nothing.
