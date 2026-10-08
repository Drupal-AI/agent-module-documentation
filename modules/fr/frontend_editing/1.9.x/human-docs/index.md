# Frontend Editing — manual setup guide

**Frontend Editing** (`frontend_editing`) lets editors change content directly on
the rendered page, instead of hunting down the entity edit form in the admin
back-end. Clicking a field (or an entity's edit control) opens that entity's form
in a **slide-in sidebar**, and when the editor saves, the content refreshes in
place via AJAX — the page never fully reloads. For pages built with
[Paragraphs](https://www.drupal.org/project/paragraphs), it also adds inline
controls to **add, move (up/down), delete, and duplicate** paragraphs right where
they sit, with an optional live preview.

You choose exactly which entity types and bundles get this treatment on an admin
form, so frontend editing is strictly opt-in per bundle. A range of UI options let
you tune the experience: sidebar vs full width, a hover highlight on editable
regions, automatic preview, a custom accent color, and a floating on/off toggle
button editors can flip per session. Five permissions separate "can use the
editor" from "can add / move / delete paragraphs", and developers get alter hooks
and access events for fine-grained control.

Frontend Editing has a **hard dependency on the `paragraphs_edit` module**, which
provides the access-checked paragraph operations it builds on. It optionally
integrates with `all_entity_preview` for previewing unsaved entities.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependency
   with Composer and enable it.
2. [Configuration](configuration/index.md) — choose editable bundles, the UI
   options, and the five permissions.

## Where it lives in the admin menu

Once enabled, Frontend Editing's settings sit under **Configuration → Frontend
editing** (`/admin/config/frontend-editing`), with sibling forms for choosing
editable **entity types and bundles** and for the **UI settings** (toggle button,
colors, filters). All three require the **Administer frontend editing** permission.
The editing controls themselves appear on the front-end pages of the bundles you
have enabled, for users who have the **Access frontend editing** permission.
