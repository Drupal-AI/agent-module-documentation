# CiviMRF Core — manual setup guide

**CiviMRF Core** (`cmrf_core`) connects Drupal to a
[CiviCRM](https://civicrm.org/) instance over CiviCRM's REST API. CMRF stands for
the **CiviCRM Modular Remote‑access Framework** — and the word "remote" is the whole
point of this module.

Traditionally, CiviCRM is installed *inside* a Drupal site, sharing its database and
user table. That couples the two tightly: CiviCRM's upgrade cycle becomes Drupal's
problem, the database grows to hold both, and a Drupal major upgrade has to wait on
CiviCRM. CiviMRF takes the other road — **CiviCRM runs elsewhere, and Drupal talks
to it over the API** — so the two systems are upgraded independently. This is the
right architecture when your CRM is the organisation's system of record and your
website is just one of several things that use it.

On its own, CiviMRF Core is the connection framework. The **submodules** are what
make it useful day to day:

- **`cmrf_views`** turns CiviCRM API calls into Views sources, so a membership list
  or an event listing is built with Drupal's ordinary Views tools.
- **`cmrf_webform`** posts Webform submissions into CiviCRM.
- **`cmrf_call_report`** records what API calls were made (useful for debugging).
- **`cmrf_example`** provides example code to learn from.

Three things belong in your plan before you deploy, because personal data and remote
calls are involved:

1. **The API credentials are a grant over the organisation's CRM** — its supporters,
   donors, members and their giving history. Store them as secrets (environment
   variable + a Key entity), and use the **most restricted CiviCRM API user** the
   task allows.
2. **Personal data crosses a network boundary on every call.** Use TLS for the
   connection, and put this processing in your privacy assessment.
3. **Remote calls on the request path *are* your site's response time.** Cache
   aggressively, and decide what a page should show when the CRM is unreachable —
   because sooner or later it will be, and a stale membership list is a better answer
   than a blank page.

This module is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   core module and the submodules you need.
2. [Configuration](configuration/index.md) — set up a connection to your CiviCRM
   instance and secure the credentials.

## Where it lives in the admin menu

After enabling, you create a **connection** to your CiviCRM instance from CiviMRF's
configuration (under **Configuration**). The submodules then use that connection —
for example, `cmrf_views` exposes it as a Views data source.
