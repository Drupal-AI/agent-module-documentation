# Better Links — manual setup guide

**Better Links** (`better_links`) is a replacement widget for core **Link** fields
that lets editors set a **CSS class** and a **link target** (such as `_self` or
`_blank`) on each link — so a link field can produce a styled button or a
new‑tab link without anyone writing HTML.

For each of those two things — class and target — you decide how it is applied:
you can **force** a fixed value on every link, offer editors a **curated select
list** to choose from, or allow **manual entry**. The class option list defaults to
Bootstrap‑style button classes like `btn btn-primary`, which you can customise in
the widget settings.

The result is consistent, on‑brand call‑to‑action links across your content types:
force `btn btn-primary` and `_blank` on a "Call to action" field, for example, and
every editor's link comes out styled as a button that opens in a new tab, with no
raw CSS knowledge required.

Better Links is purely a field widget — it has no routes, permissions, services,
or database tables, so there is nothing to secure. It requires core's **Link**
module and supports Drupal 8, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no site‑wide settings page — you configure Better Links per field, on the
form display:

1. Add or locate a **Link** field on your content type (or other entity).
2. Go to the entity's **Manage form display** tab and, for that link field, choose
   the **Better Link** widget in the **Widget** column.
3. Click the widget's settings gear to configure class and target. For each,
   pick the mode you want:
   - **Forced** — every link gets the same value you set here.
   - **Select from list** — editors choose from the options you define (the class
     list defaults to Bootstrap button classes, which you can edit).
   - **Manual** — editors type the value themselves.
4. **Save** the form display. Editors now get the class/target controls when they
   fill in that link field.

Configure it separately for each link field and form display where you want this
behaviour.
