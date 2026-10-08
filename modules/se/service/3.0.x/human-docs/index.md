# Service — manual setup guide

**Service** (`service`) is a developer helper module. It provides a set of traits
and extended base classes that make **dependency injection** less tedious in
custom Drupal code — so your controllers, forms, blocks, and services can pull in
the dependencies they need with far less boilerplate wiring.

In practice you extend one of the module's base classes (for example its
`BlockBase`) and mix in the traits for the services you want — `ConfigFactoryTrait`,
`EntityTypeManagerTrait`, `UserDataTrait`, and so on — then declare them in a
short `creation()` method. From that point you can call `$this->configFactory()`,
`$this->entityTypeManager()`, or `$this->userData()` directly, without hand-writing
the usual `create()` / constructor injection plumbing.

This is a **pure API utility with no end-user features**: it ships no content, no
routes, no admin pages, and nothing to configure through the interface. You enable
it so that your own modules can depend on it and use its traits and base classes,
and it has no content or access-control role of its own. It has no other module
dependencies, but note that this 3.0.x release requires **PHP 8.3 or higher**.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, use it from your own custom module: import the base class and the
traits you need, list them in your class, register the ones you want in a
`creation()` method, and then call the corresponding accessor methods where you
need each service. Because it is a code-level helper, there is nothing to click or
configure in the admin UI — the benefit shows up in your module's PHP.
