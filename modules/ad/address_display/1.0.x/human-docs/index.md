# Address display — manual setup guide

**Address display** (`address_display`) adds a configurable field formatter, called
**Address Display**, for fields created with the Address module. Where the default
address formatter renders the whole postal address in a fixed layout, this one lets
you choose exactly which address components to show, in what order, and with what
separators between them — all without writing a custom template.

You use it on an entity's **Manage display** page, per field and per view mode. Its
settings form shows a draggable table listing every address component (organization,
address line 1/2/3, locality, postal code, country, administrative area, given name,
family name, and so on). For each component you get a **Display** checkbox, a **Glue**
field (a small separator string added after that component), and a **Weight** for
ordering. Only the ticked components are rendered, in weight order, each wrapped in a
`<span>` with helpful CSS classes; the country is shown as its full human-readable
name rather than its two-letter code.

Because the choice is per field and per view mode, you can show a compact city-and-
country line on a teaser and the full address on the full page, or hide personal name
components on a business listing — all from the same stored data. The settings are
saved as part of the view display configuration, so they export and deploy with the
rest of your site config.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including the exact settings keys and scriptable examples — read the
sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the Address module.

There is no separate settings page for this module: everything is configured on the
field's display, as described below.

## How to use it

The formatter has no admin settings page of its own — you configure it wherever you
manage a field's display:

1. Go to the bundle's **Manage display** page — for example an Article content type at
   `/admin/structure/types/manage/article/display`.
2. Find your address field and, in the **Format** column, choose **Address Display**.
3. Click the gear/cog icon to open the settings. A draggable table appears with a row
   per address component, each offering **Label**, **Display**, **Glue**, and
   **Weight**.
4. Tick the components you want to show, type a separator (such as `,` or `, `) into
   the **Glue** field where you want one, and drag the rows to set the order.
5. Click **Update**, then **Save**. The summary line reads "Display: <listed
   components>".

Repeat per view mode to give the same field different presentations in teasers, full
pages, search results, and so on. The glue string is added after every displayed
component except the last, and the country component renders as the country's full
name.

## Where it lives in the admin menu

There is no dedicated admin page. The module only appears as a **Format** option
("Address Display") on the **Manage display** page of any entity bundle that has an
Address field — for example under **Structure → Content types → (type) → Manage
display**.
