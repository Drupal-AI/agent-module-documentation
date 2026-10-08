<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Destination plugins

All classes are in `src/Plugin/migrate/destination/d7/` and extend
`migrate` `DestinationBase`. They write **directly to database tables** on the current (destination)
Drupal connection, not through entity APIs. Reference by `id` under a migration's `destination`.

## `content_access` (`ContentAccess.php`)

`import()` deletes any existing `content_access` row for the `nid`, then inserts a row with `nid`
and `settings` from the destination properties; returns the insert result. `getIds()` = `nid`
(integer). Targets the D7 Content Access module's `content_access` table. No rollback method.

## `edw_draggableviews` (`DraggableViews.php`)

`import()` inserts a row into `draggableviews_structure` with `view_name`, `view_display`, `args`,
`entity_id`, `weight`, `parent`. `getIds()` = `dvid` (integer). No rollback method.

## `d7_locale_source` (`LocaleSource.php`)

Implements `ContainerFactoryPluginInterface`; injects the `database` service; sets
`supportsRollback = TRUE`. `import()` inserts a `locales_source` row (`lid`, `source`, `context`,
`version`) when there is no existing destination id, otherwise updates that row by `lid`; returns
`[lid]`. `rollback()` deletes matching `locales_source` rows by `lid IN (…)`. `getIds()` = `lid`
(integer).

## `d7_locale_target` (`LocaleTarget.php`)

Same injection/rollback pattern. `import()` inserts a `locales_target` row (`lid`, `translation`,
`language`) when no prior destination id, otherwise updates the `translation` by `lid` + `language`;
returns `['lid' => …, 'language' => …]`. `rollback()` deletes `locales_target` rows by `lid IN (…)`.
`getIds()` = `lid` (integer) + `language` (string).

> Note: the `d7_locale_source` / `d7_locale_target` **ids collide with the same-named D7 source
> plugins** (`source/d7/LocaleSource.php`, `LocaleTarget.php`). Source and destination plugin ids
> live in separate namespaces, so a migration can use `d7_locale_source` as its source and
> `d7_locale_target` as its destination.
