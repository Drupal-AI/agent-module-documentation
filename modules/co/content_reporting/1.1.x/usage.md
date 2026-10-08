Content Reporting records node page views, clicks, time-spent and GDPR consent through a lightweight client-side tracker and reports the aggregates on an admin dashboard.

---

Content Reporting is a self-contained engagement-analytics module for Drupal 9/10/11. A JavaScript behaviour attached to every node page sends a "view" event — and, when enabled, "click" and "time_spent" interaction events plus a GDPR-consent flag read from the EU Cookie Compliance module — to two POST endpoints. Events are buffered onto Drupal core queues and written to the `content_reporting_reports` and `content_reporting_interactions` tables by queue workers on cron, so page requests stay fast even behind a CDN. Administrators view the results at `/admin/content-reporting/dashboard`: a paged, filterable table of per-node views, per-element click counts, formatted time spent and GDPR-consent totals, with a CSV export. A settings form toggles four tracking modes (GDPR, clicks, time-spent, logged-in users), and `hook_cron` deletes report rows older than 30 days. The optional `content_reporting_charts` submodule adds a second dashboard that renders the same data as column, bar and pie charts using the contrib Charts module.

---

- Install the module and grant a trusted role the "View Tracked content" permission to reach the reporting dashboard.
- Track how many times each node is viewed, aggregated per node and shown in a sortable table.
- Enable click tracking to record which on-page elements (links, buttons, `.track-click` elements) visitors interact with, with per-element counts.
- Enable time-spent tracking to measure how long visitors stay on each node page, reported as `H:i:s`.
- Enable GDPR-consent tracking to count how many visitors had accepted cookies (via EU Cookie Compliance) when they viewed a page.
- Distinguish anonymous from authenticated engagement by enabling logged-in-user tracking.
- Filter the dashboard by page title, start date and end date to scope a report to a campaign window.
- Filter nodes by GDPR-consent ratio band (0%, 0-25%, 25-50%, 50-70%, 70-100%) to find low-consent content.
- Export the current filtered report to a CSV file (ID, Title, Views, GDPR Consent) for offline analysis or archiving.
- Keep tracking working behind aggressive page caches / CDNs (e.g. CloudFront), since events are sent from the browser after the page loads.
- Avoid slowing pages under load by deferring all database writes to queue workers processed on cron.
- Process the queues on demand with `drush queue-run content_reporting_track_queue` and `drush queue-run content_reporting_interactions_queue`.
- Automatically purge report rows older than 30 days on cron to keep the tables bounded.
- Add the `content_reporting_charts` submodule to visualise views-per-page as a column chart.
- Visualise average time-spent split between anonymous and authenticated visitors as a bar chart.
- Visualise average time-spent per page as a pie chart across all tracked nodes.
- Provide a role a dedicated "Admin Content Reporting" permission to change the tracking settings without full site-admin rights.
- Build a content-engagement dashboard for editors under Reports without adding a third-party analytics service.
- Identify your most- and least-viewed content to inform an editorial or content-retirement decision.
- Compare engagement across content types by reading per-node view and time-spent figures.
- Report GDPR-consent uptake per page to support a privacy/compliance review.
- Run the module on a site that must keep all analytics data first-party and inside its own database.
