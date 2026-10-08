# AxioRank Agent Verification — manual setup guide

**AxioRank Agent Verification** (`axiorank`) checks which AI agents (bots) are
reaching your site's machine‑facing endpoints — your REST and JSON:API routes,
admin pages, and dynamic pages — and can optionally block the ones that are not
verified. It is a thin client of the external **AxioRank** verify service: for each
incoming request it builds a small, header‑stripped envelope and posts it to the
AxioRank endpoint, then acts on the verdict it gets back.

It has two postures. In **monitor** mode it only records the verdict, so you can
observe agent traffic before changing anything. In **enforce** mode it can return a
403 (block) or 401 (challenge) — but only when the AxioRank server itself marks
that verdict as one to enforce. It requires Drupal 10.1, 11, or 12.

A key safety property: the client is **fail‑open by design.** If the verify service
times out, is unreachable, returns an error, or sends back something malformed —
or even if your site key is rejected — the module allows the request through rather
than risk taking your site down. It uses a short one‑second timeout for the same
reason. It also never forwards your visitors' cookies or authorization headers to
the AxioRank service.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the site key, posture, scopes, and
   the connection test.

## Where it lives in the admin menu

Its settings sit under **Configuration → Web services** at
`/admin/config/services/axiorank`, behind the **`administer axiorank`** permission.
A separate, CSRF‑protected route lets you test the connection to AxioRank.
