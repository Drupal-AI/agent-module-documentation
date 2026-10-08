<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A developer framework for defining two-step "find then fix" operations as plugins: Scanners locate items, Fixers act on them, and Solutions bundle scanners+fixers into a runnable unit.

The module has no built-in behavior of its own — all functionality is written as code. A **Scanner** produces an array of item IDs (node IDs, term IDs, UUIDs, etc.). A **Fixer** evaluates an item ID (`canFix`) and performs a fix. A **Solution** groups one or more Scanners and Fixers so the combined scanned IDs are passed to the fixers to act on. Each is a plugin with its own annotation (`@Scanner`, `@Fixer`, `@Solution`) and plugin manager (`plugin.manager.scanner_fixer_api.{scanner,fixer,solution}`), all extending the default plugin manager, plus base/interface classes and a `SolutionStatCounter`/results model.

Operationally, Solutions can be run from the web UI: `/admin/content/scanner_fixer_api` (route `scanner_fixer_api.solutions`, permission `use scanner-fixer solution overview page`) lists Solutions, and each links to a multi-step wizard at `/admin/content/scanner_fixer_api/{solutionId}` (`SolutionWizard` form, `_custom_access` = `SolutionWizard::access`). The module auto-generates a per-Solution permission `use solution {solutionId}` (via `SolutionPermissions::solutionsPermissions`), and the wizard's custom access checks it — so running a given Solution requires its specific permission. A Drush command service (`scanner_fixer_api.commands`, class `ScannerFixerApiCommands`) allows running Solutions from the CLI. The `scanner_fixer_api_example` submodule documents how to build plugins. Because Fixers can mutate content in bulk, the per-Solution permission gate is the key control.
---
A plugin framework (Scanner + Fixer + Solution) for batched find-and-fix remediation, runnable via UI or Drush.
---
- Define a Scanner plugin that returns IDs of items needing a fix.
- Define a Fixer plugin that evaluates and fixes a single item.
- Bundle scanners and fixers into a Solution plugin.
- Run a Solution from the UI wizard at `/admin/content/scanner_fixer_api`.
- Grant a role the per-Solution `use solution {id}` permission.
- Restrict who can see the solution list via the overview permission.
- Run a Solution from the CLI via the module's Drush command.
- Batch-remediate broken references across many nodes.
- Normalize field values across a content type via a Fixer.
- Re-tag or migrate taxonomy terms found by a Scanner.
- Combine multiple scanners' IDs into one fix pass.
- Report scan/fix statistics via the results/stat counter model.
- Preview which items a Scanner matches before fixing.
- Build a data-cleanup Solution for a content migration.
- Study `scanner_fixer_api_example` to scaffold plugins.
- Gate a destructive fix behind its own Solution permission.
- Extend `ScannerBase`/`FixerBase`/`SolutionBase` for custom logic.
- Load plugins via `plugin.manager.scanner_fixer_api.solution` in code.
- Add a local task/tab to reach the solutions overview.
- Schedule recurring fixes by invoking a Solution from Drush/cron.
- Implement `canFix()` so a Fixer skips items it can't handle.
- Report progress through the `SolutionResultsInterface` model.