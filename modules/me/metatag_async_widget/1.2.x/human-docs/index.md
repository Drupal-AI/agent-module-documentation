# Metatag Async Widget — manual setup guide

**Metatag Async Widget** (`metatag_async_widget`) is a small performance helper for the
**Metatag** module. A Metatag field renders a very large form — dozens upon dozens of
meta‑tag fields — and that whole tree is normally built every time an editor opens an
entity edit form, even if they never touch the SEO settings. This module replaces the
standard Metatag widget with an *asynchronous* one that shows just a **"Customize meta
tags"** button at first, and only builds the full meta‑tags form (via AJAX) when the
editor actually clicks it. The result is noticeably faster edit forms.

Just as importantly, it is safe: if an editor saves without expanding the form, the
widget quietly preserves the entity's existing meta tags — nothing is lost, and defaults
keep being inherited. The heavy form is built only for the editors who genuinely need to
edit SEO tags.

You enable it per field, on an entity's **Manage form display** — there is **no settings
page, no permissions, and no Drush**. It provides a single field widget,
`metatag_async_widget_firehose` ("Advanced meta tags form (async)"), that works on any
`metatag` field, on any entity type (nodes, terms, media, custom entities). It depends on
the **Metatag** module (v1 or v2) and works on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

There is no admin page. You choose the widget under **Structure → (your content type) →
Manage form display** (`/admin/structure/types/manage/{type}/form-display`), on the row
for your Metatag field.

## How to use it

1. Make sure the bundle already has a **Metatag field** (Metatag fields are added via the
   Metatag module — bundles don't have one by default).
2. Go to that entity's **Manage form display**.
3. Find the Metatag field and change its **Widget** to **Advanced meta tags form
   (async)**.
4. Optionally open the widget's settings (the cog) — the one option, **sidebar**
   (inherited from Metatag's own firehose widget), controls whether the form joins the
   node edit form's "advanced" sidebar group.
5. Click **Update**, then **Save**.

From now on, editors of that entity see a lightweight "Customize meta tags" button
instead of the full form, and only expand it when they need to. Because the change lives
in the form‑display config (the field's widget becomes
`type: metatag_async_widget_firehose`), you can export and deploy it like any other
configuration, and it changes no stored data — a safe migration for existing Metatag
fields.
