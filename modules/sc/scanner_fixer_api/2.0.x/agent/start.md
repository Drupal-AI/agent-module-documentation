<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scanner-Fixer API (scanner_fixer_api) — agent index

**Developer framework: Scanner (find item IDs) + Fixer (act on an item) + Solution (bundle) plugins, runnable via UI wizard or Drush.**

- **Version:** 2.0.x (2.0.0-alpha2) · **PHP:** 8.1
- **Core:** ^10.4 || ^11 · **Dependencies:** none (core only)
- **Plugin types:** `@Scanner`/`@Fixer`/`@Solution` with managers `plugin.manager.scanner_fixer_api.{scanner,fixer,solution}`; base classes `ScannerBase`, `FixerBase`, `SolutionBase`; results model `SolutionResultsInterface`/`SolutionStatCounter`.
- **Routes:** `scanner_fixer_api.solutions` → `/admin/content/scanner_fixer_api` (perm `use scanner-fixer solution overview page`); `scanner_fixer_api.solution.wizard` → `/admin/content/scanner_fixer_api/{solutionId}` (`SolutionWizard`, `_custom_access` = `SolutionWizard::access`).
- **Permissions:** static `use scanner-fixer solution overview page` + dynamic per-Solution `use solution {id}` (`SolutionPermissions::solutionsPermissions`).
- **Drush:** `scanner_fixer_api.commands` (`ScannerFixerApiCommands`). **Configure:** `scanner_fixer_api.solutions`. Example submodule `scanner_fixer_api_example`.

**Security:** admin routes are permission-gated; the wizard uses `_custom_access` enforcing the per-Solution `use solution {id}` permission before any fix runs. Fixers can mutate content in bulk, so that per-Solution gate is the key control — no anonymous or ungated mutation. No security findings.

See [plugins/develop.md](plugins/develop.md).