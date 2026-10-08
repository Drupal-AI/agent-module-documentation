# Commerce Config Actions — manual setup guide

**Commerce Config Actions** (`commerce_config_actions`) is an **experimental
developer module** that provides custom configuration actions for use in **Drupal
Commerce recipes**. Recipes are Drupal's mechanism for applying pre‑packaged
configuration to a site; this module adds Commerce‑specific config
transformations that recipe authors can invoke while a recipe is applied. Keeping
these actions in a standalone module lets them be released at a pace that isn't
tied to the Commerce core release cycle.

This is a **tool for developers and recipe authors**, not a feature site builders
interact with. It has **no admin UI, no settings page, and no content or
access‑control role** of its own — its value shows up inside the config actions a
recipe declares. Because it is explicitly experimental, treat it as something to
test with, and pin the version you use.

It depends on Commerce **Price** (`commerce_price`) and requires **Drupal 11**
(`core_version_requirement: ^11`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Price.

There is **no configuration page** for this module — it exposes config actions for
recipes rather than a settings form.

## Where it lives in the admin menu

Commerce Config Actions adds **no admin page and no menu item**. It is consumed by
recipes: a recipe's `recipe.yml` references the config actions this module
provides. There is nothing to click through in the admin UI — enabling the module
simply makes its config actions available to the recipe system.
