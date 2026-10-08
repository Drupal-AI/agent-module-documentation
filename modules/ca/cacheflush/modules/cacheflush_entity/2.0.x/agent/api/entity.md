# The `cacheflush` entity & helper API

## Entity

`Drupal\cacheflush_entity\Entity\CacheflushEntity`, `@ContentEntityType(id = "cacheflush",
base_table = "cacheflush")`, keys `id` / `label`=`title` / `uuid`. Implements
`CacheflushEntityInterface` (ContentEntity + EntityChanged + EntityOwner).

Base fields (`baseFieldDefinitions()`):

| Field | Type | Notes |
|---|---|---|
| `id` | integer | PK, read-only |
| `uuid` | uuid | |
| `title` | string (80) | the label |
| `uid` | entity_reference → user | author; `preCreate()` defaults it to the current user |
| `status` | boolean | 1 = published/enabled; 0 disables clearing (403 on clear) |
| `data` | map | serialized preset function map (see below) |
| `created` / `changed` | created / changed | timestamps |

`menu` (cacheflush_ui) and `cron` (cacheflush_cron) are added to this entity via
`hook_entity_base_field_info()` in those submodules.

Accessors: `getTitle()/setTitle()`, `getStatus()/setStatus()`, `getData()/setData()`,
`getCreatedTime()`, `getOwner()/getOwnerId()/setOwner()/setOwnerId()`. `setData($array)` stores
`serialize($array)` into the `data` map; `getData()` returns the stored value (the first item).

## Procedural helpers (`cacheflush_entity.module`)

```php
cacheflush_create(array $values = []);              // ::getStorage('cacheflush')->create($values)
cacheflush_load($id);                               // load one
cacheflush_load_multiple(array $ids = NULL);        // load many (all if null)
cacheflush_load_multiple_by_properties(array $v);   // ->loadByProperties($v)
cacheflush_delete($id);                             // delete one
cacheflush_delete_multiple(array $ids);             // delete many
```

Common patterns:

```php
// Create + save an enabled preset.
$e = cacheflush_create(['title' => 'Render only', 'status' => 1]);
$e->setData(['render' => ['functions' => [
  ['#name' => '\Drupal\cacheflush\Controller\CacheflushApi::clearBinCache', '#params' => ['cache.render']],
]]]);
$e->save();

// Only the enabled presets (as the Drush command and clear routes use).
$enabled = cacheflush_load_multiple_by_properties(['status' => 1]);
```

Equivalent modern API: `\Drupal::entityTypeManager()->getStorage('cacheflush')` and
`\Drupal::entityQuery('cacheflush')`. Read the raw table with
`drush sqlq "SELECT id, title, status FROM cacheflush"`.
