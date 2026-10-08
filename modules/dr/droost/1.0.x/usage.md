<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost exposes Drupal application/codebase introspection plus tiered, gated write, database, entity, config, scaffold and PHP-eval tools to AI coding agents over MCP — for local development only.

---

Droost is the Drupal analog of Laravel Boost: a local-development toolkit, built on the MCP Server module (`drupal/mcp_server`), that lets an AI coding agent query a real Drupal site about itself and then act on it deterministically. It registers a large set of MCP `#[Tool]` plugins that return structured JSON — application info, entity/field definitions, routes, services (with the interface to type-hint for autowiring), permissions, configuration (secrets redacted), a database schema, logs, and the last error — so an agent gets version-correct answers instead of guessing or parsing Drush text. Beyond read-only introspection it adds a tiered write surface: set configuration, run single-verb raw SQL (read/create/update/delete tiers), entity CRUD, install/uninstall modules, run cron, rebuild caches, scaffold convention-correct code and tests from blueprints, author structural config (fields, bundles, view modes), verify code with phpcs/phpstan/phpunit, and evaluate arbitrary PHP. Every state-changing tool is registered but disabled by default, refusing to act until the operator opts in through a per-category `droost.settings` flag; the RCE-class eval tool and all state-changers additionally refuse to run over anything but the local CLI/STDIO transport. A Drush command (`drush droost:install`) wires the MCP server into your coding agent's harness (Claude Code, Codex, Gemini, Qwen, opencode) and writes Droost guidance into managed regions of the harness config, reversibly. The module is deliberately in the same class as `devel`/`devel_php`/`webprofiler`: its gates reduce footguns but are explicitly not a security boundary against an untrusted caller. Install it with `require-dev` and enable it only on local, trusted development environments — never in production or on an internet-reachable site.

---

- Ask a Drupal site which modules, versions, entity types and fields it actually has, over MCP.
- Discover which interface to type-hint (and its former name) to autowire a service mid-edit.
- Read routes, permissions and services as structured JSON instead of parsing Drush output.
- Read a config object with credential-looking keys automatically redacted.
- List config object names by prefix (e.g. all `views.view.*`).
- Run a bounded read-only SQL query (SELECT/WITH/SHOW/DESCRIBE/EXPLAIN) and get rows back.
- Inspect the live database schema of a table or the whole site.
- Read recent watchdog log entries and the last logged error to debug a failed request.
- Load one entity's raw field values (name-based secret redaction) for local debugging.
- Resolve an internal path or route (with parameters) to a correct absolute URL.
- List Single-Directory Components (SDC) and available replacement tokens.
- Opt in per risk-class to a gated write surface: config, DB, entity, module ops, scaffold, eval.
- Set a single value on an existing config object (Droost's own config is refused).
- Run a single INSERT/UPDATE/DELETE with intent guards (no-WHERE and multi-statement refusals).
- Create, update or delete entities through the entity API, protecting critical records.
- Install or uninstall modules, run cron, or rebuild caches from the agent.
- Scaffold green-by-default Drupal patterns (services, plugins, entities, forms, tests, MCP tools) into a custom module.
- Author structural config over MCP: create a field (reusing compatible storage), a bundle, or a view mode.
- Run the QA loop (phpcs + phpstan, opt-in phpunit/deprecations) and get per-finding results without leaving MCP.
- Evaluate arbitrary PHP in the bootstrapped Drupal context (the Tinker analog), CLI-only and off by default.
- Wire the MCP server into Claude Code / Codex / Gemini / Qwen / opencode with one reversible Drush command.
- Write and later remove Droost guidance in managed regions of AGENTS.md and harness config files.
- Check knowledge-store freshness and dangerous opt-in flags from the Drupal status report.
- Generate Drupal code and run a plan → code → test → document → complete work pipeline (with submodules).
