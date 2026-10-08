# Patch info — manual setup guide

**Patch info** (`patch_info`) gives site builders a single screen that summarizes
the **Composer patches** applied to a site. If your project uses
`cweagans/composer-patches` to patch core and contributed modules, the record of
*what* is patched normally lives scattered across your `composer.json` and patch
files — and answering "which issues have we patched, and are they still open?"
means hunting through code and visiting drupal.org issue pages one by one. Patch
info pulls that together into one report so you can review your patches at a glance
and decide what to act on.

The module is intended for **development and maintenance use** — it helps with
audits and upgrade planning by showing which patches are applied and letting you
check their status, rather than being a runtime feature for end users. It supports
Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

The short one‑time setup (pointing the module at your `composer.json` and fetching
records) is described under "Setting it up" below.

## Setting it up

Patch info needs a quick configuration pass before it can build its report:

1. Confirm the **Patch info** module is installed and enabled.
2. Go to **Administration → Configuration → Patch information** and open the
   **Patch config form**.
3. Choose or enter the location of your **`composer.json`** file, then use the
   form's **test** to confirm the path exists.
4. Once the path test succeeds, **save** the configuration.
5. After saving, **fetch the API records** so the module can look up the status of
   each patched issue.

## How to use it

With the configuration saved and records fetched, browse to **`/patch-info`** to
see the summary of applied patches — the list of patched core/contrib items and
their patch details in one place. Use it to review what has been patched and to plan
follow‑up work (for example, dropping a patch once its issue has been fixed
upstream, ahead of an update).
