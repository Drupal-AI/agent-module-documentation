# Farm Eggs — manual setup guide (3.0.x)

**Farm Eggs** (`farm_eggs`) is a [farmOS](https://farmos.org) add‑on that provides a
"quick form" for recording egg harvests. Instead of stepping through farmOS's full log
form, a farmer gets a streamlined single‑screen form to log how many eggs were
collected and from which layer assets, and the module creates the corresponding
harvest log behind the scenes.

This is the **3.0.x** branch, built for **farmOS 4** on **Drupal 11**
(`farmos/farmos: ^4`, `core_version_requirement: ^11`). Compared with the 2.x branch it
adds a **"Produces eggs"** checkbox to animal and group assets, so only the assets you
mark as egg producers are offered on the form; it auto‑selects the layer asset when
there is only one; and its submit handler copies the selected assets' current
**locations** onto the harvest log. The form is reachable directly at **`/quick/eggs`**
as well as through farmOS's Quick Forms UI.

Using the form requires the farmOS **`create harvest log`** permission; access is
otherwise inherited from farmOS's log access system. It depends on the farmOS modules
`farm_animal`, `farm_harvest`, `farm_quantity_standard`, and `farm_quick`, and is only
usable inside a farmOS installation.

> **Which version?** This 3.0.x branch is for farmOS 4 on Drupal 11. If you are on
> farmOS 2 / Drupal 9 or 10, use the **2.1.x** branch instead — it provides the same
> egg quick form but without the "Produces eggs" asset flag, location copying, and the
> `/quick/eggs` route described here.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it inside
   your farmOS 4 site.

There is **no settings page** — the module adds a quick form and an asset field, used
as described in "How to use it" below.

## Where it lives in the admin menu

Farm Eggs adds no configuration page of its own. Its quick form lives at
**`/quick/eggs`** and is also listed under farmOS's **Quick Forms** UI (provided by
`farm_quick`). The "Produces eggs" checkbox appears on the edit form of animal and
group assets.

## How to use it

1. **Mark your egg producers.** Edit an **animal** or **group** asset and tick
   **Produces eggs**. Only assets flagged this way are offered on the egg form.
2. **Open the form.** Go to **`/quick/eggs`**, or choose the **Eggs** quick form in
   farmOS's Quick Forms area.
3. **Fill it in:**
   - **Date** — when the eggs were collected (required).
   - **Quantity** — how many eggs (required; a whole number, zero or more).
   - **Assets** — tick the layer asset(s) the eggs came from. If only one producer
     exists, it is selected for you automatically.
   - **Notes** — optional rich‑text notes.
4. **Submit.** Farm Eggs creates a farmOS **harvest log** recording a `count` quantity
   in *egg(s)* units, linked to the chosen assets, and copies those assets' current
   locations onto the log.

Over time these logs build a per‑asset record of egg production for flock‑productivity
reporting, feeding farmOS dashboards and views. The focused form keeps daily entry
quick — handy on mobile in the field.
