# Contextualized State — manual setup guide

**Contextualized State** (`contextualized_state`) is a developer‑facing API for
storing and reading fine‑grained, per‑user context in the user's **session**, so
your site can behave differently depending on each visitor's current context. It
is infrastructure other modules build on rather than a feature you configure and
use directly — there are no admin pages, permissions, or settings in the main
module.

The idea is simple: each user carries their own "context data" in the session, and
once that context exists, the system can react to it — personalisation, A/B logic,
campaign‑specific behaviour, and so on. Developers define a **Context** class (by
extending `BaseContext`) and a **provider** plugin (annotated
`@ContextualizedStateProvider`) that knows how to handle it. Context is *set* by
dispatching a `ContextEvent` (`ContextEvent::ON_SET_CONTEXT`) through the event
dispatcher; a subscriber resolves which provider should handle it — optionally
forced with a `plugin_id`, and grouped by a `type` — and stores the result. Later,
code reads it back through the `contextualized_state.context_manager.service`,
calling `getContext($plugin_id)` and then `getAll()` or
`getState('key')->getValue()`.

Because this is an API, the best way to learn it is by example. A bundled
**Contextualized State Examples** submodule (`contextualized_state_examples`)
ships a "Soccer" context and provider plus a dispatch example form, which you can
enable and read as a working template.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the examples submodule.

There is **no configuration page** for this module — it is a developer API, used
in code, as described in "How to use it" below.

## Where it lives in the admin menu

The main module adds no admin pages, permissions, or settings. The only route it
contributes is through the optional examples submodule, which exposes an example
form for setting context.

## How to use it

For developers wiring context into a module:

1. Create a **Context** class that extends `BaseContext` to represent the data you
   want to carry per user.
2. Create a provider plugin annotated `@ContextualizedStateProvider` that handles
   that context. Use the `type` attribute to group related contexts.
3. **Set** context by dispatching a `ContextEvent` (`ContextEvent::ON_SET_CONTEXT`)
   via the event dispatcher. Pass a `plugin_id` on the event to target a specific
   provider. Dispatching a new event overwrites the stored context.
4. **Read** context via the `contextualized_state.context_manager.service`
   service: call `getContext($plugin_id)`, then `getAll()` for every stored value
   or `getState('key')->getValue()` for a single one.
5. To study a complete, working example, enable the
   **Contextualized State Examples** submodule and look at its Soccer
   context/provider and the DispatchExampleForm.
