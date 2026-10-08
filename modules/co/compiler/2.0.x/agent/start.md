<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Compiler — agent index

A developer framework that provides one thing: a generic **`compiler` plugin type** plus
input value objects. No UI, no config, no routes, no permissions, no Drush. You either
**write a compiler plugin** or **invoke an existing one** through the manager service
`plugin.manager.compiler`.

- **Define a compiler plugin (namespace, attribute/annotation, interface, manager, alter hook)** →
  [plugins/compiler-plugin.md](plugins/compiler-plugin.md)
- **Invoke a compiler; build inputs (`CompilerInputFile`, `CompilerInputSource`)** →
  [api/inputs-and-invoke.md](api/inputs-and-invoke.md)

Key facts:
- Service: `plugin.manager.compiler` → `Drupal\compiler\Plugin\CompilerPluginManager` (`final`).
- Plugins live in `<module>/src/Plugin/Compiler/`, marked `#[Compiler('id')]` (attribute) or
  `@Compiler("id")` (legacy annotation), implementing
  `CompilerPluginInterface::compile(CompilerInput ...$inputs): mixed`.
- Discovery alter hook: `hook_compiler_plugin_alter(&$definitions)`; cache bin `compiler_info`.
- **2.0 breaking change:** no more `CompilerContext`/`RefineableCompilerContext`/options/data —
  `compile()` now takes a variadic list of `CompilerInput` objects directly.
- Inputs expose `getSource(): string`; the raw value is `->value` (`public readonly string`).
- The module ships **no** compiler plugins itself; concrete ones come from other modules.
