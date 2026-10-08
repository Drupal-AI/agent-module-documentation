# Serial — manual setup guide

**Serial** (`serial`) adds an auto-incrementing field type to Drupal. Attach a
Serial field to a content type (or any entity bundle) and every new entity gets the
next number in sequence — 1, 2, 3, … — automatically. It is the field to reach for
when you need human-friendly running numbers that are independent of Drupal's
internal entity IDs: invoice numbers, ticket or case IDs, membership numbers,
registration numbers, certificate numbers, and similar counters.

The value is assigned by the module when the entity is saved, so editors never type
it — the field's widget is hidden ("Automatic"), and a read-only formatter displays
the number. Allocation is **atomic**: each Serial field gets its own hidden helper
table with a real database `AUTO_INCREMENT` column, so even under heavy concurrent
saves two entities can never receive the same number. Counters are kept **per
entity type + bundle + field**, which means an invoice counter on one content type
and a ticket counter on another run completely independently.

Two storage settings, chosen when you create the field, tune the behavior: a
**Starting value** (default 1 — set it to, say, 1000 to begin invoices at 1000) and
a **Start on existing entities** option that back-fills any entities the bundle
already has with serial numbers. The module depends only on core's Field module. It
has no admin settings page — all configuration lives on the field itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Serial has no central settings page. You "configure" it by adding a Serial field to
a bundle:

1. Go to the bundle's **Manage fields** (for example
   `/admin/structure/types/manage/article/fields`).
2. Click **Add field** and choose **Serial** (it appears under the *Number*
   category).
3. On the field's storage-settings step, set:
   - **Starting value** — the first serial number (default `1`; use `1000` to start
     a counter higher).
   - **Start on existing entities** — set to **Yes** to back-fill the entities the
     bundle already has with serial numbers, or **No** to number only new entities
     from now on.
   - Note that both settings are locked once the field contains data, so pick them
     before entities start being created.
4. Save the field. Its widget is **Hidden (Automatic)** — editors will not see it on
   the edit form.
5. To show the number, go to the bundle's **Manage display** and make the field
   visible; it renders read-only through the *Serial* formatter.

From then on, every new entity of that bundle is assigned the next number when it is
saved. A few things worth knowing: the value is only assigned to new entities (and
new translations); cloning a node resets its Serial field so the copy gets a fresh
number; and separate fields or bundles keep separate sequences.
