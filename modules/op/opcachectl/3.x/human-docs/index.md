# OPcache Control — manual setup guide

**OPcache Control** (`opcachectl`) is a small server‑operations tool that lets
you see PHP's OPcache status from inside Drupal and clear the opcode cache when
you need to. PHP's OPcache stores compiled code in memory so it doesn't have to
recompile your PHP on every request. That's great for performance, but after a
deploy the cache sometimes holds on to the *old* compiled files and needs a
nudge to pick up your changes. This module gives you that nudge — a status page
and a clear action — without dropping to the command line.

It also exposes a remote clear via PURGE and POST requests, which is handy for
wiring cache clearing into a deploy pipeline. Because clearing OPcache forces PHP
to recompile everything (a brief performance hit), the ability to trigger it is
the security‑relevant part: treat it as an administrator‑only, deploy‑time
operation. An unprivileged user who could clear the cache repeatedly could
degrade performance — a mild denial of service — so keep the status page and the
clear action restricted to administrators.

The module works as soon as you enable it and has **no settings form** of its
own. Everything you need is covered in Installation and the notes below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.

## How to use it

Once enabled, use the OPcache status page to check the cache's state and memory
use, and trigger a clear after a deploy so PHP recompiles your changed files. The
remote PURGE/POST clear can be called from a deploy script when you want to
automate that step.

Because clearing forces a full recompile, keep this as an operational,
administrator‑only action rather than a routine user feature. Confirm on your own
site that the status and clear actions are gated to trusted administrators — this
is the single most important thing to verify after enabling.
