# Better Experience for Reroute Emails — manual setup guide

**Better Experience for Reroute Emails** (`reroute_email_be`) sits alongside the
[Reroute Email](https://www.drupal.org/project/reroute_email) module and improves
the operator experience around it. Reroute Email intercepts outgoing mail on
non-production sites and redirects it to a fixed address, so real users and
subscribers are never accidentally contacted from a staging or test environment.
This companion adds a friendlier settings screen, finer-grained permissions,
data-governance roles, and a visible status block on top of that.

Its headline features are: a dedicated settings form; a set of granular
permissions so you can split control across roles (for example, only one role may
change the destination address while another may edit the skipped addresses); three
governance roles it installs — **Data Owner**, **Data Steward**, and **Data
Custodian**; a themeable **Rerouting Status** block that clearly shows whether
rerouting is currently on, off, or unconfigured; and Drush commands for scripting
the rerouting state in CI pipelines.

> **Important:** Reroute Email (and this companion) exist to *protect* non-production
> environments by capturing outbound mail. Do not leave rerouting active on a
> production site — if you do, real transactional and notification emails will be
> diverted to your test address and never reach your users. The status block exists
> precisely so this state is never a surprise.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Reroute
   Email dependency) with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, the governance
   permissions and roles, and the status block, step by step.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → Better
Experience for Reroute emails** (`/admin/config/development/reroute_email_be`). It
is gated by the **Administer reroute email** permission, and individual fields on
the form are further restricted by the granular permissions described in
[Configuration](configuration/index.md).
