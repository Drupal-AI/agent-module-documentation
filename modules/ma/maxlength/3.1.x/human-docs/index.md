# MaxLength — manual setup guide

**MaxLength** (`maxlength`) adds a character limit and a live "characters remaining"
countdown to titles, text fields, and link‑field titles. Instead of letting authors
discover a length problem only after they hit *Save* and get a validation error, it
gives immediate feedback as they type — a running counter under the field that
counts down toward the limit you set.

It supports two modes. A **soft limit** simply shows a negative count once the author
types past the maximum, nudging them to trim without blocking anything. A **hard
limit** physically prevents typing beyond the maximum. It works on plain string
fields, formatted (CKEditor 5) text fields, the summary of text‑with‑summary fields,
and the title of Link fields, and the countdown message is a small template where
`@limit`, `@remaining`, and `@count` are substituted live. MaxLength has no
dependencies beyond Drupal core.

There is **no site‑wide settings page** and no permissions of its own — the whole
feature lives on the field widget. You turn it on per field, on a content type's
**Manage form display** screen, by opening a widget's settings and entering a maximum
length. Those settings are stored as widget third‑party settings, so they export
cleanly with your form‑display configuration and deploy like any other config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set a character limit and countdown
   message on a field widget, field by field.

## Where it lives in the admin menu

MaxLength has no menu entry of its own. You configure it wherever you manage a
field's editing form: **Structure → Content types → *[your type]* → Manage form
display** (`/admin/structure/types/manage/{type}/form-display`). Click the gear icon
on a supported field's widget and you'll find a **MaxLength Settings** section. See
[Configuration](configuration/index.md) for the details.
