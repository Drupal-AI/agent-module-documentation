# DX Toolkit — manual setup guide

**DX Toolkit** (`dx_toolkit`) is a developer‑experience library: a collection of
reusable primitives — standardized patterns, plugin systems, and helper services —
meant to improve code quality and cut boilerplate when you build custom Drupal
modules. It is aimed squarely at developers; it has no editor‑facing features and no
security surface of its own. Its value shows up in the code that is built on top of
it.

The toolkit bundles several ingredients. An **EntityGenerator** plugin system
programmatically creates companion configuration entities (for example, a view mode
for every bundle of a custom entity type, or a REST resource config for every content
type). A **ServiceInstance** pattern lets services identify themselves and be
instantiated inline (`MyService::getService()->someMethod()`), which also makes
mocking easier in tests. There are **plugin enhancements** via extended base classes
and plugin managers (extra methods like `createInstances`, `getPluginDerivatives`,
and `optionLabels`), plus **core utility extensions** — enhanced `Environment`,
`Color`, and `Json` helpers — and general‑purpose `ArrayUtilities`, an
`OptionsGenerator`, a `StateBase` wrapper, and more.

An optional **Demo** submodule (`dx_toolkit_demo`) ships working implementations of
all the plugin systems and patterns, so you can enable it, read the concrete
examples, and use them as templates in your own projects.

> **Note:** this is a **beta** release intended for community testing. The plugin
> systems and utilities have been used in production, but treat it as beta and report
> issues to the project's queue.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally enable the demo submodule.

There is **no configuration page** for this module — it's a developer library with no
settings form. You consume it from your own module code; the demo submodule shows
how.

## How to use it

DX Toolkit is used from PHP, not from the admin UI. After enabling it, build your
custom module against its base classes, traits, and helper services. The fastest way
to learn the patterns is to enable **DX Toolkit Demo** (`dx_toolkit_demo`) and read
its working implementations — ServiceInjector plugins with derivers, EntityGenerator
implementations, and the ServiceInstance pattern — then adapt them to your project.
