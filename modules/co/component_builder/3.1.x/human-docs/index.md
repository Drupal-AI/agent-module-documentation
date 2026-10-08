# Component Builder — manual setup guide

**Component Builder** (`component_builder`) gives site builders a drag-and-drop
way to assemble content pages from reusable **components**. Instead of a single
long body field, an editor picks components from a library and composes them into
the page directly — and because everything is saved as ordinary Drupal entities,
the result stays compatible with the rest of Drupal: Fields, Views, Search API,
multilingual, and blocks all keep working. Developers can build their own
component types by extending the module's plugin, and site admins can enable or
disable any component type they want available.

Under the hood, components are assembled with **Inline Entity Form**, so the
module depends on the **Entity API** (`entity`) and **Inline Entity Form**
(`inline_entity_form`) modules. It ships an optional **Component Builder
Toolbar** submodule (`component_builder_toolbar`) that most installations enable
alongside it. Access is governed by the module's own permissions plus normal
entity access — it has no special access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Entity API
   and Inline Entity Form dependencies, and enable the toolbar submodule.

The module's **Settings** page (Structure → Component → Settings) is where you
**activate the component types** you want to make available; you then add Component
Builder fields to a content type — described under "How to use it" below.

## Where it lives in the admin menu

Component Builder adds its component-type administration under Drupal's
configuration area, and once you have added a Component Builder field to a
content type, editing a node of that type takes you into the drag-and-drop
Builder page for composing components.

## How to use it

The typical setup follows the maintainers' own workflow:

1. Enable **Component Builder** and **Component Builder Toolbar** (see
   [Installation](installation/index.md)).
2. **Activate the component types** you want to use from the module's
   administration.
3. **Add Component Builder fields** to the content type (or other entity type)
   that should use the builder.
4. Create a piece of content of that type — you are redirected to the **Builder
   page**.
5. **Add the components** you need and arrange them; save, and the page is built
   from real, structured content.

Grant the module's permissions at **People → Permissions** to the roles that
should be able to build and manage components.
