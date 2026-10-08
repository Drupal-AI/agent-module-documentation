# Composer Forced — manual setup guide

**Composer Forced** (`composer_forced`) disables core's Update Manager
install-and-update **forms**, so nobody can add or upgrade a module through the
browser on a site whose dependencies are managed by Composer. On a
Composer-managed site, installing a module through the UI is a quiet disaster: the
files land on disk, but `composer.json` and `composer.lock` never learn about it,
and the next `composer install` — a deployment, a rebuild, a colleague's fresh
clone — silently deletes it. The damage usually surfaces days later as an
unexplained missing feature. This module removes the temptation by taking those
buttons away.

Crucially, it does *not* disable update *reporting*: the security and available-
update notices at `/admin/reports/updates` still appear, so you keep the warnings
and only lose the footgun. It depends only on core's **Update** module and works
the moment you enable it — there is nothing to configure.

Two honest caveats. First, this is a **guardrail against accidents, not a
security control**: anyone with file access or the "administer modules"
permission can still change the codebase by other means, so do not present it as
hardening. Second, the maintainers note that once Drupal core's own equivalent
(issue #3417136) lands in a stable release (10.4+), this module's functionality
is no longer needed — so on newer core, check whether core already covers your
need before adding it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it takes effect as soon as
it is enabled, with nothing to set up.

## Where it lives in the admin menu

Composer Forced adds no settings page. Its only visible effect is on the
**Extend** and **Update** areas of the admin UI, where the "Install new module"
and "Update" actions that would write to the filesystem are removed. Update
availability reporting at **Reports → Available updates**
(`/admin/reports/updates`) continues to work normally.
