# Expose Status Report — manual setup guide

**Expose Status Report** (`expose_status`) publishes a machine-readable summary of
your site's status report — the same information you see at
`/admin/reports/status` — as **token-protected JSON**, so an external monitoring
system can watch whether the site is healthy without a human logging in. The
endpoint returns a simple verdict such as `{"status":"issues found; please
check","generated":"…"}`; the status is `ok` unless a requirement reaches a
severity above zero.

The endpoint lives at `/admin/reports/status/expose/{token}`, where `{token}` is a
strong per-site secret (generated from 128 random bytes). Any request with a wrong
or missing token gets a **403**. You retrieve the token from the command line
rather than a settings page — see "How to use it" below. By default the JSON
exposes only the overall ok/issues verdict, **not** the underlying details,
because status details can be sensitive.

Behaviour is extended through optional submodules rather than a configuration form:
**expose_status_details** adds the full requirement details to the JSON (enable
only when you really need them), **expose_status_ignore** lets you skip named
checks via a `?ignore=…` query parameter (with `?ignore_negate=1` to invert), and
**expose_status_severity** adds `?only_above_level=1` to fail on errors only, not
warnings. Responses are always fresh (uncached) and are invalidated automatically
if you rotate the token.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and choose the submodules you need.

There is **no settings form** for this module. You retrieve the token with Drush
and control behaviour by enabling submodules and adding query parameters, as
described in "How to use it" below.

## Where it lives in the admin menu

Expose Status Report adds no admin configuration page. It exposes a single JSON
route at `/admin/reports/status/expose/{token}`. The human-readable status report
it mirrors remains at **Reports → Status report**
(`/admin/reports/status`).

## How to use it

1. After enabling the module, get your endpoint URL and token from the command
   line:

   ```bash
   drush ev "expose_status_instructions()"
   ```

   To print just the raw token, use `drush ev "expose_status_token()"`.
2. Point your monitoring system (Jenkins, an uptime checker, a health dashboard,
   etc.) at `/admin/reports/status/expose/{token}` and have it read the `status`
   field. A `200` with `status: ok` means healthy; anything else, or a `403`, is
   worth alerting on.
3. Optionally enable submodules to tune the output:
   - `expose_status_details` — include full requirement details in the JSON.
   - `expose_status_ignore` — skip checks, e.g.
     `?ignore=update_core` (add `?ignore_negate=1` to invert the list).
   - `expose_status_severity` — `?only_above_level=1` to fail on errors only.

> **Keep the token secret.** It is the only thing protecting the endpoint. Treat
> the URL like a credential, prefer HTTPS, and rotate the token (by uninstalling
> and re-enabling, or via the module's token handling) if it is ever exposed —
> cached responses are invalidated automatically when the token changes.
