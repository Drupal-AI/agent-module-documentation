<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storage service & the record pipeline

Service **`orejime_register.database`** → `Drupal\orejime_register\Services\Database`
(constructed with `@database`, `@entity_type.manager`). This is the whole storage layer; the
module has no config, no entities of its own, and no settings form.

## The table

`Database::TABLE_NAME = 'orejime_register__cookie_register'`. Created by `hook_schema()`
(`orejime_register.install`), which just returns `Database::getSchema()`:

| column        | type                  | meaning                                            |
|---------------|-----------------------|----------------------------------------------------|
| `id`          | serial (PK, unsigned) | auto-increment row id                              |
| `created_at`  | datetime (`varchar` + `mysql_type: datetime`, not null) | timestamp of the entry |
| `{name}_{id}` | tinyint (`int` + `mysql_type: tinyint`) | one **per Orejime service** — 1 = accepted, 0 = declined |

The per-service columns are **not** in the schema. They are added at runtime: on install,
`hook_install()` loops existing `orejime_service` entities and calls `createColumn()` for each; the
`orejime_service_insert`/`orejime_service_presave` hooks add/rename columns as services change (see
[hooks/hooks.md](../hooks/hooks.md)). So the table shape follows the Orejime consent configuration.

## How a row gets written

1. `hook_page_attachments` attaches library `orejime_register/cookies-register` on every page.
2. `js/cookies-register.js` subscribes to Orejime's consent manager `update` event and
   `fetch('/orejime_register', {method:'POST', body: JSON.stringify(allConsents)})` — `allConsents`
   is an object keyed by service name → boolean.
3. Route `orejime_register.register` (`/orejime_register`) → `RegisterController::save()` does
   `$this->database->addEntry(json_decode($request->getContent(), TRUE))` and returns an empty 200.

`addEntry(array $data)` resolves each JSON key to an `orejime_service` by `name`
(`getQuery()->accessCheck()->condition('name', $name)`), builds column `{name}_{id}`, and — only if
that column `fieldExists()` — records `$field ?: '0'`. Keys that match no service are `unset()`, and
the insert is skipped entirely when nothing matched. A matched insert adds `created_at`. So only
known service columns are written; unknown keys cannot create columns or steer the insert.

## Service methods

| method | signature | effect |
|--------|-----------|--------|
| `addEntry` | `(array $data): void` | write one consent row (the pipeline above) |
| `list` | `(): array` | paged (`PagerSelectExtender`, 20/page, element 0) `fetchAll(FETCH_ASSOC)` of the table |
| `createColumn` | `(Orejime $entity): void` | add tinyint column `{name}_{id}` if the table exists and the column doesn't |
| `updateColumn` | `(Orejime $entity): void` | rename the column when a service's name/id changed (`changeField`) |
| `getSchema` | `(): array` | the two-column base schema keyed by `TABLE_NAME` |
| `purge` | `(): void` | drop and recreate the table (wipes all rows AND all per-service columns) |
| `purgeByDate` | `(\DateTime $start, \DateTime $end): void` | `DELETE` where `created_at >= $start` and `< $end+1 day` (both dates inclusive) |

`Orejime` is `Drupal\orejime\Entity\Orejime` (the `orejime_service` config entity from the parent
module). `Database` extends `ControllerBase` only to reuse `t()`/entity helpers.

## Read or purge from PHP

```php
$db = \Drupal::service('orejime_register.database');

// All entries (associative rows: id, created_at, and one key per service column).
$rows = $db->list();

// Delete a date range (inclusive), e.g. everything in 2025.
$db->purgeByDate(date_create('2025-01-01'), date_create('2025-12-31'));

// Wipe everything (also rebuilds the per-service columns from scratch on next service save).
$db->purge();
```

Note `purge()` drops the table and recreates only the base two columns — the per-service columns
reappear as Orejime services are next saved (or reinstall). To read raw rows without the pager, query
`Database::TABLE_NAME` directly.
