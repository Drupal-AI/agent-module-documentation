# Breadcrumb Extra Field — manual setup guide

**Breadcrumb Extra Field** (`breadcrumb_extra_field`) lets you move your site's
breadcrumb *into* an entity's content and position it wherever you like — for example
below the node title but above the body, or between two fields on a landing page.
Normally the breadcrumb lives in a fixed region defined by your theme (usually the
header). This module exposes the breadcrumb as a display "extra field" so you can drag
it into position on a bundle's **Manage display** screen, right alongside the real
fields.

Importantly, it does not reinvent the breadcrumb. When it renders, it calls Drupal's
normal breadcrumb service — so you get exactly the same trail your site already
produces, including any changes other modules make to it. You are simply relocating
that output into the content area and controlling its position per view mode.

Setup is a quick two‑step: first you tick which entity types and bundles should offer
the field on a small settings form, then you drag the **Breadcrumb** field into place
on each of those bundles' Manage display screens. The module is lightweight — it has no
field storage, no dependencies beyond core, and is themeable like any other field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the permission.

The two‑step setup (enable bundles, then place the field) is covered below.

## Where it lives in the admin menu

- The settings form is at **Configuration → System → Breadcrumb Extra Field**
  (`/admin/config/system/breadcrumb-extra-field`), gated by the **Administer
  breadcrumb extra field** permission.
- The breadcrumb field itself appears on each enabled bundle's **Manage display**
  screen (for example **Structure → Content types → [type] → Manage display**).

## How to use it

### Step 1 — Enable the field for the bundles you want

1. Go to **Configuration → System → Breadcrumb Extra Field**
   (`/admin/config/system/breadcrumb-extra-field`).
2. The form lists every entity type that can use the field, with a checkbox per
   bundle. Tick the bundles that should offer a breadcrumb field — for instance
   *Article* but not *Basic page* — and **Save**. You can enable it across several
   entity types (content types, taxonomy terms, user profiles, media) from this one
   screen.

### Step 2 — Position the breadcrumb on Manage display

1. Go to the bundle's **Manage display** — for example
   `/admin/structure/types/manage/article/display`.
2. The new **Breadcrumb** row starts in the **Disabled** section. Drag it up into the
   content area, to the weight/position you want (say, just under the title), and
   **Save**.
3. Repeat for other view modes or bundles as needed — you can show the breadcrumb in
   some view modes and hide it in others.

That's it. The entity now renders the site's normal breadcrumb inline among its
fields, wherever you dropped it. Because it is a field, your theme can style it
independently of the header breadcrumb.
