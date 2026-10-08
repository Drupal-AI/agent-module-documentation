# EntityLogic — manual setup guide

**EntityLogic** (`entitylogic`) is a developer framework for wrapping entities in
bundle‑aware **business‑logic classes**, so per‑type and per‑bundle behavior
lives in dedicated PHP classes instead of scattered across hooks. It is similar
in spirit to [Typed Entity](https://www.drupal.org/project/typed_entity) and
Bundle Override, but uses a different plugin approach.

You define `EntityLogic` plugins (annotation‑based, extending `EntityLogicBase`)
whose IDs are shaped as `entity_type`, `entity_type.bundle`, or either of those
with a `:selector` suffix. A manager resolves the most specific plugin for a
given entity and bundle — falling back to a `_fallback` class — instantiates it,
and injects the entity. The magic `entitylogic()` function is the main entry
point: call it with an entity to wrap it, with `type:selector` plus an ID (or an
array of IDs, or `null`) to load‑and‑wrap, and you get back a stateful,
UUID‑cached logic object you can call typed methods on. The same function is
exposed to **Twig**, so templates stay thin and call logic methods directly, and
a **Views** field plugin (`MethodCall`) can render a logic method's return value
in a View. A **Drush generator** scaffolds new logic classes, and there is token
integration too.

This is code‑first infrastructure: the base module has **no configuration UI**
and no runtime endpoints. The setup is entirely "install it, then write logic
classes in your own module." An optional `entitylogic_ui` submodule adds a
read‑only report listing your registered logic classes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — the developer API is documented in
detail in [`agent/api/usage.md`](../agent/api/usage.md).

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the UI submodule.

There is **no configuration page** for this module — it is a developer API. You
work with it by writing PHP plugin classes, described in "How to use it" below.

## Where it lives in the admin menu

The base module adds no admin page. If you enable the optional **entitylogic_ui**
submodule, it provides a read‑only report of your registered logic classes at
**Reports → EntityLogic** (`/admin/reports/entitylogic`), gated by the
`entitylogic_ui view list` permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Scaffold a new logic class with the Drush generator: run `drush generate` and
   choose the **EntityLogic** generator. This creates a plugin under your
   module's `Plugin/EntityLogic` directory, extending `EntityLogicBase`, with an
   ID matching the entity type / bundle you target.
3. Add your typed methods to that class.
4. Call your logic from PHP, for example `entitylogic($node)->myMethod()`; from
   Twig with `{{ entitylogic(node).myMethod() }}`; or in a View by adding the
   **MethodCall** field to render a method's result.

> **Note on access:** the manager's `provideWrap()` helper runs its entity query
> with access checking turned off (this is expected for a developer wrapper).
> When you surface results built from wrapped entities, you remain responsible
> for enforcing the appropriate access on what you display.
