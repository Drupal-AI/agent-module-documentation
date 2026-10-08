# CSP logging — manual setup guide

**CSP logging** (`csp_log`) gives your site a dedicated place to collect
Content‑Security‑Policy violation reports. When a browser blocks a resource
because of your CSP, it can POST a report describing what was blocked. This
module accepts those reports at its own endpoint and stores each one in a
dedicated database table — keeping them out of Drupal's watchdog/dblog log so
they don't bury your real application errors — then gives you admin screens to
browse and aggregate them.

Reports arrive at the public endpoint `/log-report-uri/{type}`, where `{type}`
is `enforce` for reports from an enforced policy or `report-only` for reports
from a report‑only policy. Each violation is saved with its document URI,
effective directive, blocked URI, referrer, type, the raw report JSON, and a
timestamp. You read them at **Reports → CSP** (`/admin/reports/csp`), a
searchable, filterable list, and at **Reports → CSP → aggregated logs**
(`/admin/reports/csp/aggregated-logs`), which groups violations by blocked URI
and directive with counts so you can spot the noisiest offenders. Both screens
are gated by the **Access CSP reports** permission.

The easiest way to wire the endpoint up is through the companion
[CSP](https://www.drupal.org/project/csp) module: it provides a reporting‑handler
plugin type, and this module ships a **"Dedicated CSP log"** handler. Select that
handler on your CSP policy and the `report-uri` directive is pointed at this
module's endpoint automatically. The handler also adds a **Log lifetime (days)**
option; on cron, logs older than that are deleted (0 keeps them forever). You can
also use the endpoint standalone by pointing any CSP `report-uri`/`report-to`
directive at the path yourself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

> **No settings form.** This module has no configuration page of its own. All
> setup happens either on the CSP module's policy form (recommended) or by
> pointing a CSP header at the endpoint manually, both described below.

## Where it lives in the admin menu

The report screens live under **Reports**: a per‑violation list at
**Reports → CSP** (`/admin/reports/csp`) and a grouped view at
**Reports → CSP → aggregated logs** (`/admin/reports/csp/aggregated-logs`). Both
require the **Access CSP reports** permission, which you grant on
`/admin/people/permissions` to a trusted role such as an administrator or your
security team. The report endpoint itself is public and needs no permission.

## How to wire it up

**Recommended — through the CSP module.** Install and enable the
[CSP](https://www.drupal.org/project/csp) module. On its policy form, for the
Enforced and/or Report‑only policy, choose the reporting handler **"Dedicated CSP
log"**. That automatically sets the policy's `report-uri` directive to this
module's endpoint, with the correct `enforce` vs `report-only` type. In the
handler's options, set **Log lifetime (days)** to have old logs pruned
automatically on cron (leave it at 0 to keep logs forever).

**Standalone — set the header yourself.** If you are not using the CSP module,
add a CSP header with a matching report directive, for example:

```
Content-Security-Policy-Report-Only: default-src 'self'; report-uri /log-report-uri/report-only
Content-Security-Policy: default-src 'self'; report-uri /log-report-uri/enforce
```

The endpoint expects the browser's standard report JSON. On success it returns
HTTP 202; a report missing the required fields returns 400. Note that automatic
cron cleanup only runs when the CSP module drives the configuration — standalone
users must prune old logs themselves.

## How to use it

Once reports start arriving, open **Reports → CSP** to browse individual
violations (search by document URI, referrer, blocked URI, or directive, and
filter by type and date), and **Reports → CSP → aggregated logs** to see which
resources are blocked most often. This is the practical way to tune a report‑only
policy before enforcing it, to find third‑party scripts, fonts, or images your
policy is blocking, and to spot possible injection attempts.
