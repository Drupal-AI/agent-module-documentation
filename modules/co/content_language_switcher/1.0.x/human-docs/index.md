# Content Language Switcher — manual setup guide

**Content Language Switcher** (`content_language_switcher`) improves the
day-to-day experience of translating content in Drupal. On a multilingual site,
editors normally jump between a content item's translations through a separate
**Translate** tab and the content-translation overview page. This module moves
that navigation right onto the edit form: it adds an inline language switcher in
the sidebar of the add/edit form so you can move between a content item's
translations — or jump to create a missing one — without leaving the form you are
working in.

Because the switcher now lives on the form, the module also removes the separate
**Translate** local-task tab, keeping translation navigation in one place. It
applies automatically to every translatable entity type (nodes, taxonomy terms,
media, and so on), so there is no per-type setup.

This is purely an administrative UX enhancement. It adds no routes, permissions,
or settings of its own, and it changes nothing about *who* may edit *which*
translation — access is still governed entirely by core's **Content Translation**
module, which is its only dependency. The switcher's markup is themeable through
the provided `content_language_switcher` template if you want to restyle it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm Content Translation is set up.

There is **no configuration page** for this module — it has no settings form. Once
enabled on a multilingual site with Content Translation configured, the switcher
appears on entity edit forms automatically.

## How to use it

After enabling the module, open the edit form of any translatable content item on
a multilingual site. In the form sidebar you'll see the language switcher listing
the available translation languages, with the current editing language indicated.
Click a language to edit that translation, or use it to start a translation that
does not yet exist. The old separate **Translate** tab no longer appears — its job
is now handled inline.
