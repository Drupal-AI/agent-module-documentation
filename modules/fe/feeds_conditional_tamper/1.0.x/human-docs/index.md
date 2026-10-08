# Feeds Conditional Tamper — manual setup guide

**Feeds Conditional Tamper** (`feeds_conditional_tamper`) extends the
[Feeds Tamper](https://www.drupal.org/project/feeds_tamper) module with two
plugins that let you conditionally drop data during a Feeds import — either
skipping an entire feed row, or clearing a single field value — based on a
condition you configure. It gives you finer control over which imported data is
actually kept.

The condition is evaluated against a source field in the feed row (or against the
value currently being tampered), so you can express rules such as "skip this item
if its status column equals *archived*" or "blank this field when the source
value is *N/A*". It's a flexible alternative to the built‑in "Required" plugin,
which only checks for empty/not‑empty.

Two plugins are provided:

- **Skip item on condition** (`skip_item_on_condition`) — when the condition is
  TRUE, the whole feed row is dropped, so no node (or other entity) is created or
  updated for that row.
- **Skip value on condition** (`skip_value_on_condition`) — when the condition is
  TRUE, only the current field value is cleared (set to empty). The rest of the
  row still imports normally, so the entity is saved with that one field left
  blank.

This is purely a Feeds/Tamper extension — it has no content of its own and no
access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Tamper and Feeds Tamper.

There is **no configuration page** for this module. Both plugins are set up on a
feed type's mapping, described in "How to use it" below.

## Where it lives in the admin menu

Feeds Conditional Tamper adds no admin page of its own. You use its plugins from
**Structure → Feed types → *(your feed type)* → Mapping**, where Feeds Tamper lets
you attach Tamper plugins to your import's sources.

## How to use it

1. On your feed type's **Mapping** tab, open the Tamper settings for the source
   you want to gate.
2. Add either **Skip item on condition** (to drop the whole row) or **Skip value
   on condition** (to blank just that field).
3. Configure the comparison — choose the source field to test and the condition
   that, when met, triggers the skip.
4. Save and run the import. Rows or values that match your condition are skipped
   according to the plugin you chose.
