# RESTful Logger — manual setup guide

**RESTful Logger** (`restfullogger`) provides a REST endpoint that lets a permitted
client POST a log message straight into Drupal's core logger (watchdog / dblog). It
is handy for centralising logs: a decoupled front end, a mobile app or another
integration can push its own log entries into Drupal's log so everything is in one
place. A client sends a JSON body to `/dblog/logger` with a message and optional
severity, channel and path:

```json
{
  "message": "The message you want to log.",
  "severity": "Error",
  "channel": "module_machine_name",
  "path": "/path/to/page"
}
```

Only `message` and `path` are required. If you omit `channel` it defaults to
`restfullogger`, and if you omit `severity` it defaults to `Notice`. The severity
values follow Drupal's standard Logging API levels.

The endpoint's access is correctly gated: the POST handler checks the **post log
messages** permission (and the resource itself requires the standard "Access POST on
the Watchdog database logger resource" REST permission) before writing anything. Keep
those permissions **restricted to trusted integrations** — a client that can post
logs could otherwise flood the log or inject misleading entries (log spam /
injection), so grant them narrowly and consider rate-limiting the caller. As always,
make sure clients do not push sensitive data into log messages. The module has no
other access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   then turn on the REST resource and grant the two permissions narrowly.

There is **no dedicated settings form** for this module. Its configuration — enabling
the `/dblog/logger` REST resource and granting the two permissions — is done through
core's REST configuration (most easily with the REST UI module) and the permissions
page, and is covered in the installation guide.

## Where it lives in the admin menu

RESTful Logger adds no admin page of its own. You enable and configure its REST
resource at **Configuration → Web services → REST** (`/admin/config/services/rest`,
provided by the REST UI module), grant the permissions at **People → Permissions**,
and the messages it writes appear in the standard log at **Reports → Recent log
messages** (`/admin/reports/dblog`).
