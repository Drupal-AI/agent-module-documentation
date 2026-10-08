<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal Module Upgrader (DMU) is a developer Drush tool that scans a Drupal 7 module's source, reports what must change for modern Drupal, and rewrites the mechanically-convertible parts in place.

---

DMU runs on a modern Drupal site (core ^10 || ^11) but its subject is Drupal 7 code: you drop the D7 module into the site's `/modules` directory and drive it entirely from the command line. `drush dmu-analyze MODULE_NAME` builds an in-memory index of the target (functions, classes, constants, calls, hook implementations via the Indexer plugins), runs every Analyzer plugin against it, and writes an HTML report (`upgrade-info.html` in the module directory by default, or `--output PATH`) grouping each flagged Issue by category with source file/line locations and links to the matching drupal.org change records. `drush dmu-upgrade MODULE_NAME` goes further and mutates the module in place, running the Converter plugins to translate what it can: `hook_permission` and `hook_menu` to YAML/routing, the `.info` file to `.info.yml`, blocks/forms/tests to classes, and a large table of D7 procedural function calls (`db_query`, `drupal_alter`, `variable_get`, `watchdog`, `check_plain`, entity loaders, and dozens more, driven by `config/install/drupalmoduleupgrader.*.yml`) to their service-based equivalents. Under the hood it uses the Pharborist PHP parser and a plugin architecture of Indexers, Analyzers, Converters (deprecated), Fixers (small Pharborist edits) and parametric Rewriters (type-aware getter/setter substitution); `drush dmu-list TYPE` enumerates the plugins of a given type, and `--only`/`--skip` filter which run. The output is a starting point, not a finished port: it leaves FIXME notices where it cannot convert, produces deliberately un-refactored code, and the parts it cannot translate are exactly the parts carrying the original module's intent. The project is minimally maintained (alpha, 2.0.0-alpha2), kept alive to help teams still climbing off Drupal 7, which reached end of life in January 2025.

---

- Scan a Drupal 7 module for what must change to run on modern Drupal.
- Generate an HTML upgrade report with change-record links (`dmu-analyze`).
- Attempt an automatic in-place port of a D7 module (`dmu-upgrade`).
- Convert a `.info` file to `.info.yml`.
- Convert `hook_permission` to a `permissions.yml`.
- Convert `hook_menu` items to routing YAML and controllers.
- Convert `hook_block_*` to block plugin classes.
- Convert forms to `FormBase`/`ConfigFormBase` classes.
- Convert SimpleTest/`.test` files to PHPUnit/functional tests.
- Rewrite deprecated procedural calls (`db_query`, `variable_get`, `watchdog`, `drupal_alter`) to service equivalents.
- Rewrite common global variables (`$user`, `$language`) to service calls.
- Move a class-per-file layout to PSR-4 (`src/`).
- List the available analyzer/converter/fixer plugins (`dmu-list`).
- Run only a subset of analyzers or converters (`--only`).
- Skip specific converters that misbehave on a codebase (`--skip`).
- Make a backup copy of the module before converting (`--backup`).
- Point the tool at a module outside the default search path (`--path`).
- Write the analysis report to a chosen location (`--output`).
- Triage which legacy modules are worth porting vs. replacing with contrib.
- Estimate the mechanical effort of a Drupal 7 module upgrade.
- Find code that needs manual attention (FIXME markers left in place).
- Turn an intimidating rewrite into a reviewable, categorized issue list.
- Support a Drupal 7 end-of-life migration effort.
