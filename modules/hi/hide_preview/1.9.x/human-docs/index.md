# Hide Preview Button — manual setup guide

**Hide Preview Button** (`hide_preview`) does exactly one thing: it removes the
**Preview** button from forms you name. Despite the machine name and the project's
original description mentioning the contact form, it works on *any* form — node
edit forms, webform submissions, comment forms, media forms, and so on.

You control which forms are affected from a single settings page, where you list
form-name patterns one per line. Each pattern can be a plain text string (matched
if it appears anywhere in a form's ID) or a full regular expression (matched
against the whole form ID). When a form matches, the module strips the preview
action from all the usual places, including the ones the **Gin** admin theme uses.

This is handy for enforcing a "no preview" editorial policy, for hiding a preview
button whose rendered output is broken by another module, or for simplifying
public-facing forms where preview just adds confusion.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Hide Preview adds one settings page under **Configuration → User interface → Hide
Preview** (`/admin/config/hide_preview`), gated by the core **Administer site
configuration** permission.

## How to use it

Open the settings page and you'll find a single **Form names** textarea. Enter
**one pattern per line** (no commas), then save. For each pattern:

- If it is a valid **regular expression** — such as `/contact_message_.*/` — the
  module matches it against the whole form ID.
- Otherwise it is treated as a plain **substring** — for example
  `contact_message_` matches `contact_message_feedback_form`,
  `contact_message_personal_form`, and any other form ID containing that text.

When a form matches, Hide Preview removes the preview button from the standard
locations (`actions.preview`, the "Preview draft" variant `actions.preview_draft`)
and from the Gin theme's preview locations (`meta.preview` and `top.meta.preview`).

Finding the right form ID is up to you — you can read it from the form's HTML
`id` / `data-drupal-selector` attribute. Validation only rejects a line if it
contains non-word characters yet is not a compilable regular expression; plain
words and valid regexes both pass. A few worked examples:

- Hide preview on all contact forms: `/contact_message_.*/`
- Hide preview on one specific node form: `node_article_edit`
- Hide preview site-wide: a catch-all regex that matches most form IDs.

The module has no config schema and no permissions of its own, so everything is
driven by the patterns you enter here.
