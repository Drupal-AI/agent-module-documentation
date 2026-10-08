ECA: Google Sheets adds seven ECA action plugins for reading, writing, querying and managing Google Sheets from Drupal no-code workflows.

---

ECA: Google Sheets is the first service submodule of the ECA: Google suite. It provides seven ECA action plugins (in `src/Plugin/Action/`) that call the Google Sheets API on behalf of an ECA model: Append to Sheet, Read from Sheet, Query Sheet, Update Sheet, Create Sheet, Clear Sheet and Delete Sheet. All actions authenticate through the parent module's `eca_google.google_api` service, choosing an OAuth2 API client or a Service Account via the shared "Google API Client" selector; spreadsheet IDs, ranges and payloads support ECA token replacement. Read and Query load spreadsheet rows into ECA tokens using a `[token:Row1:Col1]` (or header-keyed `[token:Row1:Name]`) syntax, and Query can return the original spreadsheet row number via a `_ROW` key for follow-up updates. Query runs Google's server-side QUERY function by writing a formula into a temporary hidden tab, reading the results, then deleting that tab. It requires ECA: Google (hence ECA and Google API Client) and the Sheets API enabled in the linked Google Cloud project.

---

- Append a new row to a Google Sheet when a node, user or webform submission is created.
- Log site events (orders, sign-ups, errors) as spreadsheet rows for lightweight reporting.
- Read a range of a spreadsheet into ECA tokens and branch a workflow on the values.
- Import a lookup / configuration table from Sheets and use it inside an ECA model.
- Use the first row as column headers so tokens read `[data:Row2:Email]` instead of `Col2`.
- Query a sheet server-side (`SELECT * WHERE Col1 > 100 AND Col2 = "Active"`) and process matches.
- Get the original spreadsheet row number of query matches via `_ROW` for targeted updates.
- Update an entire row from a token array captured earlier in the workflow.
- Update only specific columns of a row by number (`3:completed`) or header name (`Status:done`).
- Choose RAW or USER_ENTERED value input so formulas/formatting apply (or not) on write.
- Create a new dated or per-category tab in a spreadsheet as part of an automation.
- Store the new sheet's id/title/index in a token for later steps.
- Clear a working range while preserving cell formatting.
- Delete an entire temporary sheet (by title or numeric id) at the end of a batch process.
- Build a two-way sync: read/query Sheets data, act in Drupal, then write results back.
- Run everything under a Service Account for unattended server-to-server automation.
- Run under an OAuth2 client so operations occur as a specific Google user account.
- Move records between sheets/tabs (read, append elsewhere, clear or delete the source).
- Maintain a queue-like tab: append tasks, query pending rows, update status, clear when done.
- Drive spreadsheet targets dynamically per event using tokens in the Spreadsheet ID / range.
