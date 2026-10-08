<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event capture, change-set aggregation & generation pipeline

## Capture (`changelogify_event`)
Hooks are OOP in `Hook\ChangelogifyHooks` (`#[Hook(...)]`) with `#[LegacyHook]` procedural wrappers in `changelogify.module` for cores < 11.1. They delegate to tagged event sources:
- `EventSource\ContentEventSource` — `entity_insert/update/delete` (respecting `ContentCapturePolicy` and `track_content`/`track_unpublished_content`).
- `EventSource\ModuleEventSource` — modules/themes installed/uninstalled (`track_modules`).
- `EventSource\UserEventSource` — user insert/update (`track_users`).
- `EventSource\ConfigImportEventSource` + `EventSubscriber\ConfigImportSubscriber` — correlates configuration-import changes (`config_import.*` settings).

`EventSource\EventSourceRegistry` collects all `changelogify.event_source`-tagged services (`!tagged_iterator`). Events are written through `EventSource\EventSourceRecorder` / `EventManager` into `changelogify_event` entities (source, type, message, metadata, correlation id, related bundle — see `src/Entity/ChangelogifyEvent.php`). `EventSource\ContentCapturePolicy` decides per entity-type/bundle whether to record. Add a custom source by defining a service implementing `EventSourceInterface` and tagging it `changelogify.event_source`.

## Change sets
`ChangeSet\ChangeSetAggregator` (`ChangeSetAggregatorInterface`) groups raw events into `ChangeSet` objects using `!tagged_iterator changelogify.change_set_grouping_strategy` (`ChangeSetGroupingStrategyInterface`), returning an `AggregationResult`. `EntityDifference\EntityDifferenceService` computes changed-field detail; `ConfigClassifier\ConfigClassifier` (tagged `changelogify.config_classifier`, extendable via `ConfigClassifierExtensionInterface`) classifies config changes.

## Generation & provenance
`ReleaseGenerator::previewRange()/previewSinceLast()` build a `ReleasePreview` (change sets + `ReleaseCoverageAnalyzer` coverage) with no save; `generateReleaseFromRange()` creates a draft. `Provenance\ReleaseProvenanceManager` attaches privacy-bounded evidence to the release (`provenance` JSON, validated by the entity). `EventReleaseUsage` tracks which events a release consumed. Admin `Controller\ReleaseProvenanceController` (route `changelogify.release_provenance`, permission `manage changelogify releases`) shows source evidence; `Controller\EventExplorerController` + `Form\EventExplorerFilterForm` browse raw events (`administer changelogify`).

## Scheduling & retention
`ScheduledPublicationManager` (injected `@lock`) publishes due releases from an approved revision on cron. `Hook\ChangelogifyHooks::cron()` also purges events older than `event_retention_days` and provenance older than `provenance_retention_days` (both `0` = keep forever).

## Admin entry points
`Controller\DashboardController` (`changelogify.dashboard` `/admin/config/development/changelogify`, and `.content_entry` `/admin/content/changelogify`), both `administer changelogify`. Menu/task links in `changelogify.links.menu.yml` / `.links.task.yml`.
