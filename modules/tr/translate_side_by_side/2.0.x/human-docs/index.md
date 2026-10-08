# Translate Side by Side — manual setup guide

**Translate Side by Side** (`translate_side_by_side`) gives you a single admin
report that lists your menus, nodes, blocks, and taxonomy terms with each
translatable field shown in two columns — a **source language** and a **target
language**, side by side. It is a ready-made translation template and overview:
hand it to a translator or agency as a worklist, or use it yourself to review how
complete a translation is.

You choose the source and target languages, optionally filter to specific content
types, and load the report. The module then walks each translatable field —
including text and string fields, image alt and title text, file descriptions,
link titles, and even fields nested inside **paragraphs** — and shows the source
value next to the target value. Two options make it easier to read: you can skip
fields that are empty in the source to reduce noise, and you can fill untranslated
target cells with the source value to highlight the gaps.

It is important to know that this is a **read-only reporting aid**. It shows source
and target values together so you can plan or review translation work — it does
**not** write or edit translations itself. It pairs well with an external
translation or review workflow, or as a lightweight translation-status view when
you don't need a full translation-management system.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — open the report, choose languages,
   and set the options.

## Where it lives in the admin menu

The report is at **Reports → Translate Side by Side**
(`/admin/reports/translate_side_by_side`). It requires the **Administer site
configuration** permission.

## How to use it

1. Make sure your site is multilingual with content translation enabled and at
   least two languages configured.
2. Go to **Reports → Translate Side by Side**.
3. Pick a **source** and **target** language, optionally filter by content type,
   and choose the display options.
4. Click **Load** to build the side-by-side tables.
