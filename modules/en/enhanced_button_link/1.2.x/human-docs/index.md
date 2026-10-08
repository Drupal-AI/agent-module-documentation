# Enhanced Button Link — manual setup guide

**Enhanced Button Link** (`enhanced_button_link`) extends Drupal core's **Link**
field so its links can be rendered as **Bootstrap buttons**. It adds a matching
widget and formatter: on the edit form editors fill in the usual URL and title,
and on the page the link comes out as an `<a class="btn btn-primary">…</a>` (or
whatever style you configure), complete with size, disabled state, and new‑tab
options.

You control the look in two places. A **global settings form** defines the list of
button styles editors may choose from (the Bootstrap `btn-*` classes) and decides
which options editors are allowed to override per link. Then, on each Link field,
you set a default style, size, status, and target through the formatter — and, if
you've enabled the matching overrides, editors can change those on a link‑by‑link
basis right in the widget.

Because it builds on the core Link field, you keep all of core's URL validation and
internal/external link handling — you're just changing how the link is rendered.
The button classes are Bootstrap's, so the module is meant for a **Bootstrap‑based
theme**; on other themes the buttons render but won't be styled. Link titles also
support token replacement, so you can build call‑to‑action buttons from entity
data without touching templates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the global settings form (button
   styles list and override toggles), field by field.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Enhanced
Button Link** (`/admin/config/content/enhanced-button-link`). The per‑field pieces
live on each Link field's **Manage form display** (the widget) and **Manage
display** (the formatter).

## How to use it

1. Enable the module and make sure you have a Bootstrap‑based theme (see
   [Installation](installation/index.md)).
2. *(Optional)* Visit the [settings form](configuration/index.md) to curate the
   button‑style list and choose which options editors may override.
3. On the entity's **Manage display**, set your Link field's **Format** to
   **Enhanced Button Link**. Click the gear icon to pick the default **type**
   (which `btn-*` style), **size** (normal / large / small), **status**
   (enabled / disabled), and **target** (same window / new tab), plus an optional
   **inline buttons** layout.
4. On the entity's **Manage form display**, set the Link field's **Widget** to
   **Enhanced Button Link**. If you turned on any overrides in the settings form, a
   "Button Link Options" area appears in the widget so editors can override the
   default style, size, status, or target for an individual link.
5. Add or edit content, fill in the Link field, and view it — the link renders as
   a Bootstrap button.

A disabled button gets `disabled`, `aria-disabled`, and `role="button"` for
accessibility; a new‑tab button gets `target="_blank"`.
