# Hierarchical Select Ajax — manual setup guide

**Hierarchical Select Ajax** (`hierarchical_select_ajax`) gives you an
AJAX‑powered field widget for taxonomy term reference fields. Instead of a
single, sprawling drop‑down that lists every term in a vocabulary, editors pick a
term one level at a time — choose a parent, and the next select loads its
children over AJAX, and so on down the tree. It's built for deep or complex
vocabularies (think Country → State → City) where a flat list would be unwieldy.

The module loads only the terms it needs for the current selection, so the page
stays fast even when the vocabulary is large. Each level can carry its own label,
help text, and "nothing selected yet" placeholder, and you can cap how deep the
drill‑down goes. It also ships an SHS‑style *formatter* so the chosen hierarchy
can be displayed consistently on the front end. It depends only on core's
**Field** and **Taxonomy** modules.

There is no site‑wide settings page — everything is configured per field, on the
entity's *Manage form display* (for the widget) and *Manage display* (for the
formatter). So setup is quick: enable the module, then switch a term field over to
the new widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no site‑wide settings
form. You configure it directly on your field's display, described in "How to use
it" below.

## Where it lives in the admin menu

Hierarchical Select Ajax adds no admin page of its own. You use it entirely from
**Structure → Content types (or any fieldable entity) → *(bundle)* → Manage form
display**, and optionally **Manage display**.

## How to use it

1. Make sure your entity (a content type, media type, taxonomy term, etc.) has a
   **taxonomy term reference field** pointing at the vocabulary you want editors
   to choose from.
2. Go to that bundle's **Manage form display** tab.
3. For the term field, change the **Widget** to **Hierarchical select ajax**.
4. Click the cog (gear) icon beside the field to open its settings, where you can
   set the **hierarchy depth** and, per level, a **label**, **description**, and a
   custom **"No selection" placeholder** (for example, "- Select a Country -",
   "- Select a State -").
5. *(Optional)* Go to the **Manage display** tab and set the field's **Format** to
   **Hierarchical select ajax SHS** to render the selected hierarchy on the front
   end.
6. Save. When an editor now edits the entity, the term field appears as a set of
   cascading selects that fill in level by level as choices are made.
