# Commerce Project Browser — manual setup guide

**Commerce Project Browser** (`commerce_project_browser`) lets you browse and install
**Commerce recipes** published on Packagist, from the pages where they are relevant.
It extends Drupal core's **Project Browser** by adding a source that discovers
Commerce integrations on Packagist by category — including ones not yet present in
your codebase — so that while a site builder is configuring a Commerce feature, the
relevant Commerce recipes are surfaced and can be installed in place.

In short, it turns "go find and add a Commerce add-on" into something you do in
context, without leaving the admin UI. It depends on the **Project Browser** module
(`project_browser`) and requires Drupal 11 (`core_version_requirement: ^11`).

Because it installs code and recipes, treat it as an administrator-only tool. It
inherits Project Browser's install workflow and its access model, so restrict it to
trusted administrators — installing arbitrary packages is a high-privilege action.
Note also that this is an early (alpha) release and the project is not covered by
Drupal's security advisory policy, so use it deliberately and test on a non-production
copy first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Project Browser.

There is **no dedicated settings form** — it plugs a new source into Project Browser,
which you use as normal, described below.

## Where it lives in the admin menu

The module adds no settings page of its own. Instead it contributes **category-specific
Project Browser sources** and surfaces each as a **local action on the Commerce page it
relates to** — for example a "Browse marketplace" / "Add payment integration" action on
the **payment gateway** collection, the **shipping method** collection, and the main
**Commerce configuration** page. These are deliberately shown where they are relevant
rather than as extra tabs on the generic **Extend → Browse** page. Each action opens a
Project Browser listing already narrowed to that category's recipes
(`/admin/modules/browse/commerce_packagist_recipes:<category>`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)), which also enables
   Project Browser.
2. Open the Commerce page for the feature you want — e.g. **Commerce → Configuration →
   Payment gateways** — and use its "Browse marketplace" / "Add …" local action to browse
   the relevant Commerce recipes by category. (You can also open the browse URL directly.)
3. As a trusted administrator, install a recipe in place through Project Browser's
   normal install workflow.
4. Keep this capability restricted to administrators you trust, since it installs
   code.
