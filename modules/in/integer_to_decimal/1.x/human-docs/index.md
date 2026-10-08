# Integer to Decimal — manual setup guide

**Integer to Decimal** (`integer_to_decimal`) solves a specific, annoying
limitation of Drupal: once a field already holds data, core won't let you change
its type. So an integer field that turns out to need fractional values can't
simply become a decimal — the supported path is to create a new field and migrate
the data, which is a lot of disruption for such a small change.

This module lets you make that conversion **in place**, preserving the stored
values. On a node field's *Field settings* tab it adds an option to convert an
integer field (that has data) to a decimal, letting you pick the precision and
scale you want. The data is kept; you don't create a new field.

Because it rewrites field storage, it is best thought of as a **one‑off
maintenance operation, not a standing feature**. A schema change that goes wrong
is a data problem, so the sensible precautions apply: back up your database, run
the conversion deliberately (ideally in a maintenance window), verify the result,
and you can disable the module afterwards. Note that this version supports fields
on **nodes** only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. The conversion happens on the
field's own *Field settings* tab — see "How to use it" below.

## Where it lives in the admin menu

Integer to Decimal adds no admin page of its own. You use it from **Structure →
Content types → *(your content type)* → Manage fields**, on the integer field you
want to convert.

## How to use it

Once the module is enabled, convert an integer field that has data to a decimal:

1. Go to the **Manage fields** operation of the desired content type.
2. Choose **Edit** on the integer field you want to convert.
3. Open the field's **Field settings** tab. (The convert option only appears when
   the selected field actually has data associated with it.)
4. Tick **Enable integer to decimal conversion**.
5. From the drop‑downs, choose the **precision** and **scale** you want for the
   decimal field.
6. **Save field settings.**

The field becomes a decimal, keeping its existing values. Verify the converted
data before relying on it in production — and remember to take a database backup
first, since this alters field storage.
