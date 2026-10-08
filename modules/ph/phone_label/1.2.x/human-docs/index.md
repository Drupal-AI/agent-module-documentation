# Phone Label — manual setup guide

**Phone Label** (`phone_label`) extends Drupal core's telephone field with an
optional **label** stored right alongside the number. Core's telephone field stores
a number and nothing else, so the moment a contact has two numbers — a switchboard
and a direct line, or a daytime and an out‑of‑hours number — the display becomes
ambiguous. Phone Label lets you attach a short label to each number, so
"+44 20 7946 0958" can be shown as "Reception".

It does this by providing a complete field type: a **Labelled Telephone Number**
field type (built on core's telephone item, with a label property added), a widget
with both a number input and a label input, and a formatter that renders the label
together with the number. There is no separate settings page — you set it up simply
by adding a field of this type. It depends on core's Telephone module.

One thing to plan for up front: because this is a distinct field type rather than a
setting bolted onto core's telephone field, **you cannot convert an existing
telephone field in place**. Switching an existing field means adding a new
Labelled Telephone field and migrating the values across, so it is best to choose
this field type before content exists — or budget for the migration if it does.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
use it entirely by adding a field, described in "How to use it" below.

## How to use it

Phone Label adds a field type, so you work with it from the Field UI:

1. Go to **Structure → Content types → *(your type)* → Manage fields** (or the
   Manage fields screen of any fieldable entity — a user, taxonomy term, and so on).
2. Click **Create a new field** and choose the **Labelled Telephone Number** field
   type.
3. Configure the field as usual and save. On the entity's edit form the widget now
   shows both a **number** input and an optional **label** input.
4. On **Manage display**, the field's formatter renders the label together with the
   number, so labelled numbers like "Reception: +44 20 7946 0958" appear on the
   rendered page.

The label is always optional, and the underlying number still benefits from core's
telephone validation.
