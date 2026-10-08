# REST Log — manual setup guide

**REST Log** (`rest_log`) records REST API requests and responses as Drupal entities
so you can see, from both sides, exactly what a client sent and what your site
returned. For each logged call it stores the request method, URI, headers, cookies
and payload, and the response status, headers, body and timing. Because each entry is
a `rest_log` entity rather than a line in a file, the log is queryable, viewable
through a ready-made Views report at **Reports → REST API Logging**
(`/admin/reports/rest_log`), and governed by an access handler — so you decide who
may read it. It is a genuinely useful tool for developing and troubleshooting a REST
integration.

The module was built with care in the places that matter: the `Authorization` header
is masked while preserving its scheme (so you still see `Bearer tok*********` and can
spot an auth-type mismatch without printing the token), session cookies are matched
by prefix, and there is a **Maximum lifetime** setting with automatic cleanup of old
entries.

That said, there are four behaviours you should understand **before switching it on**,
all verified against the code:

- **The header mask is a denylist**, keyed on header names containing `auth`, `pass`,
  `token` or `cookie`. A header like **`x-api-key` is therefore logged verbatim** —
  its value comes back in clear even though `Authorization` is masked. Others such as
  `x-secret`, `x-signature` and `x-client-secret` are missed the same way.
- **The masking keeps the first three characters** of each secret. That is enough to
  identify a credential's vendor (`sk-`, `ghp_`, `xox`, `AKI`) and, for a short
  secret, a real fraction of the value.
- **Request payloads and response bodies are stored with no redaction at all.** A POST
  to a login resource stores the submitted password; a GET on a user resource stores
  whatever personal data it returned. That makes the `rest_log` table a
  **personal-data store**, with the retention and erasure obligations that implies —
  and a table you should exclude from database dumps you share.
- **Cache-served responses are never logged.** A repeat GET that Drupal answers from
  cache produces no entry, so the log records cache *misses* only. An absence of
  entries is not evidence of an absence of requests, which makes it **unusable as an
  audit trail**.

The healthy way to use REST Log is as a diagnostic: switch it on for an
investigation, keep the **Maximum lifetime** short, restrict view access to trusted
roles, and switch it off again afterwards. Left running on a production API it quietly
accumulates credentials and personal data in a table most operators think of as debug
output.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   including the maximum lifetime and the same-host referrer filter.

## Where it lives in the admin menu

The logged entries are shown as a Views report at **Reports → REST API Logging**
(`/admin/reports/rest_log`). The settings form sits at **Configuration →
Development → Logging and errors → REST Log settings**
(`/admin/config/development/logging/rest_log`).
