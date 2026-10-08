# Projects Audit — manual setup guide

**Projects Audit** (`projects_audit`) provides **Drush commands to audit the
contributed modules and themes installed on your site** — similar to what you see
on Drupal's own *Available updates* report (`admin/reports/updates`), but on the
command line so it can be wired into CI pipelines. It is a developer-facing
reporting tool: it inspects the maintenance/support state of your projects and has
no content or access-control role.

The reason it exists alongside `composer audit`: `composer audit` shows you
*security* updates, but it will not surface every issue with modules and themes —
for example projects a maintainer has marked as **unsupported** (no longer
recommended, or a release that is no longer maintained after a newer one shipped).
Projects Audit fills that gap.

The headline command is `drush projects_audit:unsupported`, which lists projects
that are marked as not supported. Being CLI-first, it is designed to run in
continuous-integration tooling as part of a maintenance or compliance check.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no configuration page — this module is used entirely through Drush, as
described below.

## Where it lives in the admin menu

Projects Audit adds no admin page and no configuration form. You use it from the
command line via Drush.

## How to use it

Once the module is enabled, run its audit command:

```bash
drush projects_audit:unsupported
```

This lists the installed projects a maintainer has marked as unsupported. Because
it is a Drush command, it fits naturally into CI: run it as a build step to catch
unsupported modules or themes before they reach production, complementing
`composer audit` (which covers security advisories).
