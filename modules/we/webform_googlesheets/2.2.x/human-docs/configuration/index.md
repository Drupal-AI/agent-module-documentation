# Configuration

All configuration happens on a webform, not on a site-wide page. You add the **Google
Sheets** handler to whichever forms should write to a spreadsheet, and each handler
has its own settings stored on that webform.

## Add the handler

1. Make sure you've completed the Google Cloud prerequisites and created a credential
   in the **Google API Client** module (see [Installation](../installation/index.md)).
2. Go to **Structure → Webforms → *(your form)* → Settings → Emails / Handlers**
   (`/admin/structure/webform/manage/<webform>/handlers`).
3. Click **Add handler**, choose **Google Sheets**, and configure the settings below.

The handler form shows an **issues checklist** if the chosen credential is missing the
Sheets service, the scope, or authentication — fix those first or delivery will fail.

You can add more than one Google Sheets handler to a single form (unlimited
cardinality) to write submissions into several sheets at once.

## The spreadsheet

- **Google Sheet URL** *(required)* — paste the full sheet URL. It must look like
  `https://docs.google.com/spreadsheets/d/<id>/edit#gid=0`. The module parses out the
  spreadsheet ID and the specific tab (the `gid`), so include the `#gid=` fragment for
  the tab you want. An invalid URL is rejected with "Please provide a valid Google
  Sheet URL."

## Credentials

- **Credential type** — choose **OAuth 2.0 client** (`google_api_client`) or **Service
  account** (`google_api_service_client`).
- Depending on that choice, select the specific **OAuth client** entity or **service
  account** entity to authenticate with.

## Column layout and data shaping

- **Included / excluded columns** — a selector to choose exactly which submission
  columns get exported.
- **Sort metadata first** — put submission metadata columns (sid, created, completed,
  changed) *before* the submitted field values instead of after.
- **Convert dates** *(on by default)* — reformat the `created` / `completed` /
  `changed` timestamps into a date format instead of raw Unix time.
  - **Date format** — pick a site date format, or **custom**.
  - **Custom date format** — a PHP date string, used only when the format is *custom*.
- **Multi-value limit** — the maximum number of values exported per multi-value field
  (0–1000).
- **Pad empty multi-value slots** — keep columns aligned across submissions by padding
  empty slots.
- **Comma-separate** — instead of spreading a multi-value answer across columns, join
  it into a single comma-separated column.

How different values are written: composite fields (like address or name) are expanded
into per-subfield columns; multi-value fields become numbered columns (or one joined
column when *comma-separate* is on); rich-text fields export their HTML value; and
uploaded files are written as the file URI. The sheet is automatically widened with
extra columns if a submission has more columns than the sheet currently has.

## Delivery: immediate or queued

- **Use queue** — off by default, meaning each new submission is written to the sheet
  **immediately**. Turn it on to enqueue submissions for delivery during cron instead,
  which keeps form submission fast and shrugs off Google API latency.
- **Queue max attempts** — how many times a queued delivery is retried before giving
  up (0 = unlimited). Retries wait ~5 minutes between attempts.

A few things worth knowing about delivery:

- Rows are written **only for new submissions**. Edits made to a submission after it's
  been delivered are **not** re-sent.
- Delivery is **at-least-once**: if an append is accepted by Google but the response
  times out, a retry can create a **duplicate row**.
- Both success and failure are logged to the **webform_submission** log channel, so
  check **Reports → Recent log messages** when troubleshooting.

## Reacting to deliveries in code

For developers: each delivery dispatches an event — `WebformGoogleSheetsSuccessEvent`
(carries the submission and the Sheets API response) and `WebformGoogleSheetsErrorEvent`
(carries the submission and the error message). Subscribe to these from a custom module
to trigger alerting or follow-up logic. See the [`agent/`](../agent/start.md) docs for
the event names and a subscriber example.
