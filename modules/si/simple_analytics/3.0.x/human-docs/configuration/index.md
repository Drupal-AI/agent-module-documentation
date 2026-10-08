# Configuration

All of Simple Analytics' settings live on one page. You decide which tracking
mode(s) to use, supply any third-party IDs, control who and what gets tracked, and
tune the archiving.

## Open the settings form

1. Log in as an administrator (the settings page is behind the restricted *Simple
   Analytics admin* permission — only administrators can reach it).
2. Go to **Configuration → System → Simple Analytics settings**, or navigate directly
   to `/admin/config/system/analyse`.

## Choose your tracking mode(s)

You can use the internal tracker, a third-party snippet, or both:

- **Internal tracking system** — the built-in visitor tracker, **enabled by
  default**. It records visits and page views into your own database and powers the
  admin reports, with no external service involved.
- **Google Analytics** — enter your Google Analytics ID to have the module output the
  Google tracking snippet on your pages.
- **Matomo / Piwik** — enter your Matomo (Piwik) URL and site ID to output its
  tracking snippet.
- **Custom code** — paste any other analytics script (and matching noscript) markup
  to be injected site-wide.

## Control who and what is tracked

The same page lets you scope where the tracking applies. By default:

- **Admin pages** (anything under `/admin/`) are **not** tracked.
- **Authenticated users** are **not** tracked.

You can adjust this — for example choose to display the injected code on all pages,
exclude admin pages, or serve it only to anonymous users — and you can **exclude
specific URLs** from tracking. Setting these to match your privacy expectations
matters, since the internal tracker stores visit data in your database.

## Archiving and data retention

The internal tracker keeps its tables manageable with a daily archiving step that
runs on cron: it aggregates the previous day's data and purges rows older than a
duration you configure. Set that retention period on the settings page to balance how
much history you want against database size — and to keep only as much visitor data
as you actually need.

## Permissions and reports

Simple Analytics provides its own permissions, which you grant at **People →
Permissions**:

- **View** permissions control who can see the statistics reports at **Reports →
  Simple Analytics** (`/admin/reports/simple_analytics`) — the today, live counter,
  per-visitor detail, and history views. You can extend a view permission to
  **anonymous users** if you want, for example, a public live-visitor counter.
- The **admin** permission (restricted) controls access to this settings page.

Grant the view permissions deliberately, since visitor detail can include
information you may not want exposed publicly.

## A note on the tracking endpoint

The internal tracker works by having the browser post visit data to an open endpoint
(`/simple_analytics/api/track`), which is how client-side analytics generally
operate. Because that endpoint accepts data from anyone with no throttling, treat the
resulting numbers as indicative traffic analytics rather than a tamper-proof record.
The reports themselves render stored values through Drupal's auto-escaping table
theming, so the data is displayed safely.

## Save

Click **Save configuration**. Load a front-end page as an anonymous visitor and then
check **Reports → Simple Analytics** to confirm the visit was recorded (and, if you
added a third-party ID, that its snippet appears in the page source).
