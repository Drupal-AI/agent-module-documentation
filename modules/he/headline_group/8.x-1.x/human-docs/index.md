# Headline Group — manual setup guide

**Headline Group** (`headline_group`) is a **field type** for composite
editorial headlines. An editorial headline is rarely a single string: a news
article often has a *kicker* (or "superhead") above it — a short label like
"Analysis" — the headline itself, and a *subhead* (or standfirst) below. Sites
usually model this as three separate fields, which works but loses the
relationship between the parts. Headline Group keeps them together as one field
with three parts:

- **Superhead** — text above the headline.
- **Headline** — the main headline.
- **Subhead** — text below the headline.

Keeping them in one field means nothing gets filled in isolation, you configure
the display once instead of three times, and a template that wants "the headline"
can render the whole group without knowing about three unrelated fields.

The real value is **correct markup**. HTML has no dedicated element for a
subheading, and the common shortcut of stacking an `<h1>` and an `<h2>` is wrong:
it makes the subhead look like a new document section, which confuses a screen
reader's heading navigation. The accepted patterns are a single heading element
containing a styled `<span>` for the secondary text, or the `<hgroup>` element
(whose specification has shifted over the years). This module gets that decision
right once in a field type instead of leaving every theme to get it wrong. Since
the exact markup is the whole point, it's worth confirming which pattern this
release emits before you commit to it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate configuration page** for this module. Its options live on
the field itself — on the field's settings and on **Manage display** — described
below.

## Where it lives in the admin menu

Headline Group adds no admin page of its own. You add and configure a Headline
Group field from **Structure → Content types (or any entity bundle) → *(your
bundle)* → Manage fields**, and set its output on the matching **Manage display**
tab.

## How to use it

1. On your content type (or other fieldable entity), go to **Manage fields → Add
   field** and choose the **Headline Group** field type. Give it a label and save.
2. In the field's settings you can control how the parts behave on the content
   entry form — for example whether the **superhead** and **subhead** fields are
   shown or hidden for editors, and whether the **headline** should *override* or
   *copy* the entity's page title. Set these to match how your editors work.
3. On **Manage display**, choose the Headline Group formatter. A formatter is
   provided that follows the recommended single-heading-with-span pattern, and
   the display settings let you set the **class names** and the **root tag** used
   in the output, so the markup fits your theme.
4. Create content: editors fill in the kicker, headline and subhead together as
   one coherent unit, and the front end renders them with correct, accessible
   heading markup.
