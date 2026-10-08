# Reenable Number Float — manual setup guide

**Reenable Number Float** (`reenable_number_float`) restores the **Number
(float)** and **List (float)** field types to the Field UI on Drupal 11. In Drupal
11.2 core hid the Number (float) field type so it can no longer be added to content
types through the interface; the core recommendation is to use **Number
(decimal)** instead. Unfortunately the decimal field type has had a long‑standing
bug that, for many sites, makes it impractical — so if you can't or won't patch
core after every update, float remains the pragmatic choice. This tiny module
exists exactly for that situation.

When enabled, it puts **Number (float)** and **List (float)** back in the "Add a
new field" chooser (**Structure → Content types → *(your type)* → Manage
fields**). There is nothing to configure — the field types simply become available
again. If you later disable the module, the types disappear from the "Add new
field" interface, but **any float fields you already created stay intact and are
not deleted**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Enabling it is the whole
setup.

## Where it lives in the admin menu

The module adds no admin page. Its effect appears in the **Add a new field**
dialog under **Structure → Content types → *(your type)* → Manage fields**, where
**Number (float)** and **List (float)** become selectable again.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types → *(your type)* → Manage fields → Add
   field**.
3. Choose **Number (float)** or **List (float)** — they're now available with no
   further configuration.

> **A word of caution:** float is an approximate numeric type. For values that
> must be exact (money, for instance), prefer Number (decimal) where you can. Use
> float knowingly, for the cases where it genuinely fits.
