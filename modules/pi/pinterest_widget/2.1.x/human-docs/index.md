# Pinterest Widget — manual setup guide

**Pinterest Widget** (`pinterest_widget`) is a fuller integration between Drupal and
Pinterest than a simple share button. It lets you embed rich Pinterest content —
individual **Pins**, whole **Boards**, **Profiles**, and **Follow** buttons — using
Drupal's native Block and Field systems, and it can also show a "Save" button when
visitors hover over images on selected content types.

You can place Pinterest content in three ways. As **blocks**: four block types
(Pin, Board, Profile, Follow), each with preset layouts such as Square, Sidebar, or
Header. As **fields**: custom field types, widgets, and formatters let editors embed
a specific Pin or Board per node or other entity. And as **hover "Save" buttons**:
turn these on for chosen content types so visitors can pin your images. Throughout,
you can control button size, shape, and language to match your site.

The module is security-conscious: it includes a dedicated validator that sanitises
Pinterest URLs to guard against malformed data or injection (XSS) from widget
parameters. As with any Pinterest embed, the widgets load Pinterest's third-party
scripts in the visitor's browser, so treat that as a privacy consideration and
disclose it where your policy requires.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global settings form, plus how to
   place blocks and add fields.

## Where it lives in the admin menu

The module's global settings live at **Configuration → Services → Pinterest
Widget** (`/admin/config/services/pinterest-widget`). You place widget blocks from
**Structure → Block layout**, and you add Pinterest fields from a content type's
(or other entity's) **Manage fields**. See [Configuration](configuration/index.md)
for the details of each.
