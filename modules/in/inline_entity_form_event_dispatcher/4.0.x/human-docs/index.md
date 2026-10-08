# Inline Entity Form Event Dispatcher — manual setup guide

**Inline Entity Form Event Dispatcher** (`inline_entity_form_event_dispatcher`)
is a small developer bridge. It takes the hooks that the
[Inline Entity Form](https://www.drupal.org/project/inline_entity_form) module
fires and re‑exposes them as **Symfony events** through the
[Hook Event Dispatcher](https://www.drupal.org/project/hook_event_dispatcher)
module. That means you can react to Inline Entity Form activity with a proper
event subscriber in your own module, instead of writing procedural hook
implementations in a `.module` file.

This is purely a framework/developer convenience. It adds no content, no admin
pages, no permissions, and no access rules of its own — it simply turns existing
IEF hooks into events you can subscribe to. If you are not writing custom code
against Inline Entity Form, you do not need this module.

Because it is a code‑level tool, there is nothing to click through: you enable it,
then write an event subscriber in your own module that listens for the IEF events
it dispatches.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its two required modules.

There is **no configuration page** for this module and nothing to set up in the
UI. Once it and its dependencies are enabled, the events are available for your
code to subscribe to.

## Where it lives in the admin menu

Nowhere — this module adds no admin menu items or settings form. Its entire value
is in the developer‑facing events it dispatches. To use it, write a Symfony event
subscriber (registered as a tagged `event_subscriber` service) in a custom module
that listens for the Inline Entity Form events it re‑exposes.
