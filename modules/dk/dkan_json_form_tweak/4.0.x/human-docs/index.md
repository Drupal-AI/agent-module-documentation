# DKAN JSON Form Tweaks — manual setup guide

**DKAN JSON Form Tweaks** (`dkan_json_form_tweak`) makes DKAN's large metadata
forms — the ones generated from a JSON schema by the JSON Form Widget — easier to
work with. When a dataset schema has many properties, or properties that hold long
lists of repeated values, the edit form becomes a lot to scroll through. This
module adds opt‑in usability features to tame that:

- A **navigation panel** that lets editors jump straight to any property in a big
  schema.
- A **close button** for multi‑value properties that collapses all their open
  detail elements at once, for a cleaner overview.
- A **per‑value remove** checkbox so an editor can delete a single item from a
  multi‑value property.

It also adds template suggestions that make the JSON‑form‑generated elements
easier to identify and theme. Technically, it decorates several JSON Form Widget
services (the builder, router, schema‑UI handler and value handler) and stores the
feature toggles as third‑party settings on the entity form display — so you turn
the tweaks on per content type, and the settings are exportable configuration.

It's an editorial/UX enhancement only: no routes, no permissions, no public
endpoints, and no patching of DKAN core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside DKAN and the JSON Form Widget.
2. [Configuration](configuration/index.md) — turning the navigation, close‑all and
   remove features on for a content type.

## Where it lives in the admin menu

There's no standalone settings page. You enable the tweaks on the **form display**
of the DKAN content type — for example the *data* type's **Manage form display**
tab under **Structure → Content types**. See
[Configuration](configuration/index.md) for the walkthrough.
