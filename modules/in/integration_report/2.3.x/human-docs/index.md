# Integration Report — manual setup guide

**Integration Report** (`integration_report`) gives you one admin page that shows
the live availability of the third‑party services your site talks to. Many sites
depend on several external integrations — payment gateways, a CRM, SSO, a search
service — with no single place to confirm they are actually reachable. Integration
Report collects status checks contributed by any module and renders them together
at `/admin/reports/integrations`, so an operator can see all integration health at
a glance. It even supports iframe‑based checks, which are handy for redirect‑based
SSO flows.

It's important to understand what this module is: a **framework**, not a
ready‑made dashboard. Out of the box it provides the report page, the permission
that guards it, and the plumbing to collect checks — but the actual status checks
come from small classes you (or another module) write. A bundled example submodule
shows exactly how. So a developer wires up one report class per integration, and
from then on operators just watch the page.

Each report's result is fetched asynchronously by JavaScript, so a slow or
unreachable endpoint won't block the page from loading. Both the overview page and
its callback are gated by the restricted **access integration report** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration form** for this module — you don't configure it in the
UI, you extend it in code. See "How to use it" below, and grant the report
permission as described.

## Where it lives in the admin menu

The report page is at **Reports → Integrations** (`/admin/reports/integrations`).
It only shows content once one or more report classes have been registered.

## How to use it

Integration Report is a developer framework. To make it show anything, a developer
adds a status check for each integration:

1. In a custom module, create a class that extends
   `Drupal\integration_report\IntegrationReportBase` and implement its methods —
   at minimum `getName()`, `getDescription()`, and `menuCallback()` (which returns
   the live check output). Optional methods let a report run through an `<iframe>`
   (for SSO/redirect flows), force HTTPS, or restrict its own access.
2. Register that class as a service and tag it `integration_report`, for example:

   ```yaml
   services:
     mymodule.integration_report:
       class: Drupal\mymodule\MyIntegrationReport
       tags:
         - { name: integration_report }
   ```

3. Grant the **access integration report** permission to the roles that should
   see the page (**People → Permissions**).
4. Visit **Reports → Integrations** — each registered report appears as a row, and
   its status loads live.

The `integration_report.api.php` file and the bundled `integration_report_example`
submodule are good copy‑paste starting points.
