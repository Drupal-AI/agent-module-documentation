Surfaces PostHog web analytics (pageviews, visitors, sessions, bounce rate, and optional conversions) directly on each content entity's Analyze tab and in a sitewide admin report.

---

Analyze PostHog is a provider plugin for the Analyze module that pulls live data from a PostHog project via its HogQL query API. It defines a single `posthog_analytics` Analyze plugin that renders a per-entity KPI summary and a full report (referrer/country/device/browser breakdowns) for any entity that resolves to a URL path, plus a sitewide report at `/admin/reports/posthog`. Every metric is shown with a comparison against the immediately preceding period. The PostHog personal API key is stored through the Key module; the host, project ID, default date range, cache TTL, and conversion goals live in the `analyze_posthog.settings` config object. Results are cached (default 6 hours) under the `analyze_posthog` cache tag. A set of Drush commands mirrors the UI for scripting and CI.

---

- See a page's pageviews, unique visitors, sessions, bounce rate, and average time on page on its Analyze tab without leaving Drupal.
- Show each metric with its percentage change vs the previous equal-length period (e.g. "397 pageviews (+12.3%)").
- Break down a page's traffic by referring domain to see which sites and campaigns drive visits.
- Break down traffic by visitor country (GeoIP) for geographic targeting decisions.
- Break down traffic by device type (desktop / mobile / tablet).
- Break down traffic by browser (Chrome, Firefox, Safari, etc.).
- View a sitewide KPI dashboard and dimension tables at `/admin/reports/posthog`.
- Rank the top pages sitewide by pageviews using the "Pages" dimension.
- Filter any report to a single country via the exposed country dropdown.
- Filter dimension rows by trend status: up, down, new, or lost vs the previous period.
- Text-search dimension keys (referrers, countries, pages) to narrow a large table.
- Page through long dimension tables (20 rows per page) with a standard pager.
- Choose the reporting window: 7, 14, 28, 90, 180, or 365 days.
- Deep-link from a page to PostHog session replay, pre-filtered to that page's pathname, to watch real users.
- Open the current view directly in the PostHog web UI via "Open in PostHog" buttons.
- Define conversion goals that map PostHog custom events (e.g. `user_registered`, `purchase`) to business outcomes.
- Attach a fixed monetary value or read a value from an event property to compute conversion revenue per goal.
- See which pages drive the most conversions and revenue in the sitewide "Conversions" dimension.
- See per-goal conversion counts and value scoped to a single page on its entity report.
- Pick conversion-goal events from a live dropdown of the project's most frequent custom events (last 30 days).
- Query analytics for any path from the CLI: `drush analyze:posthog:query /pricing --days=90 --dimension=country`.
- Run the sitewide report from the CLI: `drush analyze:posthog:report --dimension=page --country="United States"`.
- Check API connectivity and current configuration with `drush analyze:posthog:status`.
- List configured conversion goals with live 30-day event counts via `drush analyze:posthog:goals`.
- Clear all cached PostHog data with `drush analyze:posthog:cache-clear` (or after changing credentials).
- Store the PostHog personal API key securely via a Key entity (env, file, or config provider) rather than plain config.
- Gate analytics visibility with the `access posthog analytics` permission, separate from the `administer analyze settings` config permission.
