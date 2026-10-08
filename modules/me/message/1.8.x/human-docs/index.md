# Message — manual setup guide

**Message** (`message`) is a general logging utility that records site activity as
reusable *Message* content entities. It is the foundation that "activity stream"
and notification features are built on — modules like Message Notify, Message
Subscribe, and various activity feeds all sit on top of it. On its own, Message
gives you the building blocks; you (or those add-on modules) decide what gets
logged and how it is shown.

The module revolves around two entity types. A **Message template** is a config
entity that holds the templated text — one or more formatted-text *partials* that
can contain Drupal **tokens** (for example `[message:author:name]` or
`[node:title]`) and per-template settings. A **Message** is a content entity: one
logged instance of a template. When a message is displayed, its text is rendered
by substituting any per-instance *arguments* and then replacing the tokens, so the
same template can produce many concrete messages.

Because messages are real entities, they are fieldable, translatable, integrate
with Views, and can reference other entities so their tokens resolve against them.
The template text has unlimited cardinality, so you can separate markup partials
from content and reorder or hide them per view mode on the *Manage display*
screen. Message distinguishes *dynamic* tokens (re-evaluated every render),
*single-use* arguments (frozen at creation time), and custom callback arguments.
An auto-purge system — built on the pluggable `message_purge` plugin type, with
`days` and `quota` methods shipped — deletes old messages on cron, either globally
or overridden per template.

Message ships one example submodule, **Message Example** (`message_example`),
which provides sample templates to learn from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent (including the code API for
creating templates and messages), read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the example submodule.
2. [Configuration](configuration/index.md) — create message templates, write their
   text with tokens and partials, and set up auto-purging.

## Where it lives in the admin menu

Two areas:

- **Structure → Messages** (`/admin/structure/message`) — the list of message
  templates, where you add, edit, and manage them (and reach their *Manage
  fields* / *Manage display* tabs).
- **Configuration → Messages** (`/admin/config/message`) — the settings hub, whose
  global settings form (`/admin/config/message/message`) controls purging and
  auto-deletion.

## How to use it

Because Message is a foundation module, the typical flow is: define one or more
templates (the reusable text with tokens), then have code — your own, or a module
like Message Notify — create message entities of those templates when events
happen. Editors with the *Overview messages* permission can browse the logged
messages. The [Configuration](configuration/index.md) page covers creating
templates and tuning purge behavior; creating messages in code is covered in the
[agent API doc](../agent/api/message.md).
