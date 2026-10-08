<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scoring model & FitReportCollector

## FitWeight severity enum (`src/Enum/FitWeight.php`)

Backed int enum. The `value` orders severities; `getPenalty()` returns the points a finding deducts (or,
for `Ok`, adds back). NOTE: the enum's `value` and its penalty are *different* numbers.

| Case | value | getPenalty() | Meaning |
|---|---|---|---|
| `Critical` | -10 | 25 (deduct) | Immediate action |
| `High` | -5 | 15 | Significant |
| `Medium` | -2 | 8 | Moderate |
| `Low` | -1 | 3 | Minor |
| `Ok` | 2 | -2 (i.e. +2 bonus) | Passed |
| `Info` | 0 | 0 | No score impact |

Helpers: `getLabel()`, `getCssClass()`, `isIssue()` (false for `Ok`/`Info`). Severity ordering in the UI
uses the `value` (Critical first).

## Score value objects

- `Score` (`src/Score.php`): `{score, percentage}` ints; `toArray()`.
- `GroupScore` (`src/GroupScore.php`): `{group, score, percentage, externalProvider}`.
- `GroupScoreCollection` (`src/GroupScoreCollection.php`): iterable list of `GroupScore`.
- `FitScoreResult` (`src/FitScoreResult.php`): `{groups: GroupScoreCollection, overall: Score}`.

## FitScoreCalculator (`src/FitScoreCalculator.php`)

`MAX_SCORE = 100`, `MIN_SCORE = 0`. Built via `FitScoreCalculator::create($collection, $groupWeights,
$groupScoreWeights, $externalProviders, $externalScores)`. `calculateScores()` returns a `FitScoreResult`:

1. **Per group**: start at 100, subtract `weight()->getPenalty()` for every result in the group, clamp to
   0–100 (`calculateGroupScore()`). Because `Ok` has a **negative** penalty (-2), passing checks add a
   small bonus (capped at 100). If the group id is present in `$externalScores`, that external value is
   used verbatim instead of computing from checks.
2. **Overall**: if no `groupScoreWeights`, a simple average of group scores; otherwise a weighted average
   using each group's `scoreWeight` (default 10 when unset).
3. **Empty results**: `getDefaultScores()` returns every configured group at 100 and overall 100.

## FitReportCollector (`src/Service/FitReportCollector.php`, service `drupalfit.report_collector`)

Implements `FitReportCollectorInterface`. Constructor args: `FitCheckPluginManager`,
`FitCheckGroupPluginManager`, `DrupalFitApiClient`.

- `getCheckDefinitions()` — cached `getDefinitions()` of all `fit_check` plugins.
- `executeCheck($plugin_id): ?FitResult` — instantiates one check and runs `execute()`; catches any
  `\Exception` and returns `NULL` (isolation).
- `generate(): FitResultCollection` — runs every check and collects non-null results.
- `calculateScore(FitResultCollection): FitScoreCalculator` — reads each group's `weight`, `scoreWeight`,
  `externalProvider` from the group definitions, fetches external scores (below), and builds the
  calculator. Call `->calculateScores()` on the return to get the `FitScoreResult`.

### External scores

`calculateScore()` calls `DrupalFitApiClient::getAuditScores()`. When the cloud API returns data, only
groups whose `externalProvider` is TRUE (`seo`, `accessibility`) receive an external score; those become
entries in `$externalScores` and override the on-site computation for that group. Without an API key (or
on any error) the external scores are `[]` and those groups score from their on-site placeholder checks.

## FitResultGrouper (`src/FitResultGrouper.php`)

Static helpers used to shape data for display:
- `groupBySeverity($collection, $groupWeights)` — nests results as `[$group][$severityName][] = item…`,
  sorts groups by display `weight` and severities by `FitWeight::value`.
- `prepareGroupScores($groupScoreCollection, $groupWeights)` — per-group `{score, max_score,
  external_provider, external_url, weight}`; `external_url` points at the DrupalFit iframe tab route when
  the group is external.

## Where scoring runs

Interactively, scoring happens in the batch (`Batch\FitReportBatch::finish`) that persists a
`fit_report_history` entity; the JSON API (`Controller\DrupalFitResourceApi`) computes it on the fly.
Both go through `FitReportCollector`. See [routes.md](routes.md).
