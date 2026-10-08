# Configuration

Request Logger works the moment it's enabled, but its settings form lets you
choose **exactly which request and response items are captured**, how they appear
in the log message, and whether the request UUID is stamped onto other log
entries.

## Open the settings form

Log in as a user with the **Administer site configuration** permission and go to
**Configuration → Development → Request Logger**
(`/admin/config/development/request_logger`).

## Settings, field by field

- **Log level** — the RFC 5424 severity used for the request-logger entries.
  Default is **6 (Info)**. Lower this if you want the entries to stand out as more
  severe, or keep it at Info for routine logging.
- **Request data** — which items about the incoming request to store in the log
  metadata. Options are **uuid**, **method**, **path**, **query**, and
  **headers**. The default captures **uuid, method, path, and query** — headers
  are **off** by default (see the privacy warning below).
- **Response data** — which items about the response to store. Options are
  **code**, **size**, **duration**, **memory_usage**, **memory_usage_peak**,
  **page_cache**, and **headers**. The default captures **everything except
  headers**.
- **Add data to message** (`message_add_data`) plus **message request data** /
  **message response data** — control which of the captured items are also inlined
  into the human-readable log message string (the one you see at a glance in the
  log list), as opposed to only living in the structured metadata.
- **Add request UUID to logs** (`add_request_uuid_to_logs`) — when enabled, the
  module's event subscriber stamps `request_uuid` and `main_request_uuid` onto
  *all* log entries generated during a request, so you can correlate every log
  line back to the request (and sub-requests to their main request) that produced
  it.

Save the form to apply your selection.

## Where the data goes

Entries are sent to the **`request_logger` logger channel**. Storage, rotation,
and read-access are determined by whichever logger backends you have enabled:

- **Database Logging (dblog)** → the `watchdog` table, viewable at **Reports →
  Recent log messages** (`/admin/reports/dblog`) with the **Access site reports**
  permission.
- **Syslog** → the operating system's syslog/file.

For structured, filterable logs (sorting requests by duration or memory, building
metrics and charts), pair it with the contributed **Logger**/**Logger DB**
modules, and enable the **Request Logger Reports** submodule for ready-made report
tabs.

## Privacy warning

There is **no redaction**. Before enabling the **Headers** items, understand what
they record:

- The **request Headers** item logs every request header verbatim, including
  `Authorization` and `Cookie` — that means session cookies, bearer tokens, and
  basic-auth credentials written into the log store.
- The **response Headers** item includes `Set-Cookie`.
- The **query** item is **on by default** and can capture secrets passed in query
  strings (password-reset tokens, API keys).

Do not enable header logging on production unless you accept those values being
stored, and restrict the log-read permissions (**Access site reports**, and any
backend-specific access) accordingly.
