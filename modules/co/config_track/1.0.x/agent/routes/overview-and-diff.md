<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Track — report UI, routes & diff

Source: `config_track.routing.yml`, `config_track.links.menu.yml`,
`src/Controller/ConfigTrackController.php`.

## Routes (both admin, both `administer site configuration`)

- `config_track.config_track.overview` — `/config-revisions` →
  `ConfigTrackController::overview()`. Title "Config Revisions". Reachable via the menu link under
  Administration > Configuration > Development (`system.admin_config_development`).
- `config_track.config_track.single` — `/config-revisions/{revision_id}` (`revision_id: \d+`) →
  `ConfigTrackController::revision()`, title from `revisionTitle()`.

There are no other routes, no form routes, and no permission beyond the core
`administer site configuration` — the same permission that already grants full read/write of every
config object. Access to config history is therefore equivalent to config-admin access; scope that
role deliberately since configuration can hold sensitive values.

## overview() — the list

Builds a `#type => table` (header: Date, Revision, Name, Collection, Operation, User, Operations).
Uses `pager.manager`: a `countQuery()` on `config_track`, then a `select` of
`timestamp, revision_id, name, collection, operation, uid` ordered by `timestamp DESC, revision_id
DESC`, ranged by `$this->limit` (50) per page. Per row it formats the timestamp
(`DateTimePlus::createFromTimestamp(...)->format(...)`), turns `uid` into a user link
(`userStorage->load($uid)->toLink()`), and adds a "Details" operation linking to the single route.
Cache tags `['config-revision-list']` (invalidated by the shutdown writer).

## revision() — the diff

Loads the target row (incl. `data`), then the **previous** row for the same `name` + `collection`
with `revision_id < current` (ordered newest-first, range 0,1). Both blobs are decoded with
`unserialize($data, ['allowed_classes' => FALSE])` — object instantiation is disabled, so a stored
blob cannot be leveraged for PHP object injection. `getDiff()` writes each side into a
`Core\Config\MemoryStorage` and calls `configManager->diff($source, $target, $name)` to produce a
`Component\Diff\Diff`. It is rendered with a manually-instantiated `Core\Diff\DiffFormatter`
(no service exists) into a `#type => table` with class `diff`, attaching library `system/diff`.
The page title uses the `@config_file` placeholder (`$this->t(...)`), and all diff/cell content
flows through Drupal render arrays / the table theme, so config values are auto-escaped on output.

`isDiffEmpty()` (used by the shutdown writer, not the UI) returns TRUE when every edit in the diff
is a `copy` — that's how no-op re-saves are filtered out before insertion.

## Operating

- Grant `administer site configuration` to see the report; there is nothing else to configure.
- The list is paged at 50; the diff always compares to the immediately preceding revision of the
  same object+collection.
