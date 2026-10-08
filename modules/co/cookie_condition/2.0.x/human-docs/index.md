# Cookie Condition — manual setup guide

**Cookie Condition** (`cookie_condition`) adds one **condition plugin** that matches
when a named cookie exists and, optionally, holds a specific value. Drupal's
condition system is what block visibility — and a good deal of contrib — is built
on, so anything that accepts a condition can accept this one. The plugin has just
two settings: the **cookie name** and the **value** to compare. Put it on a block
and the block shows only for visitors carrying that cookie; use it anywhere else
conditions are collected and it behaves the same way.

It is a natural fit for a small set of presentational jobs: showing a
returning‑visitor message, hiding a promo from anyone who has dismissed it,
exposing a beta feature to an internal audience marked by a cookie your edge sets,
or aligning display with a consent cookie written by a banner. The module works the
moment you enable it, has no dependencies, and has no settings page of its own —
you configure the condition wherever you use it.

**Do not use it as an access control.** A cookie is set by the client and can be
forged with one line in the browser console, so this decides *what is displayed*,
never *what is permitted*. If a block reveals something that must not leak, gate it
on a permission or entity access and use the cookie only for presentation. This
matters more here than usual, because the plugin sits in the same UI slot as
conditions that genuinely do restrict.

One more thing worth knowing: output that varies by cookie needs the corresponding
**cache context**, or the first visitor's result may be served to everyone. Check
what the surrounding code declares before deploying behind a page cache.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — no settings form. You set the
cookie condition wherever conditions are collected, described under "How to use it"
below.

## Where it lives in the admin menu

Cookie Condition adds no admin page. The most common place you use it is
**Structure → Block layout**, in a block's visibility settings; it also appears
anywhere else in Drupal that collects condition plugins.

## How to use it

1. Go to **Structure → Block layout** and place or edit a block (or open any other
   UI that offers condition plugins).
2. In the visibility/conditions settings, find the **Cookie** condition.
3. Enter the **cookie name** to match, and optionally the **value** to compare
   against. Leave the value empty to match on the cookie's presence alone.
4. Save. The block now appears only for visitors carrying the matching cookie.

Two reminders every time: this is **not** an access control, and cookie‑varying
output must declare the matching **cache context**.
