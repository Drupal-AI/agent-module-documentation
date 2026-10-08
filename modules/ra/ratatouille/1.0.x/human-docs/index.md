# Ratatouille — manual setup guide

**Ratatouille** (`ratatouille`) is a site-building tool that helps you export
reusable **Drupal Recipes** from a site you've already built. A recipe packages
up configuration and default content so you can share it, replicate it, or use it
to bootstrap new projects. Ratatouille gives you a step-by-step wizard for
capturing those pieces without hand-assembling the recipe files yourself.

The wizard walks you through choosing what to include, and Drupal's dependency
system does the heavy lifting: it automatically discovers and pulls in the modules,
configuration, and assets your selection depends on. It can detect content types,
fields, taxonomies, media, and other configuration to bundle into the recipe, and
it writes the result in Drupal's official recipe format — ready to drop into
installers and workflows.

> **This module is under active development and may be unstable** — the maintainers
> advise proceeding with caution, so try it on a non-production copy first.

> **Review before you share.** A recipe can contain both configuration and content.
> Always look through the generated recipe before handing it to anyone, so you
> don't accidentally leak sensitive configuration or data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no persistent settings page** — Ratatouille is driven entirely by its
export wizard, described below.

## How to use it

1. Build out the content types, fields, taxonomies, media, and configuration you
   want to package on your site as usual.
2. Launch the Ratatouille wizard and follow its steps to select the content and
   configuration to include.
3. Let the wizard's automated dependency scanning gather the required modules,
   config, and assets.
4. Generate the recipe. Ratatouille produces a standards-compliant Drupal Recipe
   you can review, share, and reuse to bootstrap other projects.
