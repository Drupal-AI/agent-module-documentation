<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Compiler is a developer framework module that provides a generic **compiler plugin type** (a plugin manager, base classes, and context/input value objects) so other modules can register "compilers" that transform inputs into a compiled result. It ships no compilers, UI, config, routes, permissions, or Drush of its own — it is pure API.

---

The module defines a Drupal plugin type keyed `compiler`: plugins live in a module's `Plugin/Compiler/` namespace, carry the `@Compiler("id")` annotation (a `PluginID`), and implement `CompilerPluginInterface::compile(CompilerContextInterface $context)`. The plugin manager is the service `plugin.manager.compiler` (`Drupal\compiler\Plugin\CompilerPluginManager`, an alter-able `DefaultPluginManager` whose discovery is altered via `hook_compiler_info`). A compilation is described by a **context**: `CompilerContext` (immutable) or `RefineableCompilerContext` (mutable, `ArrayAccess`) hold the chosen compiler id, an options array, a set of inputs, and arbitrary user `data`. Inputs are value objects implementing `CompilerInputInterface` — `CompilerInputFile` (a file path) and `CompilerInputDirect` (a raw value) — retrieved through `$context->getInputs()`, a filtered recursive iterator. Concrete compilers (e.g. `compiler_scss`) provide the actual transformation, and consumers (e.g. `theme_compiler`) build a context and call `$manager->createInstance($id)->compile($context)`. Because it is just wiring, an agent uses it either to *write a new compiler plugin* or to *invoke an existing one* through the manager.

---

- Register a new compiler plugin type instance (e.g. a Sass, LESS, Markdown, or minifier compiler) under `Plugin/Compiler/`.
- Build a reusable transformation pipeline where inputs are files or raw strings and the output is compiled bytes.
- Look up the `plugin.manager.compiler` service to instantiate a compiler by machine name.
- Compile a set of source files into a single asset via a `CompilerContext`.
- Pass per-run configuration to a compiler through the context's `options` array.
- Attach arbitrary user data to a compilation with `CompilerContext::getData()`.
- Iterate compiler inputs through `getInputs()` without caring about nesting.
- Distinguish file-based inputs (`CompilerInputFile`) from direct value inputs (`CompilerInputDirect`).
- Mutate a compilation definition at runtime with `RefineableCompilerContext` array access (`$context[] = $input`).
- Swap the compiler used for a context with `setCompiler()` before running it.
- Alter available compiler plugin definitions from another module via `hook_compiler_info`.
- Provide a common contract so several modules can share one compilation abstraction.
- Back a theme/asset build system (as `theme_compiler` does) on top of a pluggable compiler.
- Unit-test a compiler in isolation by constructing a context and calling `compile()`.
- Wrap an external library (node-sass, a bundler, an image processor) as a Drupal compiler plugin.
- Centralize compiler discovery/caching through a `DefaultPluginManager` subclass with its own cache bin (`compiler_plugins`).
- Let contrib decorate or extend the manager service for custom discovery.
- Return a compiled result to a caller while letting the compiler throw exceptions on error.
- Standardize how modules describe "these inputs + these options → this output".
- Feed a compiled result into a controller/response (see `theme_compiler`'s on-demand serve).
- Model a multi-input compilation (concatenate several files) with an inputs array.
- Reuse the same compiler plugin across different contexts/options.
- Provide the base classes (`CompilerPluginBase`, `CompilerInputBase`) so plugin authors write minimal code.
- Keep compilation logic out of themes/modules by delegating to a named compiler plugin.
- Serve as the shared dependency for the EBT/asset ecosystem and similar build tooling.
