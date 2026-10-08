# Webform Entity View — manual setup guide

**Webform Entity View** (`webform_entity_view`) adds a new **"Entity View"** element to
the Webform builder. Instead of collecting input, this element *displays* something: you
pick an existing entity — a node, a taxonomy term, a media item, a block, a user, almost
anything — and it is rendered inline inside your form, in whichever view mode you choose.

Think of it as a richer, themeable alternative to a plain Markup element. Rather than
pasting static HTML into the form, you point the element at a real entity and it renders
that entity's fields for you. If the entity is later edited, the form shows the updated
content automatically, because it is loaded fresh each time the form is displayed. It is
perfect for surfacing reference material — a terms-and-conditions page, an informational
image, a product summary, or onboarding text — right where people need it.

The element collects no data and stores nothing in the submission. The entity and view
mode are chosen by the form author at build time, so every visitor who reaches the form
sees the same rendered content. Because of that, only reference entities you are happy for
everyone with access to the form to see — do not use it to embed unpublished or
access-restricted content into a public form. The module depends only on the Webform
module and adds no settings pages, permissions, or Drush commands of its own.

This guide is written for a **human** building a form through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — add the "Entity View" element to a webform and
   configure which entity it displays.

## Where it lives in the admin menu

There is no central settings page. The module simply adds one new element type inside the
Webform builder, at **Structure → Webforms → (edit a webform) → Add element → Entity View**
(found under the *Entity reference elements* category). Everything you configure lives on
the element itself, saved inside that webform's own configuration.
