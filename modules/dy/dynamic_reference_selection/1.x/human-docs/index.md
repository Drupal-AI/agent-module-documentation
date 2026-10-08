# Dynamic Reference Selection — manual setup guide

**Dynamic Reference Selection** (`dynamic_reference_selection`) lets you build
**dependent entity‑reference fields** — where the options in a child field are
filtered by what the user picked in a parent field. The classic examples are
*Genre → Song* or *Country → City*: choose a genre and the song list narrows to
songs in that genre, choose a country and the city list narrows to that country's
cities. It uses a **View** as the data source for the child field and AJAX to
refresh the options the moment the parent selection changes.

It's a deliberately small, focused module — a clean, modern fork of the reference
plugin that used to live inside the (now unmaintained) Business Rules module,
without dragging in a whole rules engine. If you've looked at Dependent Field or
Dependant Reference Method and found them unmaintained or not Drupal‑11‑ready, this
is a lighter, current alternative. It depends only on Drupal core (plus Views,
which core provides).

There is **no central settings page**. You set everything up on the child
reference field itself, in *Manage fields*, by choosing "Dynamic Reference
Selection" as the field's reference method and pointing it at a View. That
per‑field setup is described under "How to use it" below.

One thing to understand clearly: this handler is a **UI convenience, not a security
boundary.** Narrowing the visible options helps editors pick the right thing, but a
determined user could still craft a request referencing an entity the handler would
have hidden. If some entities must genuinely be off‑limits, enforce that with
Drupal's **entity access** system, not with this selection filter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
Setup happens per field, described below.

## How to use it

The pattern is a parent reference field and a child reference field on the same
entity, with a View that filters the child by the parent's value:

1. Create the **parent** and **child** entity‑reference fields (for example
   *Genre* and *Song*). Both must use the **Select list** widget in the form
   display — the dynamic filtering relies on it.
2. Create a **View** of the child entity (for example songs) that has a
   **contextual filter** for the property that ties it to the parent (for example
   the genre ID or UUID).
3. In the **child field's settings** (*Manage fields → (the field) → field
   settings*), set the **reference method** to **Dynamic Reference Selection**.
4. Choose the View you created and **map the parent field as the argument** passed
   to the View's contextual filter.
5. Save. Now, when an editor changes the parent selection, AJAX re‑runs the View
   and refreshes the child field's options to match.

> **Reminder:** confirm the filtered list is producing exactly what you expect on
> your site, and remember to back real restrictions with entity access rather than
> relying on the narrowed options alone.
