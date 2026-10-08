# Message associated entity — manual setup guide

**Message associated entity** (`message_associated_entity`) adds a single, focused
capability to the [Message](https://www.drupal.org/project/message) stack: it lets a
Message point at another entity. It does this by giving the Message entity a
**dynamic entity reference** field, so a message can be associated with the node,
user, term or any other content entity it is *about*.

Why that matters: notifications and activity streams are far more useful when they
carry context. "A comment was posted" is thin on its own; "a comment was posted on
*this article*" lets you link back to the source, filter by it, or render a richer
message. This module supplies the reference field that makes that association
possible, leaving the actual notification logic to the rest of the Message stack.

Because it relies on **Dynamic Entity Reference**, a single field can point at
different entity *types* — one message might reference a node, another a user —
without you defining a separate field per target type. It depends on the
[Message](https://www.drupal.org/project/message) and
[Dynamic Entity Reference](https://www.drupal.org/project/dynamic_entity_reference)
modules and works on Drupal 10 and 11.

This is a behind‑the‑scenes building block: there is nothing to switch on beyond
enabling it, and no central settings page. Once enabled, the reference is available
on Message entities for other modules, code, or configuration to populate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its Message and Dynamic Entity Reference dependencies.

There is **no configuration page** for this module — it simply adds the association
field to the Message entity.

## How to use it

Once the module is enabled, Message entities carry a dynamic entity reference that
can point at an associated content entity. In practice you populate that reference
from whatever creates your messages — custom code, the
[ECA](https://www.drupal.org/project/eca) module, or another part of the Message
stack — setting it to the entity the message concerns. Downstream, notifications,
Views listings and activity streams can then read the associated entity to add
context and links back to the source.
