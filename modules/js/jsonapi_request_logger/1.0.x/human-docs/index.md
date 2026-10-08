# JSON:API Request Logger — manual setup guide

**JSON:API Request Logger** (`jsonapi_request_logger`) records the incoming
requests that hit your site's JSON:API — capturing details such as the HTTP
method, the requested URL, the response status code, request headers, the query
string, and the request body. It listens to requests through an event subscriber
and writes what it captures into Drupal's standard event log (dblog), so you can
review API traffic directly under **Reports → Recent log messages**.

It is a developer and debugging tool. The typical use is monitoring and
troubleshooting — seeing exactly which client called which endpoint, with what
payload, and what came back — or auditing who is reaching your API. You choose
what gets logged by building a log-format string out of replacement tokens
(`{method}`, `{url}`, `{status_code}`, `{headers}`, `{query}`, `{content}`), so
you can keep the logs terse or verbose to taste.

Because it can log headers and bodies, it can also capture sensitive data. The
`{headers}` token includes the `Authorization` header (bearer tokens and
basic-auth credentials) and cookies (session identifiers); the `{content}` token
includes the request body, which may contain personal data. Anything you log is
readable by any user with the *access site reports* permission and may be
retained or shipped off to a log aggregator. Treat this as a tool you enable
deliberately while investigating something — ideally not on a production site —
and keep the sensitive tokens out of your format unless you have accepted that
trade-off. It has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn logging on or off and choose
   which tokens to log, with the security trade-offs spelled out.

## How to use it

Once enabled and configured, the module logs matching JSON:API requests to
dblog automatically. To review them, go to **Reports → Recent log messages**
(`/admin/reports/dblog`) and look at the entries the module writes. When you are
finished debugging, turn logging off again (see
[Configuration](configuration/index.md)) so you are not accumulating request
data — potentially sensitive request data — on a live site.
