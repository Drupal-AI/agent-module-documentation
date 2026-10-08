# Mercury Editor Task — manual setup guide

**Mercury Editor Task** (`mercury_editor_task`) adds a dedicated **Mercury Editor**
task — a tab — to node pages, giving editors a predictable, consistent place to open
the [Mercury Editor](https://www.drupal.org/project/mercury_editor) page‑building
experience. Instead of the builder being tangled into the ordinary node edit form,
it lives at its own route (`/node/{node}/mercury-editor`) and appears as a tab
beside the canonical node view, so content teams always know where to go to lay out
a page.

Behind that tab, the module tidies up the editing experience: on the Mercury Editor
route it hides the raw Layout Paragraphs builder widget so editing happens through
Mercury Editor rather than the default widget, integrates with inline entity forms,
and keeps content‑translation routes aligned so translators get the task too. A
settings form lets a site builder tune how the task behaves — the label shown for
the tab, and which fields, field groups, and components appear through the dedicated
Mercury Editor form mode.

This is an admin/editor‑facing companion to Mercury Editor (a hard dependency) with
no anonymous or public endpoints: the settings form requires **Administer site
configuration**, and the per‑node editor route defers to normal node‑edit access.
It targets Drupal 10.3 or 11. Note that the module is described upstream as a
proof‑of‑concept scoped to **nodes**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Mercury Editor.
2. [Configuration](configuration/index.md) — set the task label and choose what the
   dedicated Mercury Editor form mode shows.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Mercury Editor →
Task** (`/admin/config/content/mercury-editor/task`). The editing experience itself
appears as a **Mercury Editor** tab on individual nodes, at
`/node/{node}/mercury-editor`.
