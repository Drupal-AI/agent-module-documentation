<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Compiler is a developer framework module that provides a generic **compiler plugin type** (a plugin manager, a base class, an attribute/annotation, and input value objects) so other modules can register "compilers" that transform inputs — file paths or raw source strings — into a compiled result. It ships no compilers, UI, config, routes, permissions, or Drush of its own — it is pure API.

---

The module defines a Drupal plugin type keyed `compiler`: plugins live in a module's `Plugin/Compiler/` namespace, carry the `#[Compiler('id')]` PHP attribute (or the legacy `@Compiler("id")` annotation), and implement `CompilerPluginInterface::compile(CompilerInput ...$inputs): mixed`. The plugin manager is the service `plugin.manager.compiler` (`Drupal\compiler\Plugin\CompilerPluginManager`, a `final` alter-able `DefaultPluginManager` with cache bin `compiler_info`, altered via `hook_compiler_plugin_alter`). Unlike 1.x there is **no context/options/data object** — a compiler receives a variadic list of inputs directly. Inputs are value objects extending the abstract `CompilerInput` (an `@internal` base holding a `public readonly string $value` and an abstract `getSource(): string`): `CompilerInputFile` returns the file's contents from `getSource()` (via `file_get_contents($value)`), and `CompilerInputSource` returns the raw string value directly. Concrete compilers (a Sass compiler, a minifier, the test module's prefix calculator) provide the actual transformation; consumers ask the manager for a plugin and call `$manager->createInstance($id)->compile($input1, $input2, ...)`. Compilers are expected to **throw** on error (the interface documents `@throws \Throwable`), and plugin authors are encouraged to extend `CompilerPluginInterface` to narrow the return type for their own consumers. Because it is just wiring, an agent uses it either to *write a new compiler plugin* or to *invoke an existing one* through the manager.

---

- Register a new compiler plugin (e.g. a Sass, LESS, Markdown, or minifier compiler) under `Plugin/Compiler/` with the `#[Compiler('id')]` attribute.
- Build a reusable transformation where inputs are files or raw strings and the output is a compiled result.
- Look up the `plugin.manager.compiler` service to instantiate a compiler by machine id.
- Compile a set of source files into a single asset by passing several `CompilerInputFile` inputs.
- Compile an in-memory string with `CompilerInputSource` (no file I/O).
- Mix file inputs and raw-source inputs in one `compile()` call via the variadic signature.
- Read each input's bytes uniformly through `CompilerInput::getSource()` regardless of whether it is a file or a literal.
- Distinguish file-based inputs (`CompilerInputFile`) from direct source inputs (`CompilerInputSource`) by type.
- Access the raw stored value of an input via the `public readonly string $value` property.
- Alter available compiler plugin definitions from another module via `hook_compiler_plugin_alter`.
- Provide a common contract so several modules can share one compilation abstraction.
- Extend `CompilerPluginInterface` in your own module to narrow the `compile()` return type for your consumers (as the test's `PrefixCalculatorInterface` does).
- Back a theme/asset build system on top of a pluggable compiler.
- Unit/kernel-test a compiler in isolation by constructing inputs and calling `compile()`.
- Wrap an external library (a Sass bundler, a JS minifier, an image processor) as a Drupal compiler plugin.
- Centralize compiler discovery/caching through a `DefaultPluginManager` subclass with its own cache bin (`compiler_info`).
- Use the legacy `@Compiler("id")` annotation for plugins on older code paths (both attribute and annotation discovery are wired).
- Return a compiled result of any type from a compiler while letting it throw exceptions on error.
- Standardize how modules describe "these inputs → this output".
- Feed a compiled result into a controller/response for on-demand serving.
- Model a multi-input compilation (concatenate several files) with multiple inputs.
- Reuse the same compiler plugin across different input sets.
- Provide the base classes (`CompilerPluginBase`, `CompilerInput`) so plugin authors write minimal code.
- Keep compilation logic out of themes/modules by delegating to a named compiler plugin.
- Serve as the shared dependency for asset-build and similar tooling ecosystems.
- Verify a compiler is registered with `$manager->hasDefinition($id)` before instantiating it.
