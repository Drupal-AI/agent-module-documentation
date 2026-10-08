<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ReviewedDateManager service API

Service id **`content_reviewed_date.manager`**, class
`Drupal\content_reviewed_date\ReviewedDateManager` (`final`). Sole dependency: `@config.factory`.
Deliberately has no entity-manager dependency so it stays fast and unit-testable (the stale query
lives in `StaleContentController`, not here). Covered by
`tests/src/Unit/ReviewedDateManagerTest.php`.

## Methods

- `isEnabled(string $bundle): bool` — TRUE if `$bundle` is in the configured `bundles` list.
- `getEnabledBundles(): string[]` — the `bundles` config value (empty array when null/unset).
- `getThresholdDays(): int` — global `threshold_days`; accepts int or numeric string ≥ 1, else
  falls back to **365**.
- `getThresholdDaysForBundle(string $bundle): int` — returns the `threshold_days_per_bundle`
  override for the bundle when it is an int/numeric-string ≥ 1, otherwise falls back to
  `getThresholdDays()`.
- `isStale(NodeInterface $node): bool` — FALSE for untracked bundles. TRUE when the review date is
  empty (never reviewed) or unparseable. Otherwise parses the stored `Y-m-d` in UTC and returns
  TRUE when it is before `now − thresholdDays` (both truncated to midnight). Uses the bundle's
  effective threshold.
- `markAsReviewed(NodeInterface $node, int $reviewer_uid, string $date): void` — sets
  `content_reviewed_date` and `content_reviewed_uid` on the node **without saving** (caller must
  `save()`). Validates `$date` strictly as `Y-m-d` with a round-trip check (rejects overflow dates
  like `2025-02-30`), throwing `\InvalidArgumentException` on a bad format.

## Notes

- All getters read `content_reviewed_date.settings` fresh from the config factory on each call.
- `markAsReviewed()` only mutates the entity in memory; the presave hook and the Mark as Reviewed
  form are the two callers that persist it.
