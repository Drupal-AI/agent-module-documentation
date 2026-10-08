# CSS Usage Analyzer — manual setup guide

**CSS Usage Analyzer** (`css_usage_analyzer`) is a front‑end performance and
diagnostics tool that inspects your site's CSS to find styles that aren't actually
being used. It reports **unused selectors and rules** across your themes, breaks
the analysis down **per page**, maps which components pull in which stylesheets,
and offers **critical‑CSS suggestions** for above‑the‑fold content — all from an
interactive dashboard inside the Drupal admin. The goal is to help you trim CSS
bloat, cut render‑blocking payload, and improve Core Web Vitals such as LCP and
FCP.

It's aimed at developers and themers auditing custom themes, admin themes, and
contributed theme libraries, and it understands modern Drupal building blocks —
Single Directory Components (SDC), Layout Builder blocks, and Paragraphs — so it
can point at component‑level and over‑shared CSS. Alongside the dashboard it
provides an unused‑rule explorer (source file, line number, rule size, page
impact, code preview) and lets you export optimization reports and compare scans
over time.

It depends on core's **System** and **User** modules only, and supports Drupal
10.3 and 11. Access is governed by two permissions — `access css usage analyzer`
(to view the reports and dashboard) and `administer css usage analyzer` (for
administrative control) — so you can keep this developer‑facing tooling to trusted
users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module is a **reporting/analysis dashboard** rather than a settings form, so
there is no separate configuration page to fill in — you grant its permissions and
then work from its dashboard, as described below.

## Where it lives in the admin menu

Once enabled, the analyzer's dashboard and reports become available in the admin
to users who hold the `access css usage analyzer` permission. Grant the
permissions first at **People → Permissions** (`/admin/people/permissions`), then
open the CSS Usage Analyzer dashboard from the admin menu.

## How to use it

1. At **People → Permissions**, grant **`access css usage analyzer`** to the roles
   that should view reports, and **`administer css usage analyzer`** to those who
   should manage the tool.
2. Open the **CSS Usage Analyzer** dashboard from the admin and review the
   headline metrics — total CSS size, unused‑CSS percentage, potential savings,
   and stylesheet rankings.
3. Use the **per‑page analysis** and the **unused‑rule explorer** to see which
   selectors are dead on which pages, with source file, line number, and a code
   preview.
4. Check the **critical‑CSS suggestions** for above‑the‑fold and render‑blocking
   styles, then **export** a report or compare against an earlier scan to track
   progress.
5. Remove or split CSS in your theme based on the findings — and re‑scan to
   confirm the improvement before deploying.
