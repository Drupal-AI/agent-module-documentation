# Custom Paragraphs — manual setup guide

**Custom Paragraphs** (`custom_paragraphs`) is a lightweight, developer-oriented
library for building **dynamic, repeatable field groups in custom forms** — the
kind of "add another item" UI where a user can add, remove, and reorder several
sets of similar inputs (multiple addresses, a list of team members, a batch of
documents). It ships a JavaScript-powered repeatable UI plus an AJAX
**file-upload widget** so each repeated group can include file attachments with a
preview. Group data is collected and stored as JSON in a hidden form field,
keeping the setup lightweight and free of the entity overhead of the core
Paragraphs module.

Despite the name, this is **not** the same thing as core/contrib **Paragraphs**
(the entity-based content component system). Custom Paragraphs is aimed at
developers hand-building custom forms: you attach its library, add a hidden data
field and a wrapper container, then initialize the repeatable group in
JavaScript. It supports several field types (text, textarea, select, file,
checkbox), CKEditor 5 rich text, client-side validation, and pre-filling existing
data. It targets **Drupal 10 and 11** and works alongside core's **Editor**
module for the CKEditor integration.

Because this is a developer library rather than a click-together feature, there is
no admin settings form — you wire it into your own forms in code. See "How to use
it" below for the shape of that integration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
integrate it in your own form code, as described below.

## How to use it

Custom Paragraphs is used from a custom form (typically in a module you write).
The integration has four moving parts:

1. **Attach the library** to your form's render array:
   `$form['#attached']['library'][] = 'custom_paragraphs/custom_paragraphs';`
2. **Add a hidden field** to store the collected data as JSON (for example a
   `hidden` element with an `id` such as `items-data`).
3. **Add a wrapper container** where the repeatable rows render (a `container`
   carrying the module's `rfg-wrapper` class and a `data-rfg-instance` attribute).
4. **Initialize it in JavaScript** using the module's `RepeatableFieldGroup`
   class, where you define which fields each row contains and how it behaves.

From there the module handles the add/remove UI, per-field validation, file
uploads, and gathering the values back into the hidden field on submit.

### The file-upload widget

File fields in the group are backed by two AJAX routes
(`/custom-paragraphs/repeatable-file-upload` and
`/custom-paragraphs/repeatable-file-restore`) that accept uploads and return
metadata about the saved files. Each file field declares its own
`upload_location`, and uploaded files are stored as permanent managed file
entities. Because this is a developer library you wire into your own forms, use it
within your site's normal authenticated editing screens and reconcile the saved
files in your form's submit handling.
