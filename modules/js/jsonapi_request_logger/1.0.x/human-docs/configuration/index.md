# Configuration

The module's settings let you switch request logging on or off and control
exactly what gets written to the log. This is where the security decisions live,
so read the trade-offs below before you turn on the header and body tokens.

## Open the settings form

Log in as a user with the **Administer site configuration** permission (an
administrator by default) and open the module's settings form. Once there you can
enable or disable logging and edit the log-format string.

## Enable or disable logging

Logging is controlled by a simple on/off switch. Leave it **off** until you
actually need to inspect traffic, and turn it **off** again when you are done —
especially on production. When it is off, no request data is captured at all.

## The log format and its tokens

You describe what each log entry should contain by writing a format string built
from replacement tokens. The module substitutes each token with the matching part
of the request:

- **`{method}`** — the HTTP method (GET, POST, PATCH, DELETE, …).
- **`{url}`** — the requested URL.
- **`{status_code}`** — the HTTP status code of the response.
- **`{query}`** — the query-string parameters.
- **`{headers}`** — the request headers.
- **`{content}`** — the request body.

A safe starting format logs only the non-sensitive parts, for example the method,
URL, and status code together, which is usually enough to see who called what and
whether it succeeded.

## Security: be careful with `{headers}` and `{content}`

Two tokens capture sensitive data and deserve a deliberate decision:

- **`{headers}`** includes the **`Authorization` header** — bearer tokens and
  HTTP basic-auth credentials — and **cookies**, which carry session
  identifiers. Logging it writes credentials and session tokens into dblog.
- **`{content}`** includes the **request body**, which for a write request may
  contain personal or otherwise sensitive data.

Anything logged is readable by any user with the **access site reports**
permission and may be retained in the database or forwarded to a log aggregator.
So:

- Avoid `{headers}` and `{content}` unless you have consciously accepted that
  consequence for a specific debugging session.
- If you must log headers, redact the sensitive ones.
- Restrict who holds *access site reports*.
- Prefer running this in development, not on a live site, and disable it again
  afterwards.

## Save

Save the form to apply your changes. New requests are then logged according to the
format you set; review them under **Reports → Recent log messages**
(`/admin/reports/dblog`).
