# Configuration

Logger DB stores logs as soon as it is enabled. The configuration work is about
two things: keeping the store from growing without bound, and building the
report pages that make the logs useful to read.

## Open the settings form

1. Log in as an administrator (a user with permission to administer the site).
2. Go to the Logger DB settings page in the admin **Configuration** area (config
   route `logger_db.settings`).

## Retention and cleanup

Because every entry lands in the database, decide up front how much to keep:

- **Clean up by age** — automatically remove entries older than a chosen period.
- **Clean up by count** — cap the total number of stored entries, discarding the
  oldest beyond the limit.

Setting a retention policy is the most important step for a production site; an
unbounded log table will grow indefinitely.

## Log‑report pages

Logger DB's reporting is built on Views, so you can create one or several report
pages, each tailored to a purpose:

- **Choose the columns** each page shows, so you see only the fields relevant to
  that report.
- **Format each value** appropriately — plain text or numbers for scalar values,
  and **JSON** or **YAML** for complex, nested values.
- **Filter and sort** by date/time range and by any custom field value, including
  **nested fields addressed with JSONPath** (for example
  `$.metadata.ai.token_usage.total`). This is what makes it practical to zero in
  on, say, all entries for one request or one user action.

Because these pages are Views, you can also use Logger DB's Views **field** and
**filter** plugins to build entirely custom log views from scratch.

## Export and import

For moving logs between environments or archiving them, Logger DB can **export**
entries to a file and **import** them back, **merging and deduplicating** so you
don't create duplicate records.

## Save

Save the settings form after adjusting retention. Report‑page changes are saved as
part of the View you edit.

## Keep the log store safe

Restrict the report pages to trusted administrators, set a retention policy, and
avoid logging secrets or personal data — a database log store can otherwise both
grow large and expose sensitive detail.
