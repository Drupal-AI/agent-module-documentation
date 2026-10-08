# Condition Plugins — manual setup guide

**Condition Plugins** (`condition_plugins`) adds a collection of extra *condition
plugins* to Drupal's condition/visibility API. Conditions are the same reusable
building blocks core uses for block visibility ("show this block only on these
paths / for this role"), and other modules such as Context reuse them too. This
module simply registers a few more of them, so they appear wherever conditions
are configured.

At the time of writing it provides two conditions:

- **First request** — true the first time a visitor lands on the page (their
  first request), useful for one-time welcome content.
- **Request parameter** — true when the current request carries particular query
  parameters, so you can vary what appears based on the URL's `?key=value` pairs.

The module is a *pure plugin provider*. It has no settings page, adds no admin
menu items, has no dependencies, and defines no permissions of its own. You never
configure the module itself — you select its conditions from a block's (or other
host's) visibility settings. It works the moment you enable it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You use its conditions from a
block's **Visibility** settings, described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** (`/admin/structure/block`) and edit or
   place a block.
3. Open the **Visibility** tab and look for the **First request** and **Request
   parameter** conditions among the options.
4. Configure the condition and **Save block**. The condition also becomes
   available anywhere else that consumes Drupal conditions (for example the
   Context module).
