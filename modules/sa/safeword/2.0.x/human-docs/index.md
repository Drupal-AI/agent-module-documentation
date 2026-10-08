# Safeword — manual setup guide

**Safeword** (`safeword`) provides a custom field type that stores two versions of
a string at once: a human-friendly **Name** and a matching machine-readable
**Machine name**. It is the same "Name / Machine name" pairing Drupal uses in many
of its own forms, packaged as a reusable field you can add to any content type or
vocabulary.

The idea is that it is often useful to keep a friendly label alongside a stable,
normalized identifier — the kind of value that is safe to use in database queries,
URLs, PathAuto aliases or exposed Views arguments. As an editor types the name,
Safeword shows the matching machine name beside it and converts it automatically to
the machine-name format; clicking **Edit** lets you hand-tune that machine part in
its own field.

A common reason to reach for Safeword: rather than giving editors the broad "Create
and edit URL aliases" permission, you give them a Safeword field that uses the node
title as its source. That lets them edit only a limited part of a path while the
rest — the parts your site's features may depend on — stays safe.

Safeword works as a field you add and configure per field instance; there is no
global settings form to fill in. It depends on core's **Field** and **Text**
modules, supports **Drupal 11**, and has no submodules or third-party libraries.

This guide is written for a **human** working in the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable.

## How to use it

Safeword adds a new field type, so you use it the way you add any field:

1. Go to the **Manage fields** screen of the content type, vocabulary or other
   entity bundle you want it on (for example
   **Structure → Content types → *your type* → Manage fields**).
2. Add a new field and choose the **Safeword** field type.
3. On the field's settings, configure how the machine name is produced. Per the
   module's own feature list, Safeword can:
   - use the node **Title** or the taxonomy **term name** as the source of the
     machine name, or use its **own text field** as the source;
   - show a **live preview** of the full path to the node or term while the machine
     name is being edited;
   - require machine names to be **unique** per content type or vocabulary;
   - **transliterate** accented characters (like ø, é, å, î) to Roman-letter
     equivalents, using the Transliteration module integration; and
   - strip HTML intelligently, so tags like `p` or `div` do not leak into the
     machine name.

Once the field is placed, editors see the paired Name / Machine name widget on the
edit form — type the name, and the machine name follows automatically, editable on
demand.

> **How it differs from the Machine Name module:** the Machine Name module gives you
> a field where the user types the machine name directly and it validates the
> format. Safeword instead provides a normal text field and, as text is entered,
> displays a matching machine-name field that auto-converts the text — which can
> also be hand-edited.
