# Simplifying — manual setup guide

**Simplifying** (`simplifying`) declutters the Drupal administration UI. From a
single settings form you decide what to hide — toolbar tabs, admin menu links,
whole field groups on entity forms, local task tabs, and contextual (pencil‑menu)
links — so that editors and other non‑technical users see a stripped‑down,
less intimidating admin experience with only the options they actually need.

It's a "less is more" tool driven entirely by configuration. You tick what you
want removed on one page, and the module hides those things through Drupal's
render and menu hooks. Editors can flip into a temporary **full administration**
mode (everything shown again) with a one‑click toggle stored in a browser cookie,
so hiding never truly locks anyone out. The module also tracks newly created
content for an "unread" toolbar indicator and can prune the admin menu of the
contrib `basket` e‑commerce module.

Common uses include hiding the Devel tab on production, removing the *Authoring
information*, *Menu settings*, or *Revision information* groups from node forms for
content editors, stripping rarely used admin menu links, and turning off local
task tabs editors shouldn't touch.

> **Important:** all of this hiding is **UI convenience only** — it removes admin
> chrome from view but is **not** an access‑control or permission mechanism.
> Don't rely on Simplifying to keep users away from something they must not reach;
> use real permissions for that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form and everything it
   can hide, section by section.

## Where it lives in the admin menu

Once enabled, Simplifying's settings form sits at **Configuration → Development →
Simplifying** (`/admin/config/development/simplifying`). Reaching it requires the
restricted **Access simplifying setting** permission.

## How to use it

1. Enable the module and grant the **Access simplifying setting** permission to
   the administrators who should manage the simplified UI.
2. Open the settings form and choose what to hide — see
   [Configuration](configuration/index.md).
3. Save. The chosen tabs, links, fields, and tabs disappear for everyone (subject
   to the full‑administration cookie toggle). Because all choices live in one
   config object (`simplifying.settings`), you can roll the whole simplified setup
   between environments as ordinary configuration.
