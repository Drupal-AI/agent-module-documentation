# Reporting — manual setup guide

**Reporting** (`reporting`) turns your Drupal site into a collector for the reports
that modern browsers send about problems on your pages — Content-Security-Policy
(CSP) violations, deprecation warnings, network errors, intervention and crash
reports. It implements the **W3C Reporting API**: you define one or more *reporting
endpoints*, the module advertises them to browsers with a `Reporting-Endpoints`
response header, and when browsers POST reports back, it validates and logs them
into Drupal's logging system.

It's aimed at security and developer-tooling use cases. Instead of relying on a
third-party SaaS like report-uri.com, you get a first-party place to catch CSP
violations while you roll out a policy, learn which deprecated web features your
site still uses, or debug which script a CSP is blocking. It even normalizes
Firefox's non-standard CSP report format automatically, and pairs with the contrib
**Content-Security-Policy** (`csp`) module: a bundled integration plugin lets CSP
point its `report-uri`/`report-to` at one of your reporting endpoints.

Each endpoint is a simple configuration entity you manage in the admin UI. Enabled
endpoints are advertised in the header and accept reports at
`/system/reporting/{id}`; a disabled endpoint returns `410 Gone` (which tells
browsers to stop sending). Reports are written to the `reporting` log channel, and
if core **dblog** is enabled, a "Recent violation reports" admin page renders them
in a table. The public report-intake URL is intentionally unauthenticated —
browsers post without credentials, by design. The module needs Drupal 10.1+/11 and
a small PHP library (`gapple/structured-fields`) that Composer installs for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (needs a PHP
   library) and enable it.
2. [Configuration](configuration/index.md) — create and manage reporting
   endpoints, enable/disable them, the CSP integration, and where to read collected
   reports.

## Where it lives in the admin menu

Endpoints are managed at **Configuration → System → Reporting endpoints**
(`/admin/config/system/reporting`). Collected reports (with dblog enabled) appear at
**Reports → Recent violation reports** (`/admin/reports/reporting`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)). It ships one
   endpoint, `default`, ready to go.
2. Optionally add more named endpoints at **Configuration → System → Reporting
   endpoints** (e.g. one for CSP, one for deprecations).
3. Browsers that support the Reporting API will start POSTing reports to your
   enabled endpoints, driven by the `Reporting-Endpoints` header the module adds.
4. If you use the **Content-Security-Policy** module, point its reporting at one of
   your endpoints via the bundled "Reporting Endpoint" handler (see
   [Configuration](configuration/index.md)).
5. Read what comes in at **Reports → Recent violation reports** (requires dblog).
