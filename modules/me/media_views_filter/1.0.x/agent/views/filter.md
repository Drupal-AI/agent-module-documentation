<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `media_file_name` Views filter

**Class:** `Drupal\media_views_filter\Plugin\views\filter\MediaFileNameFilter`
**Annotation:** `@ViewsFilter("media_file_name")`
**Extends:** `Drupal\views\Plugin\views\filter\StringFilter`
**Registered as:** in `hook_views_data()`, `media_field_data.media_file_name_filter`
(`filter` → `id: media_file_name`, `field: name`, title "Media name/file name",
help "Filters by media name, file name and other attributes.").

This is the module's core feature: one exposed text filter on a core **media** view that searches
across both media-entity and file-entity strings simultaneously.

## Operators — "contains" only

`operators()` calls the parent then **unsets everything except `contains`**: `=`, `!=`, `word`,
`allwords`, `starts`, `not_starts`, `ends`, `not_ends`, `shorterthan`, `longerthan`,
`regular_expression`, `empty`, `not empty` are all removed. So in the UI the only comparison a user
can make is "contains". (An `@todo` in the source wonders why `word`/`allwords` return no results.)

## Dependency injection

Constructor takes the standard `StringFilter` args plus a `ViewsHandlerManager`
(`plugin.manager.views.join`), stored as `$this->viewsHandlerManager`. `create()` injects
`database` and `plugin.manager.views.join`.

## `query()` — what it builds

```
parent::query();

// 1. LEFT (standard) join media_field_data.mid -> file_usage.id
$join_1 = viewsHandlerManager->createInstance('standard', [
  'table' => 'file_usage', 'field' => 'id',
  'left_table' => 'media_field_data', 'left_field' => 'mid',
]);
$query->addRelationship('file_usage', $join_1, 'file_usage');

// 2. INNER join file_usage.fid -> file_managed.fid
$join_2 = viewsHandlerManager->createInstance('standard', [
  'type' => 'INNER', 'table' => 'file_managed', 'field' => 'fid',
  'left_table' => 'file_usage', 'left_field' => 'fid',
]);
$query->addRelationship('file_managed', $join_2, 'file_managed');

// 3. De-duplicate rows (one media can have many file_usage rows)
$query->addField(NULL, 'media_field_data.mid', '', ['function' => 'groupby']);
$query->addGroupBy('media_field_data.mid');
$query->addGroupBy('media_field_data.changed');   // @todo Acquia /admin/content/media fix

// 4. Delete the default WHERE the framework added on media_field_data.name
foreach ($query->where as $wk => $where) {
  foreach ($where['conditions'] as $ck => $c) {
    if ($c['field'] == 'media_field_data.name') unset($query->where[$wk]['conditions'][$ck]);
  }
}

// 5. New OR where-group, five LIKE '%value%' matches
$gid = $query->setWhereGroup('OR');
$query->addWhere($gid, 'media_field_data.name', '%'.escapeLike($value).'%', 'LIKE');
$ph  = $this->placeholder().'_value';
$query->addWhereExpression($gid,
  "REPLACE(REPLACE(file_managed.uri, 'public://', ''), 'private://', '') LIKE $ph",
  [$ph => '%'.escapeLike($value).'%']);
$query->addWhere($gid, 'file_managed.filename', '%'.escapeLike($value).'%', 'LIKE');
$query->addWhere($gid, 'media_field_data.thumbnail__alt',   '%'.escapeLike($value).'%', 'LIKE');
$query->addWhere($gid, 'media_field_data.thumbnail__title', '%'.escapeLike($value).'%', 'LIKE');
```

### Columns the single value is matched against (OR)

1. `media_field_data.name` — the media entity label.
2. `file_managed.uri` — normalised with `REPLACE` to drop the `public://` / `private://` stream
   prefix (so a search for `sites/...` or a folder name matches; the raw scheme is excluded).
3. `file_managed.filename` — the stored filename (note: the source comments that this "does not
   always contain the real filename", which is why the URI is searched too).
4. `media_field_data.thumbnail__alt` — image alt text.
5. `media_field_data.thumbnail__title` — image title attribute.

## Why the joins and GROUP BY

A single media entity can be recorded in `file_usage` multiple times (multiple usages of the same
file), which would multiply result rows. The `GROUP BY media_field_data.mid` collapses those back to
one row per media item. The extra `GROUP BY media_field_data.changed` is a workaround (`@todo`) for a
grouping error seen on Acquia at `/admin/content/media`.

## Security note (query safety)

All five comparisons take the user value through `Connection::escapeLike()` (escaping `%` and `_`)
and pass it either as the `$value` argument of `addWhere()` (bound parameter) or as a **named
placeholder** in `addWhereExpression()` (`[$ph => '%'.escapeLike($value).'%']`). The value is never
concatenated into SQL text. This is the correct, injection-safe pattern for a Views string filter.

## Usage

Add this filter to a media-based view, expose it, and remove the stock "Media: Name" filter. It is
most useful on the `media_library` modal view and on `/admin/content/media`. Because it is a
`StringFilter`, it works with exposed-filter forms and Better Exposed Filters like any core string
filter.
