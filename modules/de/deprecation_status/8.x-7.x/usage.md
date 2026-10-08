Deprecation Status renders the Drupal Association's Project Analysis report — deprecated-API and major-version readiness data for contributed drupal.org projects — as interactive summary, project, error and chart pages.

---

The module ships two datasets of CSV files (one for Drupal 11, one for Drupal 12) produced by the Drupal Association's regular Project Analysis pipeline, and exposes them through a set of read-only report pages under `/drupal11/deprecation_status` and `/drupal12/deprecation_status`: an overview summary with next-step buckets, a filterable/sortable projects table, a filterable/sortable errors table, per-project and per-error detail pages, and a page of historical trend charts (Chart.js). Report pages read the CSVs directly on each request and are gated by the `access content` permission; they display only the public ecosystem data that already lives in the report. An admin-only Update page (permission `administer deprecation status data`) can download the newest CSVs from the module's own `git.drupalcode.org` repository into private files, or reset back to the shipped copies. Two REST resource plugins (`/api/deprecation-versions` and `/api/deprecation-status/{target_version}`) return the raw CSV data as JSON for programmatic consumers. The project is meant as an ecosystem-wide contribution/analysis dashboard for developers and contribution events, not as a scanner for your own site — use Upgrade Status for that.

---

- Browse the Drupal 11 ecosystem deprecation summary at `/drupal11/deprecation_status`.
- Browse the Drupal 12 ecosystem deprecation summary at `/drupal12/deprecation_status`.
- See how many contributed projects fall into each "next step" bucket (stable, improve stability, make a release, fix errors, resolve pre-scanning errors, abandoned).
- Read the per-bucket guidance text explaining what maintainers should do next for each status.
- View a stacked bar chart of all analyzed projects broken down by next step.
- Filter the projects table by machine name with wildcards (e.g. `commerce*`).
- Filter projects by their general or specific next step.
- Filter projects by maintainer name (e.g. find everything a given contributor maintains).
- Filter projects by type (module, theme, theme engine, distribution).
- Filter projects to only the top 50/100/200/500/1000 by usage.
- Sort the projects table by name, status, usage, top-X group or total errors.
- Open a single project's detail page to see its status, recommended next step and per-project error list.
- Jump from any project to its drupal.org "Drupal N compatibility" issue search.
- Browse the errors table to see each distinct deprecation message, how often it occurs and how many projects it affects.
- Filter errors by message text (wildcards), by affected project name, by category, or by top-X usage group.
- See errors categorized as info.yml/composer.json, Drupal API (rector-covered or not), Symfony, Twig, PHPUnit, Guzzle, frontend, other, or parse errors.
- Open a single error's detail page to list every affected project and its occurrence count.
- View historical trend charts: projects by next step over time, error counts over time, and error fixability over time (top-200 and all-projects variants).
- Identify how many errors are automatically fixable with drupal-rector to prioritize cleanup work.
- Run a contribution event where participants pick projects to port and track collective progress.
- Refresh the displayed data to the latest published dataset via the admin Update page, or reset it to the shipped copies.
- Consume the raw deprecation dataset as JSON from other tools via the `/api/deprecation-status/{target_version}` REST endpoint.
- Discover which target versions and data files are available via the `/api/deprecation-versions` REST endpoint.
