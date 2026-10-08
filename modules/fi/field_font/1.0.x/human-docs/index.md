# Field Font — manual setup guide

**Field Font** (`field_font`) provides a field type that lets editors choose or
specify a **font** to apply to a piece of content. Much as the *Field CSS* module
lets you attach CSS to individual pages, Field Font lets a site builder add a font
field to any entity type so a specific node, landing page, or other entity can be
rendered in a chosen font — without touching the theme.

It is aimed at situations where typography needs to vary per item rather than
globally: a campaign landing page that wants a distinctive display face, an
article that should use a particular font, and so on. The font is attached
editorially through the field, and the module adds the font to the individual
pages that carry it.

Two things are worth keeping in mind. Access to font fields is gated by a
dedicated **Access font fields** permission, which you must grant to the roles
that should be able to use them. And because arbitrary fonts can be specified —
potentially including externally hosted font URLs — it is worth reviewing your
font‑source configuration, since external fonts carry privacy and page‑loading
implications.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the *Access font fields* permission.

There is **no site‑wide configuration page** for this module. You add and
configure a font field per entity type, described below.

## Where it lives in the admin menu

Field Font adds no central admin page. You add a font field through Field UI —
for a node field, **Structure → Content types → *(type)* → Manage fields → Add
field** — and configure its widget on **Manage form display** and its output on
**Manage display**. The **Access font fields** permission is granted at **People
→ Permissions**.

## How to use it

1. Add a new field to your entity type and choose the **Font** field type.
2. Configure how editors enter the font on **Manage form display**, and how it
   renders on **Manage display**, to suit your site.
3. At **People → Permissions**, grant **Access font fields** to the roles that
   should be able to see and use font fields.
4. Editors can then pick a font on the content edit form, and the chosen font is
   applied to that content's page.
