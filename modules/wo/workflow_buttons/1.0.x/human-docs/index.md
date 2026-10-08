# Workflow buttons — manual setup guide

**Workflow buttons** (`workflow_buttons`) makes Drupal's editorial workflow
friendlier for content authors. Out of the box, Content Moderation shows editors
a **"Moderation state" dropdown** and a separate **Save** button — so publishing
means picking a state from a select list and *then* saving. This module replaces
that two‑step dance with **one button per transition**, labelled with the
transition's name. Instead of choosing "Published" and clicking Save, the editor
simply clicks **Publish** (or **Send for review**, **Archive**, and so on).

It works as a field widget for the `moderation_state` field. When applied, it
shows only the transitions the current user is actually allowed to perform,
clusters them as a tidy dropbutton in the form's action area, and pulls each
button's label straight from the workflow transition — so translating a button
is just translating its transition label. The first button (and any "publish"
transition) stays highlighted as the primary action, and a "delete" transition
renders as a red danger/trash button. The module even sets itself as the default
moderation‑state widget, so on many sites the buttons appear as soon as you
enable it.

A small global settings form lets you also show the buttons at the **top** of
long edit forms (handy with the Gin admin theme's sticky header), and a
per‑widget option can display the current moderation state in the form's sidebar.
An optional **Trash** submodule (`workflow_buttons_trash`) adds a soft‑delete
workflow that pairs naturally with these buttons.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the Trash submodule.
2. [Configuration](configuration/index.md) — turn the widget on for a content
   type, the per‑widget option, and the global settings form.

## Where it lives in the admin menu

- The global settings form sits at **Configuration → Workflow → Workflow
  buttons** (`/admin/config/workflow/workflow-buttons`).
- The widget itself is turned on per content type from **Manage form display**
  (*Structure → Content types → [type] → Manage form display*).

## How to use it

The module only affects content that is already under **Content Moderation** —
the buttons are built from a moderation workflow's transitions, so a bundle must
be assigned to a workflow first. Once that is in place, set the **Moderation
state** field's widget to **Workflow buttons** on the bundle's *Manage form
display* (it is often already the default). From then on, editors see the
workflow actions as buttons on the edit form instead of a dropdown plus Save.
