# Configuration

JSerror is designed to be left switched on in production, and its settings exist
to keep it from ever becoming a burden — controlling how much it logs, how fast,
and how big the log is allowed to grow.

## Open the settings form

1. Log in as a user with the **Administer JSerror** permission.
2. Go to **Configuration → Development → JSerror**.

## Settings

- **Sampling — log a percentage of visitors.** Rather than logging every visitor,
  you can log a share of them. The decision is made once per visitor and
  remembered, so a reduced sample still shows you whole sessions instead of
  scattered, disconnected pages.
- **Cap reports per page view.** Limits how many reports a single page view may
  send, so a page stuck in an error loop can't flood the log.
- **Cap reports per client per hour.** Limits how many reports the site will
  accept from one client each hour. This cap is counted in *stored* reports, not
  raw requests.
- **Trim the log on cron.** Keeps the log to a fixed number of rows, pruned when
  cron runs, so it can't grow without bound.
- **Keep errors out of the browser console.** Optionally suppress the captured
  errors from appearing in the visitor's own JavaScript console.

## How the collection endpoint stays safe

The endpoint that receives reports accepts anonymous requests on purpose — the
errors worth knowing about are the ones happening to ordinary visitors, most of
whom aren't logged in. It only accepts same‑origin JSON, so another site can't
make its visitors write into your log; it applies a size limit to every field
before storing anything; and its rate limit counts stored reports rather than
requests. You don't configure these — they're built in — but they're worth
knowing when you decide how open to leave the sampling and caps.

## Reading the reports

Reports live at **Reports → Recent JavaScript errors** (requires **View site
reports**). Distinct errors are grouped by message, most frequent first. Open an
entry to see individual occurrences with their pages, browsers, platforms, and
stack traces. Filtering by browser or platform happens in the URL, so a filtered
report is a link you can paste straight into an issue.

## Save

Click **Save configuration** to apply your settings.
