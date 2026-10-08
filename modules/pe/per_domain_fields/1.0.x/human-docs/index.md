# Per Domain Fields — manual setup guide

**Per Domain Fields** (`per_domain_fields`) provides field types that store a
**different value for each domain** defined on your site. If you run a multi‑domain
Drupal site with the **Domain** module, this lets a single piece of content present
different field values depending on which domain a visitor is on — a different
title, a different image, and so on — without maintaining separate copies of the
content.

It works by defining per‑domain versions of the standard Drupal field types. They
behave exactly like their normal counterparts, with two differences: on the edit
form you enter a value **per domain** (the widget repeats once for each of your
domains), and on display only the value for the **currently active domain** is
shown. If you have ever needed "the same field, but a different value on each
domain, switched automatically by the active domain," this is the tool for that.

The values are ordinary per‑domain content and follow Drupal's normal field
handling; the module adds no access‑control behaviour of its own. All it needs is
the Domain Access module and a per‑domain field added to your entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and the Domain dependency.

There is **no configuration page** for this module — you use it simply by adding one
of its per‑domain field types to a content type, described in "How to use it"
below.

## Where it lives in the admin menu

Per Domain Fields adds no settings page. You use it when adding a field, from
**Structure → Content types → *(your type)* → Manage fields → Add field**, where the
list of field types now includes the "… [Per‑domain]" variants.

## How to use it

1. Make sure the **Domain** (Domain Access) module is enabled and your domains are
   configured.
2. Go to **Structure → Content types → *(your type)* → Manage fields** and click
   **Add field**.
3. From the list of field types, choose one of the **"… [Per‑domain]"** fields
   (these mirror the standard field types).
4. Finish adding the field as usual, then edit some content: you'll see the field's
   widget **repeated once for each domain**, so you can enter a distinct value per
   domain.
5. View the content on different domains — only the value for the **active domain**
   is displayed on each.
