# Field Count Formatter — manual setup guide

**Field Count Formatter** (`field_count_formatter`) is a tiny, focused field
formatter. Instead of rendering a multi‑value field's contents, it simply shows
**how many** values that field holds. A gallery field with eight images renders as
`8`; a taxonomy field with three tags renders as `3`; an empty field renders as
`0`.

There's nothing to configure. The module adds a single formatter called
**Field count**, and because it declares no specific field types, it's offered for
*every* field on the **Manage display** tab. You just pick it as the format for a
field and Drupal shows the count in place of the values. It keeps the field's
label, so you can label the count however you like.

It's handy anywhere a total matters more than the items themselves — a "photos"
count on a gallery, a count of related content on a reference field, a compact
badge on a teaser, or a count column in a Views table (set the Views field's
formatter to *Field count*). It also avoids the render cost of expanding a large
multi‑value field when you only need the number.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. The formatter appears in the **Format** select on any
entity's **Manage display** tab — for example **Structure → Content types →
*(your type)* → Manage display**, or on a **Views** field's format settings.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Manage display** for the entity and field you want to summarise (for
   example a multi‑value image, taxonomy, or entity‑reference field).
3. In the **Format** column for that field, choose **Field count**.
4. Save. The field now renders the number of values it contains instead of the
   values themselves.

There are no options to set — the formatter has no settings form. To count a field
in a **View**, add the field to the view and set its formatter to **Field count**
the same way.
