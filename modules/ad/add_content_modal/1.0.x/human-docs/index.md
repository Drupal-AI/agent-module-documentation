# Manage content modal — manual setup guide

**Manage content modal** (`add_content_modal`) changes how editors add and manage
nodes: instead of a full page reload, the **Add**, **Edit**, **Delete**, and
**Translate** actions for the content types you choose open inside a Drupal
**modal** (a pop-up dialog) or an **off-canvas** panel that slides in from the
side. The rest of the page stays where it is, so an editor working through a list
of content can add or fix a node and drop straight back to what they were doing.

It works by upgrading the relevant links, tabs, action buttons, and operation
links so they use Drupal's AJAX dialog system. You decide which content types get
this treatment and whether they open as a modal or off-canvas, and you can set how
wide the dialog is. Nothing about who can access what changes — Drupal's normal
form and entity access checks still apply; this is purely a convenience layer on
top.

Because it only affects the content types you list, you can roll it out to a busy
content type (say, *Article*) where editors add items constantly, while leaving
everything else with the standard full-page forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — pick the dialog type, width, and the
   content types that should open in a pop-up.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Content authoring → Manage content
modal** (`/admin/config/content/add-content-modal`). You need the **Manage
add_content_modal settings** permission to open it (an administrator has it by
default).
