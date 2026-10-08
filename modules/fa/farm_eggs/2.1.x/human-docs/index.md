# Farm Eggs — manual setup guide (2.1.x)

**Farm Eggs** (`farm_eggs`) is a [farmOS](https://farmos.org) add‑on that provides a
"quick form" for recording egg harvests. Instead of stepping through farmOS's full log
form, a farmer gets a streamlined single‑screen form to log how many eggs were
collected and from which assets, and the module creates the corresponding harvest log
behind the scenes.

This is the **2.1.x** branch, built for **farmOS 2** on **Drupal 9 or 10**. It depends
on the farmOS modules `farm_harvest` and `farm_quick`, and it is only usable inside a
farmOS installation. Access and permissions are inherited from farmOS's quick‑form and
log access system — there is nothing extra to configure.

> **Which version?** This 2.1.x branch is for farmOS 2 on Drupal 9/10. If you are on
> farmOS 4 / Drupal 11, use the **3.0.x** branch instead, which adds a "Produces eggs"
> flag on animal and group assets and other refinements.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it inside
   your farmOS site.

There is **no settings page** — the module simply adds a quick form, used as described
in "How to use it" below.

## Where it lives in the admin menu

Farm Eggs adds no configuration page of its own. Its quick form appears under farmOS's
**Quick Forms** UI, which is provided by the `farm_quick` module.

## How to use it

1. Open the **Quick Forms** area of your farmOS site and choose the **Eggs** quick
   form.
2. Fill in the egg **quantity** collected (and the applicable date and assets, such as
   the flock the eggs came from).
3. Submit. Farm Eggs creates a farmOS **harvest log** recording the egg count,
   associated with the assets you chose.

Over time these logs build a record of egg production you can feed into farmOS
dashboards, views, and reporting. The focused form makes daily entry quick — handy on
mobile out in the field — and reduces the data‑entry errors of the generic log form.
