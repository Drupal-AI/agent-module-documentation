# Dynamic Placeholder — manual setup guide

**Dynamic Placeholder** (`dynamic_placeholder`) is a small, focused module that
gives text inputs **rotating placeholder text** — the faint grey hint that sits
inside an empty field. Instead of a single static hint, the placeholder cycles
through a list of examples you define, one after another, at a timed interval. It's
the effect you've seen on large consumer search boxes that quietly suggest
"Search News", then "Search Events", then "Search Products" to nudge people toward
what they can look for.

The point is discoverability. A single placeholder can only show one example; a
rotating one hints at the breadth of what a field accepts, which is especially
useful on search boxes. The module is lightweight, has **no external
dependencies**, and is compatible with Drupal 10 and 11.

It works through a small settings form where you build the list of placeholder
strings and choose which inputs they apply to (via a CSS selector), plus a few
behaviour options — pause the rotation when the field is focused, randomise the
order, and add a simple transition effect between phrases. Nothing rotates until
you've configured a placeholder set and pointed it at a field, so this module
**needs a little configuration** before you see anything on the page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — build your placeholder list, target
   the right inputs, and tune the rotation behaviour.

## Where it lives in the admin menu

Dynamic Placeholder is configured from its own settings form in the admin area.
The quickest way to reach it is from the **Extend** page (`/admin/modules`): find
*Dynamic Placeholder* in the list and use its **Configure** / settings link, or
look for it under **Configuration**. See [Configuration](configuration/index.md)
for what each option does.
