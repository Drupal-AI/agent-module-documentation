# Entity Reference Field Hints — manual setup guide

**Entity Reference Field Hints** (`entity_reference_field_hints`) shows
editor-facing helper text below an entity-reference field, telling editors what
they are allowed to select. Site builders already configure a field's allowed
target bundles; this module makes that hidden knowledge visible on the content
form, so an editor looking at "Related content", "Category", or "Featured media"
can see which kinds of item belong there.

The problem it solves is guesswork. A reference field's label rarely explains
what it accepts, and editors end up trying selections that fail or picking the
wrong type. This module displays the allowed bundles — Article, Event, Landing
Page, Image, Tags, and so on — as a hint below the field, using Drupal's
standard field-help styling. It can also show which of those bundles the current
user is actually allowed to *create*, so the guidance matches each editor's
permissions.

It supports references to content, media, taxonomy terms, users, and paragraphs
(paragraph support needs the Paragraphs module if your site uses paragraph
reference fields), and it works *with* standard Drupal reference widgets — it
does not replace the widget or change selection behaviour. Settings are
per-field, configured on the *Manage form display* page, so there is no
site-wide settings screen. It depends on core's Field module and supports Drupal
10.3, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site-wide configuration page** — hints are switched on per field
in the widget settings on *Manage form display*, described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page. You configure hints from **Structure → Content
types (or other bundles) → *(bundle)* → Manage form display**, in a supported
reference field's widget settings.

## How to use it

1. Go to the entity bundle's **Manage form display** page.
2. Find a supported entity-reference field and open its **widget settings** (the
   gear icon).
3. Tick **Show entity reference field hint**.
4. Optionally enable the **allowed bundle** hints and the **create permission**
   hints (which bundles the current user may create).
5. **Save** the form display. The hint now appears below the field on the entity
   edit form, styled like Drupal's standard field help text.
