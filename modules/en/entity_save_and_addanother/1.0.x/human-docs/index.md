# Entity Save And Add Another — manual setup guide

**Entity Save And Add Another** (`entity_save_and_addanother`) adds a **Save and
Add Another** button to entity *add* forms. When an editor clicks it, the current
item is saved as usual, and then — instead of landing on the saved item — they are
dropped straight back onto a fresh, empty add form of the same type. It's the
familiar "save and continue" pattern from other admin frameworks, aimed at making
repetitive content entry much faster.

This is a small, zero‑configuration helper. There is no settings form, no
permissions of its own, and nothing to set up per content type: the moment you
enable the module, the extra button appears on the supported add forms. Because it
simply reuses core's own submit button and access rules, only users who already
have permission to create that entity type ever see it.

The button is added to these entity add forms out of the box: **content (nodes)**,
**media**, **taxonomy terms**, **menu links**, **custom blocks (block content)**,
and **Commerce products** (when Commerce is installed). It works for any bundle of
those types automatically, and the redirect always returns you to the same add URL
so your content type or vocabulary is preserved.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module. That's the whole setup.

## Where it lives in the admin menu

Nowhere — the module has no admin page. Its only visible effect is the extra
**Save and Add Another** button that appears in the row of action buttons at the
bottom of a supported *add* form (for example at `/node/add/article` or
`/media/add/image`). The button only shows on *add* forms, not on edit forms.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to any supported add form — for example **Content → Add content →
   Article**.
3. Fill in the fields and click **Save and Add Another**. Your item is saved and
   you're returned to a blank add form of the same type, ready for the next entry.

This is ideal for bulk‑creating taxonomy terms, media items, menu links, products,
or nodes in a single focused session, and for giving data‑entry staff a
lower‑friction workflow when populating a site by hand.
