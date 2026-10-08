<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Changelogify (changelogify) — agent index

Automatically collects site change events, groups them into structured **Release** entities, and publishes a themeable public changelog (page + RSS/Atom + JSON API). Version dir **1.8.x** (installed 1.8.1). Core `^10.3 || ^11`, PHP `>=8.1`.

## Dependencies
Core: `content_translation`, `language`, `node`, `options`, `user`. No external libraries. Optional submodule `changelogify_ai` adds AI drafting and requires `drupal/ai ^1.4`.

## Entities
- `changelogify_event` — captured raw change event (revisionable-free content entity; source, type, message, metadata, correlation id). See `src/Entity/ChangelogifyEvent.php`.
- `changelogify_release` — the published unit; revisionable + translatable, JSON `sections`/`provenance` fields, editorial-state workflow, public slug + slug_history, scheduled publication. Access handler `Access\ChangelogifyReleaseAccessControlHandler`. See `agent/entities/release.md`.

## Permissions
`administer changelogify`, `manage changelogify releases`, `submit changelogify releases for review`, `publish changelogify releases`, `archive changelogify releases`, `view changelogify release revisions`, `revert changelogify release revisions`, `view changelogify releases`.

## Key services (all autowired, `changelogify.services.yml`)
- `EventManager` / `EventSource\EventSourceRecorder` — record events; `EventSource\EventSourceRegistry` collects `changelogify.event_source`-tagged sources (`ContentEventSource`, `ModuleEventSource`, `UserEventSource`, `ConfigImportEventSource`).
- `ReleaseGenerator` (`ReleaseGeneratorInterface`) — preview/generate releases from a date range or since-last.
- `ChangeSet\ChangeSetAggregator` — groups events into change sets (tagged `changelogify.change_set_grouping_strategy`).
- `PublicReleaseBuilder` — loads/translates/formats accessible published releases for all public output.
- `ReleaseSlugManager` — slug generation, history, resolution.
- `Provenance\ReleaseProvenanceManager`, `EntityDifference\EntityDifferenceService`, `ConfigClassifier\ConfigClassifier` (tagged `changelogify.config_classifier`), `ScheduledPublicationManager`, `EventSubscriber\ApiEtagSubscriber`, `EventSubscriber\ConfigImportSubscriber`, `Routing\RouteSubscriber`, `Hook\ChangelogifyHooks`.

## Routes (`changelogify.routing.yml`)
Admin: `changelogify.dashboard`, `.content_entry`, `.settings`, `.generate_release`, `.release_provenance`, `.event_detail`. Public (path prefix is the configurable `changelog_path`, default `/changelog`): `.changelog` (listing, `_access: TRUE`), `.changelog_release` (`/{release_slug}`, `_access: TRUE`), `.changelog_release_legacy` (numeric redirect), `.feed_rss`, `.feed_atom`, `.api_v1_releases`, `.api_v1_release`. `RouteSubscriber` rewrites the public paths from config at rebuild.

## Plugins
Blocks: `Plugin\Block\LatestReleaseBlock`, `Plugin\Block\RecentReleasesBlock` (base `ReleaseBlockBase`). No custom plugin *type* is defined; extension points are tagged-service collectors (event_source, change_set_grouping_strategy, config_classifier).

## Hooks
`Hook\ChangelogifyHooks` (OOP `#[Hook]` + `#[LegacyHook]` wrappers in `.module`): entity insert/update/delete, modules/themes installed/uninstalled, user insert/update → event capture; `theme` (3 templates); `cron` → scheduled publication + event/provenance purge.

## Solution docs
- `agent/config/settings.md` — `changelogify.settings` config object, schema, capture policy, retention.
- `agent/entities/release.md` — Release entity, editorial workflow, access, slugs, provenance, scheduling.
- `agent/api/public-output.md` — public page/templates, RSS/Atom feeds, JSON API v1, blocks.
- `agent/architecture/event-capture.md` — event sources, change-set aggregation, release generation.
- Submodule: `modules/changelogify_ai/1.8.x/agent/start.md`.
