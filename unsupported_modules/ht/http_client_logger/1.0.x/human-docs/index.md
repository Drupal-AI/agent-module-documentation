# HTTP Client Logger — manual setup guide

**HTTP Client Logger** (`http_client_logger`) is a developer/debugging tool that
records the requests and responses made by Drupal's core HTTP client (Guzzle). It
hooks into the `http_client` service as a **logging middleware**, which means it can
capture the traffic of core and contrib modules alike **without patching their
code** — you enable the module, and their outbound calls start showing up in the
log.

This is invaluable when you are developing or debugging a third-party API
integration: you can see the exact method, URL, headers, and bodies that went out
and came back, without touching the implementing module.

**Read this before enabling it.** HTTP Client Logger writes full request and
response **headers and bodies with no redaction**. That means `Authorization`
bearer tokens, `X-Api-Key` headers, and any secrets or personal data in request or
response bodies are written to the Drupal log in plaintext — readable by anyone with
the "access site reports" permission and forwarded to any log aggregator you use.
It is strictly a **development tool: never leave it enabled in production.**

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the logging settings form and the
   precautions to take.

## Where it lives in the admin menu

Its settings form is at **Configuration → Development → Logging →
HTTP client** (`/admin/config/development/logging/http_client`). The captured
entries appear in your normal Drupal log (for example **Reports → Recent log
messages** if you use core's Database Logging).
