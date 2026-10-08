# Contentish Config — manual setup guide

**Contentish Config** (`contentishconfig`) addresses a familiar tension in
Drupal's configuration management. Some configuration entities are really more
like **content** than like deployable configuration — a value that is legitimately
different on each environment, or that editors change on the live site and that
should *not* be reverted by a deployment. Drupal's config‑sync workflow, left to
itself, would flag those as overrides or overwrite them on the next
`config:import`. Contentish Config lets you mark such config as **"contentish"**
so it is **excluded from configuration import/export** and left alone during
deployment.

In practice this means you designate certain configuration as site‑specific,
treated more like content, and the module keeps it out of the sync process — it is
neither exported into your config directory nor overwritten when you import. That
protects site‑specific settings from being clobbered by a deploy, and stops them
appearing as spurious overrides that make your config state look "dirty".

It is a small **configuration‑management** helper with no dependencies beyond
core, and it runs on Drupal 8.8 through 11. The project is minimally maintained
(maintenance fixes only) and this version is **not covered** by Drupal's security
advisory policy, so weigh that for production. There is no elaborate settings
screen — you simply mark the config entities you want treated as contentish.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central settings form** — you mark individual configuration as
contentish, described below.

## How to use it

1. Decide which configuration is genuinely **site‑specific / content‑like** — the
   settings that should differ per environment or that editors change on
   production and that a deploy must not revert.
2. **Mark that configuration as contentish** using the module. From then on it is
   treated as content for sync purposes.
3. Run your normal **configuration export/import** workflow. Configuration you
   marked as contentish is **excluded** — it is not exported, and an import will
   not overwrite it or flag it as an override.

The result is a cleaner config‑sync state: deployable configuration stays under
review in your config directory, while the site‑specific bits you deliberately
marked stay put across deployments.
