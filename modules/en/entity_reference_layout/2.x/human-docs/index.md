# Entity Reference with Layout — manual setup guide

**Entity Reference with Layout** (`entity_reference_layout`), often shortened to
"ERL", is a "paragraphs + layout" field. It gives content authors a special
entity-reference field whose edit widget lets them drag and drop referenced
paragraphs into visual layout sections and regions — one column, two columns,
three columns, and so on — rendered through Drupal core's Layout Discovery
layouts. In short, it turns a stack of paragraphs into a structured,
multi-column page without Layout Builder.

You start by adding a **Paragraph with Layout** field to a content type. In the
edit form the author adds "Section" paragraphs (each mapped to a layout), then
drops content paragraphs into the layout's named regions (header, primary,
secondary, footer, and so on). Each section can carry its own container CSS
classes and a background color, and unused paragraphs can be parked in a
"Disabled items" area instead of being deleted. On the rendered page the module
rebuilds that section-region-paragraph tree and renders it with the chosen
layout's markup.

Please note this is an **experimental development release** (the 2.x branch ships
with `minimum-stability: dev`). The maintainers advise heavy testing before you
rely on it in production, and the closely related **Layout Paragraphs** module
has largely superseded it for new sites — weigh that before starting fresh.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Paragraphs
   dependency with Composer, enable it, and pick the optional submodules.
2. [Configuration](configuration/index.md) — add the field to a content type,
   the global settings form, and the per-section layout options.

## Where it lives in the admin menu

There is no single dashboard for ERL. You do most of the work in two places:

- **The field** — added on a content type at *Structure → Content types →
  (your type) → Manage fields*, then arranged on *Manage form display* and
  *Manage display*.
- **The global settings form** — *Configuration → Content authoring → Entity
  reference layout* (`/admin/config/content/entity_reference_layout`), which
  only toggles whether paragraph-type and layout labels show in the widget.

## How to use it

Once the field is on a content type, editing a node of that type shows the ERL
widget: an author clicks **Add Section**, picks a layout for that section, and
then drags content paragraphs into the layout's regions. A single permission,
**Manage entity reference layout sections**, controls whether the *Add Section*
buttons appear — grant it to the roles that should be allowed to build layouts.
Editors without it can still edit paragraphs inside existing sections but cannot
add new ones. See [Configuration](configuration/index.md) for the step-by-step
field setup.
