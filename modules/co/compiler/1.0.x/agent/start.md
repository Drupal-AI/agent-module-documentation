<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Compiler — agent index

A developer framework that provides one thing: a generic **`compiler` plugin type** plus
context/input value objects. No UI, no config, no routes, no permissions, no Drush. You
either **write a compiler plugin** or **invoke an existing one** through the manager service
`plugin.manager.compiler`.

- **Define a compiler plugin (namespace, annotation, interface, manager, alter hook)** →
  [plugins/compiler-plugin.md](plugins/compiler-plugin.md)
- **Invoke a compiler; build contexts and inputs (`CompilerContext`, `RefineableCompilerContext`, `CompilerInputFile`/`Direct`)** →
  [api/context-and-invoke.md](api/context-and-invoke.md)

Key facts:
- Service: `plugin.manager.compiler` → `Drupal\compiler\Plugin\CompilerPluginManager`.
- Plugins live in `<module>/src/Plugin/Compiler/`, annotated `@Compiler("id")` (a `PluginID`),
  implementing `CompilerPluginInterface::compile(CompilerContextInterface $context)`.
- Discovery alter hook: `hook_compiler_info(&$definitions)`; cache bin `compiler_plugins`.
- The module ships **no** compiler plugins itself; concrete ones come from other modules
  (e.g. `compiler_scss` registers `scss`).
