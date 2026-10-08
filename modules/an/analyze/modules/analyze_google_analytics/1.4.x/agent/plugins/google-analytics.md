<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Google Analytics analyzer (`analytics`)

`src/Plugin/Analyze/GoogleAnalytics.php` — `final class GoogleAnalytics extends AnalyzePluginBase`.

## Definition

```
@Analyze(
  id = "analytics",
  label = @Translation("Google Analytics Entity Reports"),
  description = @Translation("Provides data from Google Analytics for Analyzer.")
)
```

## Dependencies injected

Base three (`analyze.helper`, `current_user`, `config.factory`) plus `path_alias.manager`
(`AliasManagerInterface`) and `entity_type.manager`.

## Data source — a View, not a direct API call

`getSummaryResults($entity, $report = 'summary')`:

1. `$url = $entity->toUrl()->toString();`
2. Load the View entity `analyze_google_analytics` (base table `google_analytics`, provided by
   `google_analytics_reports_api`).
3. `$view->setArguments([ $this->aliasManager->getAliasByPath($url) ])` — argue by the entity's
   **URL alias**.
4. `$view->execute($report)` and return `$view->result` (or `NULL`).

So all GA access, credentials and HTTP happen inside the google_analytics_reports_api module; this
plugin only reads View result rows.

## Rendering

- `renderSummary()` → `['#theme' => 'analyze_table', '#table_title' => 'Google Analytics Summary
  Last 30 Days', ...]`. Adds rows for `screenPageViews` (Page views), `screenPageViewsPerUser`
  (2 dp) and `bounceRate` (2 dp) when present; otherwise shows a "No data" row.
- `renderFullReport()` → core `['#theme' => 'table', ...]`. Iterates the first result row, skips
  keys starting `_` or `index`, humanizes the metric name (`ucwords` on camelCase split), and
  formats: `sessionsPerUser` (2 dp), `averageSessionDuration`/`userEngagementDuration` (`…s`),
  `engagementRate`/`bounceRate` (`× 100` → `%`).
- `getFullReportUrl()` returns the default report URL only when `getSummaryResults()` has data,
  else `NULL` (no full-report link on empty pages).

## Gating (three layers)

- `isApplicable($type, $bundle)` → `isGoogleAnalyticsReportsSetup()` — only offered in the settings
  form once GA Reports is ready.
- `isEnabled($entity)` → `parent::isEnabled()` **and** `isGoogleAnalyticsReportsSetup()`.
- `access($entity)` → `currentUser->hasPermission('access google analytics reports')` — a
  **google_analytics_reports permission**, enforced by both the parent access check (for the
  per-plugin report route) and `AnalyzeController` (before rendering the summary block). This is an
  additional gate on top of the parent's `view analyze reports`.

`isGoogleAnalyticsReportsSetup()` = `GoogleAnalyticsReportsApiFeed::service()` exists and
`isAuthenticated()`, and `google_analytics_reports.settings:metadata_last_time` is set.

## Extras / lifecycle

- `extraSummaryLinks()` adds "View sitewide Google Analytics report" →
  `view.google_analytics_summary.page_1`.
- `hook_install` (`analyze_google_analytics.install`) warns (with a link to the GA Reports API
  settings) if GA Reports is not yet configured/imported.
- `hook_uninstall` deletes `views.view.analyze_google_analytics`.
- `analyze_google_analytics_update_8001` sets the View's exposed submit button text to
  "Apply filters".

## Enable / operate

1. Configure and import **Google Analytics Reports** + **Google Analytics Reports API** first.
2. `drush en analyze_google_analytics`.
3. Enable "Google Analytics Entity Reports" per bundle at Configuration > Content > Content
   Analysis (perm `administer analyze`).
4. Grant `view analyze reports` **and** `access google analytics reports` to roles that should see
   GA data.
5. Open an entity's canonical page → "Analyze" tab.

## Notes

- GA values flow through `analyze_table` (summary) / core `table` (full report); both escape
  output, and the plugin numerically formats metrics — no raw-markup/XSS surface. No direct
  outbound HTTP or credential handling lives in this submodule (delegated to GA Reports API).
