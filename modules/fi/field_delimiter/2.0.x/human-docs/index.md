<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Delimiter — manual setup guide

**Field Delimiter** (`field_delimiter`) lets you put a separator between the values
of a **multi-value** field when it displays. Instead of a field's values stacking
one under another, you can render them inline — taxonomy tags as a comma-separated
list, author names joined with " / ", categories separated by " | ", or values
broken onto new lines with a `<br>`.

It is a small enhancement to Drupal's existing field formatters, not a new field
type. It adds a **Field Delimiter** text box to the formatter settings (the cog)
of any multi-value field on a *Manage display* page. You type the separator you
want, and at display time the module inserts it between each value except the last.
There is no field type, widget, settings page, or Drush command of its own, and it
has no effect on single-value fields — the option only appears when a field can
hold more than one value.

The delimiter setting is stored on the display, so you can set a different
separator per view mode (a comma in a teaser, `<br>` in the full view), and it
exports with your site configuration for deployment. Simple HTML separators are
allowed (`br`, `hr`, `span`, `img`, `wbr`); anything else is stripped for safety.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no configuration page — the delimiter is set per field, on the *Manage
display* page, as described below.

## Where it lives in the admin menu

Field Delimiter has no admin page of its own. You use it on the **Manage display**
tab of a content type, user, taxonomy vocabulary, media type, or any other
fieldable bundle — for example **Structure → Content types → Article → Manage
display**.

## How to use it

1. Go to a bundle's **Manage display** page for the view mode you want to change.
2. Find a **multi-value** field (cardinality greater than one) — the option only
   appears for these.
3. Click the field's formatter **cog** (settings) icon.
4. In the **Field Delimiter** box, type your separator — for example `, ` or
   `<br>`.
5. Click **Update**, then **Save**. The formatter summary then shows "Delimited
   by: …", and the field's values render inline separated by your delimiter.
