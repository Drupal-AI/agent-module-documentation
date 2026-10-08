# Extended Logger — manual setup guide

**Extended Logger** (`extended_logger`) writes Drupal's log entries as
**structured records with custom metadata**, and sends them to whatever
destination suits your environment — a database, a file, syslog, or **stdout /
stderr** for a containerised deployment. Drupal's built-in dblog was designed for a
single server with a database and an admin UI; Extended Logger is built for the
places dblog is awkward: a container that wants logs on stdout for the platform to
collect, or a log-aggregation stack that wants consistent JSON fields it can index.

Beyond just moving logs around, it lets each entry carry **more context** than
message-plus-severity — a request id, user, route, deployment version, or any
metadata your own code contributes. Logs are emitted as JSON, and you choose which
fields are included (rather than being stuck with a fixed set), selecting them by
**JSONPath** expression. A bundled JSON-repair step fixes malformed JSON before
output, so one bad line won't break your aggregator's parser.

Two submodules cover the ends of the pipeline: **extended_logger_db** adds database
storage, and **extended_logger_fallback** provides a secondary destination for when
the primary one is unavailable — which matters more than it sounds, because a logger
whose destination is unreachable can fail silently, and that's worse than no
logging at all. Enable the fallback whenever your primary destination is remote.

One caution worth stating plainly: log entries carry user input, IP addresses,
usernames, and request paths. Shipping them to an aggregator is a **personal-data
flow** — give it a retention policy, and a processor agreement for any third-party
service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — choose the output target and the
   fields each log entry carries.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Development → Extended Logger**
(`/admin/config/development/extended-logger`), behind the
`administer extended_logger configuration` permission. By default the module writes
to a `drupal.log` file until you change the target.

> **Looking to the future:** the maintainer has reworked this module under a new
> name, **Logger**, with additional plugin-based features. Existing Extended Logger
> sites can keep using it, but new sites may prefer to start with Logger.
