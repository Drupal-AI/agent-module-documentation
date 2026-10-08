# Configuration

Content Insights Report has a settings form for shaping the report, and a separate
page where you read the results.

## Open the settings form

1. Log in as an administrator (or a user with the right to administer the module's
   settings).
2. Go to **Configuration → Content authoring → Content Insights Report Settings**,
   or navigate directly to
   `/admin/config/content/content_insights_report/settings`.

## What you can configure

- **Reporting period (months)** — the monthly created/updated trends are broken
  down month by month, and you choose how many months to include (for example the
  last 6 months or the last year). Set this to match the window you actually care
  about.
- **Percentage basis** — the summary and status breakdowns are expressed as
  percentages, calculated either against the **total number of nodes** or against
  the **total number of published nodes**. Pick whichever gives you the more
  meaningful comparison for your site.

Save the form to apply your choices.

## Group settings (if the Group submodule is enabled)

If you enabled `content_insights_report_group`, a second settings page appears at
**Configuration → Content authoring → Content Insights Report Group Settings**
(`/admin/config/content/content_insights_report_group/settings`) for the
group‑scoped report. Configure it the same way, then generate reports for an
individual group from the Groups area.

## Read the report

Go to **Reports → Content Insights Report**
(`/admin/reports/content-insights-report`). The report brings together:

- **Content Insights Summary** — a percentage breakdown of content by type, so you
  can see your content mix at a glance.
- **Content Insights Report** — the deeper view: percentage breakdown by status,
  monthly trends of created and updated nodes across your configured period, and a
  breakdown by **moderation state** (draft, pending approval, published, and other
  workflow stages) that highlights content stuck in a stage.
- **Content Report** — a granular view with **customisable date filters** so you
  can narrow the results to a specific window.

## Two things to keep in mind

- **Cost:** generating the report analyses all your content, which is expensive on
  large sites. Confirm whether it runs as a batch/cron job before triggering it on
  production.
- **Access:** the report aggregates content that the reader may not otherwise be
  able to view, so treat "who can see the report" as an access decision and grant
  it only to trusted roles.
