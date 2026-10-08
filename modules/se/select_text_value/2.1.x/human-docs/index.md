# Select Text Value — manual setup guide

**Select Text Value** (`select_text_value`) adds field widgets that let editors
pick a plain-text field's value from a fixed list — as a dropdown, radio buttons,
or checkboxes — instead of typing free text. As a site builder you define the
allowed values on the field's form display; editors then just choose from them.
An optional "Other" option can reveal the normal text input so someone can still
type a custom value when they need to.

The neat thing is that it does this **without changing your field type or its
stored data**. It works on core text fields (`string`, `string_long`, `text`,
`text_long`), and it stores exactly what core would store — no key/label mapping,
no extra tables. That makes it perfect for tidying up an existing free-text field
into a guided select UI without a data migration, or for constraining input to a
vetted list to cut down on typos, while keeping the field a string type for
whatever downstream integration expects it.

The module ships four widgets (one per supported field type), has no settings page
or permissions of its own, and no dependencies outside core. You configure it
entirely on the field's **Manage form display** page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

There's no configuration page. You use it on a content type's (or any entity
bundle's) **Manage form display** page — for example
`/admin/structure/types/manage/article/form-display` — by switching a text field's
widget to **Select text value**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the bundle's **Manage form display** (e.g.
   **Structure → Content types → Article → Manage form display**).
3. On the row for your text field, change the **Widget** to **Select text value**.
4. Click the widget's **cog** to configure it, then set:
   - **Select type** — *Select* (dropdown), *Radio Buttons*, or *Checkboxes*.
     (Checkboxes are only offered when the field allows more than one value.)
   - **Allowed values** — the options, **one per line**. A plain line is used as
     both the stored value and the shown label. (`key|label` pairs are parsed too,
     but because the value is stored verbatim as normal text, plain one-per-line
     entries are recommended.)
   - **Custom value label** — the text of the "Other" option (default **Other**).
     Selecting it reveals the original text input so an editor can type any value.
     **Leave this empty to lock editors to the allowed list** with no free entry.
   - Optionally a **title** and **description** for that free-text input.
5. **Update**, then **Save**.

At edit time the widget shows your select/radios/checkboxes. If a stored value
matches an allowed value it's pre-selected; a value that doesn't match selects
"Other" and pre-fills the text box. Everything is saved back in the field's normal
storage format.

The whole configuration lives in the form-display config
(`core.entity_form_display.<entity>.<bundle>.<mode>`), so you can export and deploy
it, and even apply a different allowed-values list per form mode. To script it, see
the widget settings reference in the agent docs
([`agent/configure/widgets.md`](../agent/configure/widgets.md)).
