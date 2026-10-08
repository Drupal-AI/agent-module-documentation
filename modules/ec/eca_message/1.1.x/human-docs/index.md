# ECA Message — manual setup guide

**ECA Message** (`eca_message`) lets your no‑code
[ECA](https://www.drupal.org/project/eca) automations create **Message
entities** from the [Message](https://www.drupal.org/project/message) module. A
Message entity is the building block behind activity streams and notification
logs, so with this module an ECA model can record "something happened" as a
Message whenever an event fires — a node is published, a user registers, an
order changes — without writing any PHP.

It exists as a stop‑gap while native Message support is being added to ECA
itself (see the ECA issue queue), and it is deliberately small: it adds one or
more ECA action plugins for creating a Message, and nothing else. There is no
settings page — you configure the behavior inside the ECA model editor.

The Messages it creates follow the Message module's own access rules, and the
module has no access‑control role of its own. It depends on both ECA and the
Message module, and supports Drupal 9, 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECA and Message.

There is **no configuration page** for this module. It adds a message‑creation
action you use inside ECA models; see "How to use it" below.

## Where it lives in the admin menu

ECA Message adds no admin page of its own. You use it from the **ECA** model
editor (**Administration → Configuration → Workflow → ECA**), where its
Message‑creation action becomes available when you build or edit a model.
Message types (templates) are managed separately under the Message module's
admin pages.

## How to use it

1. Make sure both ECA and Message are installed, and that you have at least one
   Message template (message type) defined in the Message module.
2. Open the ECA model editor and create or edit a model.
3. Add an event to trigger the model, add any conditions you need, then add this
   module's action to **create a Message** — choosing the message template and
   supplying values with tokens from the triggering context.
4. Save and enable the model. From then on, matching events will generate
   Message entities automatically.
