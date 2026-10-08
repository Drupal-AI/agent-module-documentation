# Module Weight Analyst — manual setup guide

**Module Weight Analyst** (`module_weight_analyst`) is a developer utility for
monitoring and managing Drupal's **module execution order** — the "weight" that
determines when each module's hooks and services run. It turns weight management from
a guessing game into a data‑driven process through an interactive dashboard.

In Drupal, if security or routing modules fire in the wrong sequence you can get silent
failures or performance bottlenecks, and the load order is normally a "black box." This
module opens that box: an **Integrity Dashboard** shows a visual "Health Score" based on
recursive dependency‑sequence validation, **dependency auditing** flags "early‑load"
risks where a child module is set to run before its parent dependency, and
**conflict‑prevention logic** blocks you from saving configurations known to cause
circular dependencies or service‑container breaks. Strategic filters let you isolate
modules by origin (core, contrib, custom), execution phase, or conflict status, and you
adjust weights directly in an interactive table.

It requires **PHP 8.1+** and provides its own permission. There are no external
libraries or module dependencies.

> **Adjusting module weights alters core security and routing layers.** Always make
> weight changes on a local or staging environment first, and verify each module shows a
> "Valid Sequence" badge before applying. Restrict the module's permission to trusted
> developers.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is no separate settings form to fill in — the diagnostic dashboard is the tool.
Using it is described below.

## Where it lives in the admin menu

The Analyst suite is at **Configuration → Development → Module Weight Analyst**.

## How to use it

1. After installing (see [Installation](installation/index.md)), go to **Configuration →
   Development → Module Weight Analyst**.
2. Review the **Sequence Integrity** card and the Health Score for any modules flagged
   with conflicts.
3. To change a module's order, edit its weight value directly in the interactive table.
   Lower (more negative) numbers run earlier; higher numbers run later.
4. Check the **Audit** column for a "Valid Sequence" badge before proceeding.
5. Click **Apply Weights** to commit the changes to your site configuration — ideally on
   staging first, then deploy.
