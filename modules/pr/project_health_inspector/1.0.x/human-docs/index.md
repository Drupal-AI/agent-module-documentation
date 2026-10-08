# Project Health Inspector — manual setup guide

**Project Health Inspector** (`project_health_inspector`) scans the contrib and
custom modules already downloaded on your site for common, reproducible **project
health issues**, and turns each finding into a ready-to-file **Drupal.org issue
draft**. It is aimed at site builders and contributors who want to review a
codebase before deployment, or who want to file well-formed bug reports without
hand-collecting every code reference.

It is not a replacement for PHPCS, PHPStan, Rector, Upgrade Status, or an AI
reviewer — it targets Drupal-specific problems that affect installability,
administration, config validation, or route execution. Typical checks include a
missing `configure:` link when a settings route exists, malformed or wrongly-typed
`config/install/*.yml`, installed config keys missing from the schema, route
controller/form classes pointing at missing files, and likely-missing File/Media
dependencies. Each finding comes with a severity, a confidence level, the module
version, evidence, reproduction steps, and a suggested resolution — and can be
exported as Markdown.

Because several checks are heuristic, findings should be **manually verified**
before you post them as issues — especially the config-schema and dependency
checks, which should be reproduced before being treated as confirmed bugs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is a small settings form for scan scopes and history — it is covered under
"How to use it" below rather than on a separate page.

## Where it lives in the admin menu

The report lives at **Reports → Project Health Inspector**
(`/admin/reports/project-health-inspector`), and the settings form at
**Configuration → Development → Project Health Inspector**
(`/admin/config/development/project-health-inspector`).

## How to use it

1. **Grant permissions.** At **People → Permissions**
   (`/admin/people/permissions`), give trusted users **Access Project Health
   Inspector report** (view results and export findings) and, for those who should
   change scan options, the restricted **Administer Project Health Inspector**.
2. **Run a scan.** Open **Reports → Project Health Inspector**
   (`/admin/reports/project-health-inspector`) and run a scan. It inspects modules
   under `modules/contrib`, `modules/custom`, `profiles/*/modules`, and
   `sites/*/modules`.
3. **Review findings.** Filter by severity, confidence, finding type, or search
   text. Each finding shows evidence, reproduction steps, and a suggested fix.
   The report also keeps a scan history so you can see trends over time.
4. **Export.** Export findings as Markdown issue drafts for easier Drupal.org
   reporting — verify each one before posting it.
5. **Tune the scan (optional).** At **Configuration → Development → Project Health
   Inspector**, adjust the scan scopes, which checks are enabled, and how many
   scan summaries to keep in the history.

> **Tip:** You can run the same scan headless with `drush phi:scan` (alias of
> `drush project-health-inspector:scan`) — useful in CI or before a release.
> Pairing it with Configuration Inspector and Upgrade Status gives deeper schema
> and upgrade-readiness checks.
