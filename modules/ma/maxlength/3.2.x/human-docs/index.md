# MaxLength — manual setup guide

**MaxLength** (`maxlength`) puts a character limit and a live "characters
remaining" countdown on titles, text fields, and link-field titles. As an author
types, a small counter shows how much room is left, encouraging concise content and
preventing overly long values — great for keeping node titles, teasers, and
meta-description-style fields within a design or SEO budget.

It offers two modes. A **soft limit** simply shows a negative count once the author
types past the maximum (a gentle nudge that doesn't block anything), while a **hard
limit** physically prevents typing beyond the limit. The countdown message is a
short template where `@limit`, `@remaining`, and `@count` are substituted live via
JavaScript. MaxLength works on plain string fields, formatted (CKEditor 5) text
fields, the summary of text-with-summary fields, and the title of Link fields.

The key thing to understand is that MaxLength has **no admin settings page and no
permissions of its own** — the whole feature lives on the field widget. You
configure a limit by opening a widget's settings on a content type's *Manage form
display* screen. Settings are stored as the widget's third-party settings, so they
export cleanly with your form-display configuration. It depends only on Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
set limits per field on the *Manage form display* screen, described in "How to use
it" below.

## Where it lives in the admin menu

MaxLength adds no admin page. You use it entirely from **Structure → Content types
→ *(type)* → Manage form display** — open a field widget's settings (the gear
icon) and you'll find a **MaxLength** section. A summary of the active limit is then
shown for that widget on the Manage form display overview.

## How to use it

1. Go to the content type (or other fieldable entity) whose field you want to
   limit, and open **Manage form display**.
2. Click the **gear icon** on the field's row to reveal its widget settings.
3. In the **MaxLength** settings, enter the **maximum number of characters** and,
   optionally, a custom **countdown message** (use `@limit`, `@remaining`, and
   `@count` as placeholders).
4. Choose whether the limit is **soft** (shows an over-count but allows typing) or
   **hard** (blocks typing past the maximum).
5. Click **Update**, then **Save** the form display.

Now, when an editor opens the content form, that field shows a live "characters
remaining" countdown as they type. You can set different limits on the same field
in different form modes, and standardize limits across content types by deploying
the exported form-display configuration.
