# HTTP Queue — manual setup guide

**HTTP Queue** (`http_queue`) lets your site make **outbound HTTP requests
asynchronously** by putting them on a queue and processing them through the
[Advanced Queue](https://www.drupal.org/project/advancedqueue) module, rather than
firing them off synchronously during a page request. External calls — webhooks,
API pushes, third-party integrations — then happen in the background, can be
retried, and don't block or slow down the request that triggered them.

It also **defines an endpoint for retrieving and updating queue jobs**, which is
useful when the jobs are meant to be run by *other* servers and a job's state
depends on a remote system: an external worker can pull jobs and report their status
back.

This is developer, integration, and operations plumbing — there is no content or
access role, and no admin settings form. You use it from code that enqueues
requests, and you run the queue the way you run any Advanced Queue queue.

**A security note worth taking seriously:** outbound requests are made with whatever
URLs and credentials the enqueuing code provides. So make sure **only trusted code
enqueues requests**, treat any target **credentials as secrets**, prefer **HTTPS**
targets, and — if request URLs can ever be influenced by user input — **guard
against SSRF** (server-side request forgery) before enqueuing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Advanced Queue dependency.

There is **no configuration page** for this module. You use it from code and run its
queue via Advanced Queue, as described below.

## How to use it

1. Make sure **Advanced Queue** is installed and enabled (it is a dependency).
2. From trusted code, **enqueue** the outbound HTTP requests you want made
   asynchronously.
3. **Process the queue** the way you process any Advanced Queue queue — for example
   on cron, or with Advanced Queue's Drush processor.
4. Where jobs are run by external servers, those workers can use the module's
   **endpoint** to retrieve and update job state.

Before enqueuing, apply the security precautions above: trusted callers only,
credentials kept as secrets, HTTPS targets, and SSRF guarding for any
input-influenced URLs.
