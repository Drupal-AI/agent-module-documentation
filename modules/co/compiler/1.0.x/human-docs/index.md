# Compiler — manual setup guide

**Compiler** (`compiler`) is a small developer framework module. On its own it
does nothing you can see — it ships no user interface, no settings, no compilers
of its own. What it provides is a generic **"compiler" plugin type**: a shared,
reusable way for *other* modules to register components that turn some inputs
(files or raw strings) into a compiled result. Think of it as the common
plumbing behind an asset-build pipeline, so several modules can agree on one way
to describe "these inputs + these options → this output" instead of each
inventing its own.

You would install Compiler because another module asks for it. For example,
**SCSS Compiler** (`compiler_scss`) registers an `scss` compiler on top of it,
and **Theme Compiler** (`theme_compiler`) uses it to build theme assets on
demand. If you're a developer, you'd use Compiler directly to either *write a new
compiler plugin* (a Sass, LESS, Markdown, or minifier compiler, say) or *invoke
an existing one* from code. It's popular precisely as shared infrastructure —
roughly 2,500 sites run it — but almost always as a dependency of something else
rather than a thing you configure yourself.

Because it is pure API with nothing to configure, this guide covers only how to
install and enable it, plus a short summary of how developers use it. For the
full plugin contract, the manager service, and the context/input value objects,
read the sibling [`agent/`](../agent/start.md) docs — the terse, token-cheap
references written for an AI coding agent. Compiler requires PHP 8.1+ and Drupal
core only; it has no submodules and no third-party libraries.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
   There is nothing to configure.

## Where it lives in the admin menu

Nowhere. Compiler has no admin page, no settings form and no menu entry
(`configure: null`). Once enabled, its value is entirely available to code
through the `plugin.manager.compiler` service.

## How to use it

Compiler defines a Drupal plugin type keyed `compiler`. A developer works with it
in one of two ways:

- **Write a compiler plugin.** Put a class in your module's
  `src/Plugin/Compiler/` folder, annotate it `@Compiler("your_id")`, and
  implement `CompilerPluginInterface::compile()`. That registers a new named
  compiler other code can call.

- **Invoke an existing compiler.** Ask the `plugin.manager.compiler` service for
  a compiler by its id, build a *context* describing the inputs and options, and
  call `compile()`:

  ```php
  $manager = \Drupal::service('plugin.manager.compiler');
  $css = $manager->createInstance('scss')->compile($context);
  ```

  A **context** (`CompilerContext`, or the mutable `RefineableCompilerContext`)
  bundles the chosen compiler id, an options array, and a set of **inputs** —
  either a `CompilerInputFile` (a path) or a `CompilerInputDirect` (a raw value).

The module ships no compilers itself, so on its own there is nothing to run —
concrete compilers come from modules like `compiler_scss`. See the
[`agent/`](../agent/start.md) docs for the complete API.
