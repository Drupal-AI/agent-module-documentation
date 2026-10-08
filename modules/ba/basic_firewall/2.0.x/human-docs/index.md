# Basic Firewall — manual setup guide

**Basic Firewall** (`basic_firewall`) is a web application firewall for your
Drupal site. It inspects every incoming request against a set of
allow / challenge / block rules **before** Drupal does its expensive work —
before routing, sessions, authentication and even the page cache run. That
ordering matters two ways: unwanted traffic is rejected cheaply, and because the
check happens server‑side inside an HTTP middleware, a visitor cannot bypass it
from their browser.

You build the rules in an admin dashboard. Rule types are pluggable and cover
the usual firewall needs: block or allow a single **IP address** or CIDR range,
match on **user‑agent** string, match on **URL** path, block an entire **ASN**,
restrict by **country** (GeoLocation), **rate‑limit** requests per client, score
requests with a Core Rule Set / vulnerability heuristic, or consult
**AbuseIPDB** reputation. Rules are ordered by weight, and you can exempt a
trusted Drupal role from evaluation entirely.

Rules are stored as normal Drupal configuration, so they export with
`drush config:export` and travel between environments like anything else. Behind
the scenes the module compiles those rules into a file in your private files
directory — a rebuildable cache the middleware reads on every request. A handful
of Drush commands (`bfw:rebuild`, `bfw:status`, `bfw:rules`) cover the CI/ops
side.

This is a security module, so a couple of honesty notes belong here. It is
currently a **beta** release (2.0.0‑beta1). And if your site sits behind a
reverse proxy or CDN, you must configure Drupal's trusted‑reverse‑proxy settings
so the firewall sees the real visitor IP rather than the proxy's — otherwise your
IP and geo rules match the wrong address. Both points are covered in
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the per‑environment kill switch.
2. [Configuration](configuration/index.md) — the dashboard, the rule model, each
   rule type, permissions, the reverse‑proxy caveat, and the Drush commands.

## Where it lives in the admin menu

The firewall dashboard sits at **Configuration → System → Basic Firewall**
(`/admin/config/system/basic-firewall`). Every screen — rules, settings,
storage, logging, challenge flow, presets, the request tester, the compiled view,
and the blocked‑client list — lives under that path and is protected by the
module's permissions.
