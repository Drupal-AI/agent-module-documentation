# Views Reference Field — manual setup guide

**Views Reference Field** (`viewsreference`) lets editors embed a View anywhere a
field can go. It adds a new field type — a "Views reference" — that extends core's
entity reference so that, instead of pointing at a node or a term, the field points
at a **View plus a display**. Add that field to a content type, block, or
paragraph, and an editor can pick which View appears and where, then the module
renders it inline.

Out of the box Drupal can only embed a View through a Views block or a
hand‑placed block, which is rigid for editorial layouts. Views Reference makes a
View a first‑class field value: editors select a View and display through an
autocomplete widget, and the field stores the chosen View, its display id, and a
small blob of per‑instance settings. This means a landing‑page builder can assemble
sections from reusable Views, a "related content" region can be editor‑driven, and
the same View can be reused across many entities with a different argument each
time.

Which extra controls editors get per embed is configurable through
**ViewsReferenceSetting** plugins. The module ships plugins for contextual filter
**arguments** (token‑aware, so an argument can derive from the current node), a
**title** override, a custom **header**, and **pager**, **limit**, and **offset**
overrides — and developers can add their own. Site builders decide which View
display types are selectable, can preselect an allow‑list of Views, and toggle
which of these controls appear. A lazy‑builder formatter is available to keep the
host entity's cache tags clean.

Views Reference works the moment you enable it — it depends only on core's **Views**
module and needs no external libraries or submodules. There is nothing to configure
globally; all the setup happens on the field itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — adding the field, choosing the widget
   and formatter, and the per‑field settings that control what editors can do.

## Where it lives in the admin menu

Views Reference has **no central settings page** — everything is configured on the
field you add. You create the field on an entity's **Manage fields** tab (for
example a content type at *Structure → Content types → … → Manage fields*), tune its
behavior in the field settings, choose its editing widget on **Manage form
display**, and choose how it renders on **Manage display**. From then on, editors
simply pick a View when they create or edit content.
