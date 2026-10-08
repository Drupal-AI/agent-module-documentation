# Entity Browser — manual setup guide

**Entity Browser** (`entity_browser`) is a framework for building reusable
"browsers" — pickers that let editors search, browse, upload, or create entities
(files, media, nodes, taxonomy terms, any entity type) and hand the selection back
to a reference field or a rich-text embed. If you've ever wanted an image field to
open a modal grid of existing media instead of a plain autocomplete box, this is
the module that makes that possible.

Each browser is a configuration entity you assemble from pluggable parts: one or
more **widgets** (a Views listing, a file upload, an inline entity form), a
**widget selector** (tabs, a dropdown, or a single widget) to switch between them,
a **selection display** that shows and reorders chosen items, and a **display**
plugin that decides how the browser opens — inline, in a modal, in an iframe, or as
a standalone page. Once built, a browser is wired into content through the
module's entity-reference and file field widgets, or embedded in custom code.

Entity Browser is a foundational building block behind many media and
reference-heavy editorial workflows, so it's often installed as a dependency of
other modules rather than used entirely on its own. It has **no third‑party
dependencies**. Two submodules extend it: an **Example** module with ready-made
browsers to learn from, and **Entity Browser IEF** (`entity_browser_entity_form`),
which integrates Inline Entity Form so editors can create referenced entities right
inside the browser. It pairs well with the optional Token, Inline Entity Form, and
Entity Embed modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — create a browser from its widgets,
   selector, selection display, and display plugin, then attach it to a field.

## Where it lives in the admin menu

You create and manage browsers at **Configuration → Content authoring → Entity
browsers** (`/admin/config/content/entity_browser`, route
`entity.entity_browser.collection`). Attaching a browser to a field happens on that
content type's **Manage form display**. Access is controlled by the **Administer
entity browsers** permission, and each standalone browser also gets an
auto-generated per-browser access permission.

## How to use it

After enabling the module, the workflow is:

1. **Build a browser** at *Entity browsers* — choose how it opens (modal is the
   most common), which widgets supply selectable entities (typically a View that
   lists your media), how the selector switches between widgets, and how picked
   items are displayed before submission.
2. **Attach it to a field** — on a content type's *Manage form display*, set an
   entity-reference or file field's widget to **Entity browser** and choose the
   browser you built.
3. Editors then click a button on the field, the browser opens, they select or
   upload entities, and the chosen items return to the field.
