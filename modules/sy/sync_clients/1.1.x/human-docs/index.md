# Sync Clients — manual setup guide

**Sync Clients** (`sync_clients`) is a **base module for developers** — a
framework for syncing data to and from a remote system over API connections,
built on top of [Advanced Queue](https://www.drupal.org/project/advancedqueue).
Rather than being a ready-to-use feature, it gives you a robust structure for
handling API requests with built-in error handling, retry and a pause mechanism,
so that a flaky or failing remote does not bring your whole import/export to a
halt.

The design pairs three pieces: a **Sync Client plugin** that defines and handles
an API connection; a corresponding Advanced Queue **JobType plugin** that does
the actual work using that client; and a **dedicated queue** tuned to the API's
load and timing. The Sync Client plugin's annotation names its JobType and queue,
and the plugin manager ties them together. Because each data entity is processed
as its own queue job, one failure does not block the rest — and failed jobs are
easy to debug and retry. The base also ships a **mail handler** that sends
notice, warning and error emails (recipients can be set globally or per Sync
Client plugin), and a **pause mechanism** that can temporarily halt a queue on
things like connection timeouts or an authentication failure (based on the HTTP
response code).

This is developer/integration scaffolding, so it does **not** do anything useful
on its own — you build Sync Client and JobType plugins on top of it. It depends
on Advanced Queue (and core's MySQL database driver) and provides its own
permissions. It supports Drupal 11.

Because the whole purpose is exchanging data with a remote system, keep the
security implications in mind: data flows in and out of your site (which may
include personal data — confirm that is acceptable for what you sync); remote
**credentials should be stored as secrets** (an environment variable or a Key
entity) and used over HTTPS; and data received from the remote should be
**validated before you use it**. A couple of practical limitations from the
module's own notes: an early version needed a tweak to the Advanced Queue table's
payload column (JSON) — check the module's install notes — pause durations are
currently hardcoded, and each Sync Client/JobType needs its own queue ID.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add Advanced
   Queue, and enable the module.

## How to use it

Sync Clients has no settings screen of its own — you use it by writing code.
Create a Sync Client plugin per API (or per endpoint) and a matching Advanced
Queue JobType plugin, configure a dedicated queue for each, and kick off syncs
from a Drush command or a cron task (for bulk imports, a self-replicating queue
job can page through a listing endpoint). The base class was designed around HTTP
requests, but implementations can override the request handling for SOAP or FTP.
Configure notification recipients globally or per plugin, and grant the module's
permissions to the appropriate roles.
