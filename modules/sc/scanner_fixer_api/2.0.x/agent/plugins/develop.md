<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build Scanner / Fixer / Solution plugins

The module is code-only; see the `scanner_fixer_api_example` submodule for a worked example.

## Concepts
- **Scanner** (`@Scanner`, extend `ScannerBase`/implement `ScannerInterface`) — returns an array of item IDs (node IDs, term IDs, UUIDs, ...). Not run standalone.
- **Fixer** (`@Fixer`, extend `FixerBase`/implement `FixerInterface`) — `canFix($id)` decides whether it applies; a fix method acts on the item.
- **Solution** (`@Solution`, extend `SolutionBase`/implement `SolutionInterface`) — groups scanners + fixers: scanned IDs are combined and passed to the fixers. Reports via `SolutionResultsInterface` / `SolutionStatCounter`.

## Plugin managers (inject to run in code)
- `plugin.manager.scanner_fixer_api.scanner`
- `plugin.manager.scanner_fixer_api.fixer`
- `plugin.manager.scanner_fixer_api.solution`
All extend the default plugin manager.

## Running a Solution
- **UI:** overview at `/admin/content/scanner_fixer_api` (perm `use scanner-fixer solution overview page`) links to the wizard `/admin/content/scanner_fixer_api/{solutionId}` (`SolutionWizard`). Access requires the auto-generated permission `use solution {solutionId}` (checked by `SolutionWizard::access()`).
- **Drush:** the `scanner_fixer_api.commands` service (`ScannerFixerApiCommands`) runs Solutions from the CLI.

## Permissions
`SolutionPermissions::solutionsPermissions()` emits `use solution {solutionId}` for every defined Solution (title/description from the plugin definition). Grant it to roles that may run that Solution. Because Fixers mutate data, keep destructive Solutions behind their own permission.
