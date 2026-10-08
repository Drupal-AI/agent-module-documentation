<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import-ordering mechanism and clear-cascade

How the module makes a feed import its dependency first, for integrators who extend Feeds or the
handler. Configuration of the dependency itself is in [../fields/dependency.md](../fields/dependency.md).

## Handler swap
`feeds_dependency_entity_type_alter()` replaces the `feeds_feed` entity's `feed_import` handler:

```php
$entity_types['feeds_feed']->setHandlerClass('feed_import', '\Drupal\feeds_dependency\FeedDependencyImportHandler');
```

`Drupal\feeds_dependency\FeedDependencyImportHandler` extends `Drupal\feeds\FeedImportHandler` and
overrides four entry points. Each resolves the current feed's dependencies with
`getFeedDependencies()` (from `FeedDependencyTrait`) and runs each one **before** delegating to the
parent — recursively, so a dependency's own dependencies run too.

| Overridden method | Order applied | Parent call |
|---|---|---|
| `import(FeedInterface $feed)` | imports each dependency first, then `parent::import($feed)` | after deps |
| `startBatchImport(FeedInterface $feed)` | `parent::startBatchImport($feed)` first, then queues each dependency | **parent first** — batch runs LIFO, so dependencies added last execute first |
| `startCronImport(FeedInterface $feed)` | `parent::startCronImport($feed)`, then queues each dependency | parent first |
| `pushImport(FeedInterface $feed, $payload, $file_system = NULL)` | `parent::pushImport(...)`, then pushes the same payload to each dependency | parent first |

Every recursion is guarded by `feedsNotSame($feed, $feed_dependency)` (compares `id()`), which skips
a feed that lists **itself** as a dependency. Note this only breaks the trivial self-loop — a longer
cycle (A → B → A) is not detected and would recurse until it errors, so keep the dependency graph
acyclic.

## Clear-cascade
`feeds_dependency_form_feeds_feed_confirm_form_alter()` targets the feed **clear** ("Delete items")
confirm form. When the feed has a `feed_dependency_id` and its `clear_dependency` value is `TRUE`, it
appends the submit handler `_feeds_dependency_operation_dependency_feed()`. That handler iterates the
referenced dependency feeds and, for each one that is not the feed itself, calls
`$feed_dependency->startBatchClear()` (a `sleep(1)` precedes each to stagger the batches). So clearing
a feed can also clear the feeds it depends on.

## `FeedDependencyTrait` helpers
`Drupal\feeds_dependency\FeedDependencyTrait` (used by the handler):

| Method | Returns | Purpose |
|---|---|---|
| `getFeedDependencies(FeedInterface $feed)` | `FeedInterface[]` | `$feed->get('feed_dependency_id')->referencedEntities()` (empty array if none). |
| `feedsNotSame(FeedInterface $feed, FeedInterface $feed_dependency)` | `bool` | `TRUE` when the two feed ids differ (self-loop guard). |
| `clearFeedDependency(FeedInterface $feed)` | `bool` | `(bool) $feed->get('clear_dependency')->value`. |

## Hooks summary
| Hook | Effect |
|---|---|
| `hook_entity_base_field_info` | Adds `feed_dependency_id` and `clear_dependency` to `feeds_feed`. |
| `hook_entity_type_alter` | Overrides the `feed_import` handler with `FeedDependencyImportHandler`. |
| `hook_form_feeds_feed_confirm_form_alter` | Adds the clear-cascade submit handler on the clear operation. |
| `hook_help` | Help text on `help.page.feeds_dependency`. |
