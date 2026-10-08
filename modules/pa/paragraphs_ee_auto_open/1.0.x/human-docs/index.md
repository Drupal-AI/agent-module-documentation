# Paragraphs EE Auto Open — manual setup guide

**Paragraphs EE Auto Open** (`paragraphs_ee_auto_open`) is a small editorial‑UX
enhancement for sites that use
[Paragraphs EE](https://www.drupal.org/project/paragraphs_ee) (the Paragraphs
Editor Experience). When an **empty** paragraphs field loads on a create or edit
form, this module can **automatically open the Paragraphs EE type picker** — the
modal that lets editors choose which paragraph type to add — so they land straight
on the type selection instead of first having to click an "Add" button.

It is generic to Paragraphs EE: it works on any form that renders a Paragraphs
widget with the Paragraphs EE type‑picker modal, not just library‑item forms. The
behaviour is **opt‑in per field**: on the field widget's settings (under **Manage
form display**) you tick **Auto‑open EE type picker**, and only that widget is
affected — so it is safe to use on forms with several paragraph fields. It opens
only when the field uses the EE type‑picker markup and has **no paragraph items
yet**, so already‑filled or edit forms are left alone; it also retries briefly
while the Paragraphs EE modal finishes loading.

Under the hood it simply adds a CSS class (`paragraphs-ee-auto-open`) and a small
JavaScript behaviour that calls Paragraphs EE's own modal‑open function — no custom
theme JS needed. It carries no content or access role of its own.

Note that this module is **not (yet) covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module. Its single option is a
per‑widget checkbox on Manage form display, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no settings page. Its option lives on each Paragraphs field widget
at **Structure → *(entity type)* → Manage form display → *(paragraphs field
widget)* → settings**, as the **Auto‑open EE type picker** checkbox. The setting is
stored as a third‑party setting on the form display configuration
(`core.entity_form_display.*` under
`content.{field}.third_party_settings.paragraphs_ee_auto_open`), so it exports with
your config.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). Make sure the
   form already uses Paragraphs EE's type picker (modal) for the field.
2. Go to the relevant **Manage form display** — for example the *default* form
   display of a Paragraphs Library item, or any host entity that embeds a
   paragraphs field.
3. Open the paragraphs field **widget settings** (the gear icon) and tick
   **Auto‑open EE type picker on**. Save the form display.
4. Open a create form with that field empty: the Paragraphs EE type picker should
   open on its own. On edit forms, or when the field already has items, it stays
   closed.
