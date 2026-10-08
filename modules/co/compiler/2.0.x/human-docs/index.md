# Compiler — manual setup guide

**Compiler** (`compiler`) is a small developer framework that gives Drupal a
generic **"compiler plugin" type**. On its own it does nothing you can see — there
is no page, no block, no setting. What it provides is the plumbing (a plugin
manager, a base class, a PHP attribute, and a couple of input value objects) so
that *other* modules can register "compilers" — pieces of code that take some
input (a file path or a raw string) and transform it into a compiled result.

Think of it as the shared foundation for an ecosystem. A Sass-to-CSS compiler, a
minifier, a Markdown renderer, an image processor — each can be written as a
compiler plugin against this common contract, and any module can then ask the
plugin manager for a compiler by name and run it. The well-known consumers are
**SCSS Compiler** (`compiler_scss`), which adds an `scss` compiler plugin, and
**Theme Compiler** (`theme_compiler`), which uses those plugins to build theme
assets.

Because Compiler is pure API, you install it only because another module needs it
(it is usually pulled in automatically as a dependency), or because you are a
developer writing or invoking a compiler plugin yourself. There is nothing to
configure and nothing to click.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is a developer framework
with no settings, routes, or permissions.

## How it's used

Developers define a compiler plugin by placing a class in their module's
`Plugin/Compiler/` folder, tagging it with the `#[Compiler('id')]` attribute, and
implementing a `compile()` method. To *run* a compiler, code asks for the
`plugin.manager.compiler` service, creates the plugin by its machine id, and calls
`compile()` with one or more inputs — a `CompilerInputFile` (a path on disk) or a
`CompilerInputSource` (a raw string). The compiler returns the transformed result
and throws an exception on error. If you just want to compile SCSS or build theme
assets, install **SCSS Compiler** and **Theme Compiler** rather than working with
this module directly.
