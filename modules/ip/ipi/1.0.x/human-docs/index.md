# IPI (Improve Paragraphs) — manual setup guide

**IPI (Improve Paragraphs)** (`ipi`) is an editor-experience helper that makes
working with **Paragraphs** — especially the *Paragraphs Library* and the
*Paragraphs Browser* — far less frustrating. Its headline feature is letting you
**scope which paragraph types** appear in the paragraphs browser, so editors only
see the handful of components that make sense for a given field instead of the
entire list. You can set that scope in two places: on the entity reference
revisions field itself, or on the paragraph type.

Alongside scoping, it adds several quality-of-life touches for library items: a
pink background so library paragraphs are easy to spot at a glance, and the
ability to **add and edit library items inside modals** without leaving the entity
browser. If you use the `field_config_cardinality` module, IPI declares the
widgets it is compatible with.

It sits on top of Paragraphs, Paragraphs Library, Paragraphs Browser and Entity
Browser, so it only makes sense on a site already using those. It has no content
or access-control role of its own — it purely improves the authoring UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, apply the
   required patches, and import the shipped configuration.

There is **no standalone settings form** for IPI. You manage paragraph scope on
your fields and paragraph types, described in "How to use it" below.

## Where it lives in the admin menu

IPI adds no admin configuration page of its own. Its scoping controls appear
where you already edit Paragraphs: on each **entity reference revisions
(Paragraphs) field's settings**, and on the **paragraph type** edit form. The
enhanced library editing shows up wherever the paragraphs browser and entity
browser are used.

## How to use it

1. Decide where you want to limit which paragraph types editors can pick. On a
   **Paragraphs field**, open the field's settings and choose the allowed scope;
   or set the scope on the **paragraph type** itself.
2. When editors open the paragraphs browser on that field, they now see only the
   in-scope paragraph types.
3. Library paragraphs are highlighted with a pink background, and editors can add
   or edit a library item directly in a modal without navigating away.

> **Important:** IPI is not purely a "enable and go" module. As the maintainer
> notes, you must **import one configuration file manually** and **apply patches**
> to Paragraphs Browser and to Drupal core before using it. Read the module's
> `README` first, and see [Installation](installation/index.md) for where these
> steps fit.
