# Reference Value Pair — manual setup guide

**Reference Value Pair** (`reference_value_pair`) provides a field type that
stores an **entity reference and a value together** in a single field delta. It's
the right shape whenever you need to record something *about* a reference — "this
ingredient, this quantity", "this skill, this rating", "50 liters", "80 %" — where
the value is a simple text value and the reference points at any entity (very
often a taxonomy term).

A plain entity-reference field can't carry data alongside the reference, so people
usually reach for a Paragraph per row or a dedicated entity with two fields. Both
work, but both are heavy: they add entity types, forms, permissions and joins for
what is conceptually just a pair. This module makes the pair a single field type,
so the reference and its value live side by side in one field. It integrates with
**Views** (you can filter and sort on *either* half) and provides a **Feeds**
target so pairs can be imported.

Be honest about the trade-off before you choose it: the value side is a **scalar
text value, not a fielded entity**. That means it cannot be translated
independently of the reference, carries no fields of its own, and cannot be
extended later without a data migration. Where those limits are acceptable, this
is markedly simpler than a Paragraph or a custom entity — and unlike storing two
parallel multi-value fields, the two halves can never drift out of alignment.

It depends only on core's **Field** module. There is no settings page, no
permission and no route — you configure everything through the standard Field UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
Everything is set up on the field itself, described in "How to use it" below.

## Where it lives in the admin menu

Reference Value Pair adds no admin page of its own. You use it entirely from
**Structure → Content types (or any entity bundle) → Manage fields**, where the
**Reference Value Pair** field type becomes available once the module is enabled.

## How to use it

1. Go to the bundle you want the field on — for example **Structure → Content
   types → Recipe → Manage fields** — and click **Create a new field**.
2. Choose the **Reference Value Pair** field type.
3. In the field settings, pick which **target entity type** and **bundle(s)** the
   reference points at (for example a "Units" taxonomy vocabulary).
4. On **Manage form display**, the widget presents two inputs per value: the
   reference selector and the free-text value.
5. On **Manage display**, choose the formatter to render each pair. The output can
   be themed by overriding the `reference-value-pair-formatter.html.twig`
   template.

Because both halves are exposed to Views, you can build listings that filter or
sort on the value as well as the reference — for example, "recipes that use more
than 200 g of flour" — which is usually the deciding advantage over two separate
multi-value fields.
