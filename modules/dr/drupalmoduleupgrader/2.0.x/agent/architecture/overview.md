<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DMU architecture

DMU is a source-to-source transformation toolkit for porting Drupal 7 module code. It parses PHP with
the **Pharborist** library (`pharborist/pharborist`, a mutable PHP AST) and is organized as five
Drupal plugin types, each with its own annotation class (`src/Annotation/`) and a plugin-manager
service (`drupalmoduleupgrader.services.yml`). Everything is driven from the three Drush commands.

## The Target model

`src/Target.php` (`TargetInterface`) represents the module being worked on. Given a base path and the
container, it:

- Resolves the module `id()` from its `*.info` file (D7 info filename).
- `buildIndex()` runs every Indexer to catalogue the module into an index backend — by default an
  **in-memory SQLite** database (`ArrayIndexer` / `IndexerBase`).
- Opens/parses source files into Pharborist `RootNode` documents on demand and can write them back.

## Plugin types (run order: indexers → analyzers, or → converters)

- **Indexer** (`@Indexer`, `Plugin/DMU/Indexer`, iface `IndexerInterface`). Read-only cataloguers.
  Shipped: `Functions`, `Classes`, `Constants`, `FunctionCalls`. Always run first; their data is
  available to every other plugin.
- **Analyzer** (`@Analyzer`, `Plugin/DMU/Analyzer`, iface `AnalyzerInterface`, base `AnalyzerBase`).
  Read-only. Each returns zero or more `Issue` objects. The annotation carries `message`, optional
  `summary`, `documentation` (array of `{url, title}` change-record links), and `tags`
  (`category`, `error_level`). `buildIssue()` in `AnalyzerBase` assembles an Issue from the definition.
- **Converter** (`@Converter`, `Plugin/DMU/Converter`, iface `ConverterInterface`, base
  `ConverterBase`). **Deprecated** in favor of Fixers. Mutates the target in place; may leave `FIXME`
  notices where it cannot finish. `isExecutable($target)` gates whether it runs; `convert($target)`
  does the work.
- **Fixer** (`@Fixer`, `Plugin/DMU/Fixer`, iface `FixerInterface`, base `FixerBase`). Small, isolated
  Pharborist edits — the modern building blocks (`CreateClass`, `ImplementHook`, `Implement`, `Delete`,
  `Define`, `Disable`, `Notify`, `HookToYAML`, `FormCallbackToMethod`, `PSR4`).
- **Rewriter** (`@Rewriter`, `Plugin/DMU/Rewriter`, iface `RewriterInterface`). Type-aware parametric
  search-and-replace: given a function parameter and its type, rewrite property accesses into the
  right getter/setter calls (`type_hint` + a `properties` map of `get`/`set` methods).

A sixth, route-specific converter set lives under `Plugin/DMU/Routing` (`FormRoute`, `ContentRoute`,
using the `@Converter` annotation and the `plugin.manager.drupalmoduleupgrader.route` manager) with a
`Routing/` support layer (`RouterBase`, `HookMenu`, `ParameterMap`, `LinkBinding/…`) that models D7
`hook_menu` as routes/links.

## Issue and Report

`Issue` / `IssueInterface` hold a message, an optional summary, a set of source `Target` locations
(file + line), documentation links, and tags. `Report` / `ReportInterface` collect Issues;
`template_preprocess_dmu_report()` (in the `.module`) groups them by the `category` tag (labels from
`config/install/drupalmoduleupgrader.tags.yml`) for the `dmu_report` Twig template. The shipped
`templates/*.html.twig` are code stubs (Block, Controller, EntityType, Form, Widget, RouteSubscriber,
…) that converters render to scaffold modern class files.

## Config-driven conversions

Several conversions are pure data tables in `config/install/`:

- `drupalmoduleupgrader.grep.yml` — `globals` (e.g. `$user` → `\Drupal::currentUser()`) and
  `function_calls` (e.g. `check_plain` → `Html::escape`, `drupal_alter` → `moduleHandler()->alter`).
- `drupalmoduleupgrader.functions.yml`, `…hooks.yml`, `…entity_operations.yml`, `…rewriters.yml`,
  `…tags.yml`.

Note: config is shipped as install defaults; the module ships **no config schema** (`config/schema`
is absent).
