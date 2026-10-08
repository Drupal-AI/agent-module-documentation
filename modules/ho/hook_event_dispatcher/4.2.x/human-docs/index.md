# Hook Event Dispatcher — manual setup guide

**Hook Event Dispatcher** (`hook_event_dispatcher`) is a developer module that lets
you respond to Drupal hooks by subscribing to typed **Symfony event classes** instead
of writing procedural `hook_*()` functions in a `.module` file. The payoff is
cleaner, testable, dependency-injected hook logic: you get real classes with
type-hinted event objects, IDE autocompletion, and named event constants instead of
scattered free functions and untyped arguments.

The base module is only the plumbing — it dispatches events but ships none of its own.
The actual events live in about ten **per-subsystem submodules** that you enable as
needed. The most common one is **Core Event Dispatcher** (`core_event_dispatcher`),
which covers entity, form, theme, block, file, menu, token, language, and page hooks.
Others cover fields, media, paths, preprocessing, users, Views, the toolbar, JSON:API,
and Webform. You enable only the submodule that owns the hook you care about, keeping
the surface area small.

There is **no configuration UI and no permissions** — "setting it up" simply means
enabling the right submodule and then writing an event subscriber in your own module.

This guide is written for a **human** getting the module installed. Because this is a
developer/library module, the real how-to (writing a subscriber, event naming, and
alter/return-style hooks) is documented for an AI coding agent in the sibling
[`agent/`](../agent/start.md) docs — start with the "How to use it" summary below and
follow those for code.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base module plus the submodule for the subsystem you need.

## How to use it

There is nothing to click. The workflow is:

1. **Enable the submodule** that owns your hook. For most sites that's Core Event
   Dispatcher:

   ```bash
   drush en core_event_dispatcher -y
   ```

   (It pulls in the base `hook_event_dispatcher` module automatically.) Add others as
   needed, e.g. `drush en views_event_dispatcher user_event_dispatcher -y`. Enabling
   the base module *alone* gives you the machinery but zero events.

2. **Write an event subscriber** in your own module — a class implementing Symfony's
   `EventSubscriberInterface`, registered as an `event_subscriber`-tagged service,
   whose `getSubscribedEvents()` maps an event constant (e.g.
   `EntityHookEvents::ENTITY_INSERT`) to a method. That method receives a typed event
   object with getters and setters instead of raw hook arguments.

3. Optionally **scaffold** a subscriber stub with the module's Drush code generator:

   ```bash
   drush generate
   ```

   then pick the hook-event subscriber generator.

The submodules are documented as a group rather than individually — enable the one
that owns the hook you want, then subscribe to its event constant. See the
[`agent/`](../agent/start.md) docs for full subscriber examples, the list of which
`*HookEvents` constants class lives in which submodule, and how alter-style and
return-style hooks feed your changes back into Drupal.

## Requirements at a glance

Needs **Drupal 10.2 or 11** and **PHP 8.1+**. The base module has no dependencies of
its own; each submodule depends on the base module (and Webform's submodule needs the
contrib Webform module). Full details in [Installation](installation/index.md).
