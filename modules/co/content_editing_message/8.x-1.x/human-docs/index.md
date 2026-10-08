# Content Editing Messages — manual setup guide

**Content Editing Messages** (`content_editing_message`) lets you place helpful,
admin‑authored notes on content and media edit forms. When an editor opens a form
to add or change an entity, they see the message you configured — for example
"This page appears on the homepage, edit carefully" or a reminder about house
style. It's a small editorial‑UX module for surfacing context and warnings
exactly where editors will act on them.

You can attach one or more messages to any content type or media type, and each
message is fully controllable: a translatable **title**, a translatable **message
body** with a text format, a **style** (info, warning, error, or plain), and a
**placement** (top of the form, bottom, or a custom weight). If the
[Field Group](https://www.drupal.org/project/field_group) module is installed,
you can also target a specific field group by its machine name so the message
appears inside that group (for example inside a particular tab).

The module works once enabled, but it shows nothing until you create at least one
message on its configuration page, so this is a **needs‑config** module. It has no
dependencies beyond Drupal core (Field Group is an optional enhancement). It
provides its own permission so you can control who is allowed to manage the
messages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and tune editing messages,
   field by field.

## Where it lives in the admin menu

The message list and add/edit forms live at **Configuration → Content authoring →
Content Editing Messages** (`/admin/config/content/messages`). This is the
`entity.content_editing_message.collection` route.
