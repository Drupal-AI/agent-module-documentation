<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Changelogify configuration (`changelogify.settings`)

Config object edited at `/admin/config/development/changelogify/settings` via `Form\SettingsForm` (route `changelogify.settings`, permission `administer changelogify`). Schema: `config/schema/changelogify.schema.yml`. Install defaults: `config/install/changelogify.settings.yml`.

## Keys
- `changelog_path` (string, default `/changelog`) — public base path. `Routing\RouteSubscriber::alterRoutes()` rewrites the public listing/detail/feed/API route paths to this value; `PublicReleaseBuilder`/`ChangelogController` build URLs from it directly (not the route generator) to stay correct across route rebuilds.
- `translation_fallback` (string: `hide` | `fallback` | `label`, default `fallback`) — behavior when a release has no translation for the current interface language. `hide` = not shown publicly; `fallback` = show source language; `label` = show source with a "shown in @language" notice. Enforced in `PublicReleaseBuilder::translateForPublic()`/`fallbackMode()`.
- `track_content` (bool, default TRUE) — capture node/content entity changes.
- `track_unpublished_content` (bool, default FALSE) — include unpublished content in capture.
- `auto_track_new_safe_content` (bool, default TRUE in install config) — opt-in automatic tracking of newly discovered privacy-safe content types/bundles.
- `track_modules` (bool) — capture module/theme install/uninstall.
- `track_users` (bool, default FALSE) — capture user account/role changes.
- `content_capture.entity_types` (sequence) — per-entity-type policy: `{enabled, default_bundle_enabled, bundles: {bundle: bool}}`. Privacy-first: unconfigured bundles follow `default_bundle_enabled`. Enforced by `EventSource\ContentCapturePolicy`.
- `event_retention_days` (int, default 90; `0` = keep forever) — cron purge window for `changelogify_event` entities.
- `provenance_retention_days` (int, default 0) — independent purge window for minimal release provenance.
- `config_import.include_sensitive` (bool, default FALSE) — include sensitive config names in config-import events.
- `config_import.excluded_patterns` (sequence of string) — config-name patterns excluded from capture.
- `event_sources` (sequence) — per-source `{enabled}` toggles.

Also schema-defined: `block.settings.changelogify_latest_release` and `block.settings.changelogify_recent_releases` (item_count, show_date, show_version, sections sequence, show_changelog_link) for the two release blocks.

## Install/enable
`ddev drush en changelogify -y`. Update hooks in `changelogify.install` backfill new settings on upgrade (`_update_12001`..`_17002`), always preserving existing values. Cron (`Hook\ChangelogifyHooks::cron`) runs scheduled publication and purges expired events/provenance per the retention keys.
