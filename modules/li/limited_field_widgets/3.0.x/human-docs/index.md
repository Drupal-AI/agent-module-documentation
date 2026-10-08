# Limited Widgets For Unlimited Fields — manual setup guide

**Limited Widgets For Unlimited Fields** (`limited_field_widgets`) adds a per-widget
**"Limit values"** setting to fields whose cardinality is *unlimited*, capping how
many values an editor can add — and enforcing that cap both in the editing form and
with a real validation constraint.

It solves a common tension. You often want a field's storage to stay flexible
(unlimited), but you don't want editors adding twenty testimonials when the design
only shows three, or attaching more paragraphs than a downstream integration
supports. This module lets you keep the field unlimited while setting a hard,
per-form-display maximum — so the same field can even have different limits on
different content types or form modes.

The limit is enforced in two places. In the UI, the widget is rewritten so editors
simply can't exceed it: the "Add another" button is hidden once the maximum is
reached, extra rows are trimmed, and a limit of 1 turns checkboxes into radios or a
multi-select into a single select. It handles special widgets too — Paragraphs, Media
Library, Inline Entity Form, File, and Select2. Behind that, an `ItemCount`
validation constraint guards the field at save time, so even programmatic saves
respect the cap.

There is no admin settings page, no permissions, and no Drush. You configure it per
widget on the entity's *Manage form display* screen, and a value of `0` means "no
limit".

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. The **"Limit values"** setting appears inside a
field widget's settings on the bundle's **Manage form display** screen (for example
`/admin/structure/types/manage/article/form-display`).

## How to use it

1. Make sure the field's **storage cardinality is Unlimited** (-1). The "Limit
   values" setting only appears for unlimited fields.
2. Go to the bundle's **Manage form display** (Structure → your content type →
   Manage form display).
3. Click the field widget's **gear/cog**. A required **"Limit values"** number field
   appears (minimum 0, where 0 means show/allow all values).
4. Enter the maximum, click **Update**, then **Save**.

From then on:

- The editing form prevents editors from adding more than the limit (the "Add
  another" button disappears at the cap; a limit of 1 becomes a single-choice
  control).
- Saving too many values fails validation with the message "Field contains too many
  values, up to N allowed." — this applies to programmatic saves as well, so your
  data stays within the cap.

The value is stored as a third-party setting on both the form-display widget and the
field config, so it travels with your exported configuration. Because it lives on the
form display, you can give the same unlimited field a different limit on each bundle
or form mode. Set it back to `0` at any time to remove the cap.
