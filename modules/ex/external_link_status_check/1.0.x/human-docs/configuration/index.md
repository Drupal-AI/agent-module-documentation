# Configuration

External Link Status Check has two halves: a **link scanner** page where you can
trigger a full scan on demand, and a **report** where the results show up. This
page walks through both. There are no configurable scan options — behavior such as
which content types are scanned and the request timeout is fixed by the module.

## Run a manual scan

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → System → External Link Scan**, or navigate directly to
   `/admin/config/system/external-link-scan`.
3. Click **Start Full Scan**. The module walks all supported content in a batch and
   updates the report as it goes.

You do not have to scan manually to get results: the module also scans content
automatically when an entity is created or updated and during cron runs. Use the
manual scan when you want to refresh everything immediately.

## How scanning and checking work

You do not check links by hand. When content changes, the module detects the
external links it contains and stores them in a tracking table. It then schedules
the actual status checks through Drupal's **Queue API**, and those queued checks
are processed on cron. This asynchronous design is deliberate: it keeps page
loads fast because the potentially slow business of contacting external servers
never happens during a visitor's request.

Because checks run on cron, make sure cron runs regularly on your site (Drupal's
built-in cron, a system cron job, or `drush cron`). If cron never runs, links get
tracked but their status is never refreshed.

## Read the report

Go to **Reports → External Links** (`/admin/reports/external-links`). The report
lists the external links the module has found across your content along with their
checked status, so you can spot the broken ones at a glance. Broken links are what
you are hunting for here — follow them back to the content that contains them and
fix or replace the URL.

The report also offers an **export**, so you can pull the results out of Drupal
for a spreadsheet, an SEO audit, or a compliance record.

## A note on outbound requests

Every scan makes your server fetch the external URLs it finds. That is normal and
expected for a link checker, but keep two things in mind: run scans against
content you trust (so the module isn't fetching URLs an untrusted author planted),
and remember that a large site with many links will generate a corresponding
volume of outbound traffic as the queue is processed.
