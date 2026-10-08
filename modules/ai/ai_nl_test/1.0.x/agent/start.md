<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Natural Language Test (ai_nl_test) — agent index

Runs plain-English browser regression tests by having an **LLM drive Playwright via the Model
Context Protocol (MCP)**. Tests are YAML (`*.test.yml`) with natural-language steps; a **Drush**
command discovers them and, per test, spawns a bundled Node runner that streams the steps to an
OpenAI model which calls browser tools to execute and assert. Package *Custom Integration*.
Core `^10 || ^11`, PHP `8.3`. License GPL-2.0-or-later. Version 1.0.0.

- **Settings form, config, services, Drush commands, runtime mechanics** →
  [config/settings.md](config/settings.md)

## Dependencies

- `key:key` (drupal/key `^1.0`) — secure storage of the OpenAI API key.
- core `system`, `serialization`, `file`.
- Runtime (not composer): Node.js 18+, `npm install` in the module dir pulling
  `@modelcontextprotocol/sdk` and `playwright-mcp-framework` (see `package.json`). Tests do not
  run until `node_modules/` exists.

## What it provides

- **One web route** (`ai_nl_test.routing.yml`): `ai_nl_test.settings` —
  `/admin/config/system/ai-nl-test`, `_form: SettingsForm`, `_permission: 'administer ai nl test'`.
  There is **no** `ai_nl_test.permissions.yml`, so that permission is undefined by this module
  (the form is effectively reachable only by user 1 unless another module defines it). No content
  routes, no controllers — nothing on the web runs a test.
- **Drush commands** (`drush.services.yml`, `src/Commands/McpIntegrationCommands.php`): `mcp:test`
  (alias `mcp-test`) with options `--folder`, `--filter`, `--tags`, `--headless`, `--list`.
  (The README also mentions `mcp:run-test` / `mcp:run-all-tests` / `mcp:list-tests`, but the code
  registers only `mcp:test`.)
- **Config** `ai_nl_test.settings` (schema `config/schema/ai_nl_test.schema.yml`): `node_binary`,
  `script_timeout`, `openai_api_key` (a Key entity id or `_none`), `llm_model`, `browser_headless`,
  `screenshots_dir`, `reports_dir`. NOTE: the install-defaults file is misnamed
  `config/install/mcp_integration.settings.yml`, so those defaults install under the wrong config
  name and are not applied to `ai_nl_test.settings` (the form's `?:` fallbacks cover this).
- **Services** (`ai_nl_test.services.yml`): `ai_nl_test.test_discovery` = `TestDiscoveryService`
  (scans module/core/contrib for `*.test.yml` and PHPUnit tests); `ai_nl_test.test_runner` =
  `TestRunnerService` (spawns the Node runner; resolves the API key via `@?key.repository` or env).
- **Library** `mcp_dashboard` (`js/mcp_client.js`) is declared but **no route attaches it** — no
  dashboard is served.

## Mechanism (from source)

- `McpIntegrationCommands::runTests()` → `TestRunnerService::discoverTests()` →
  `TestRunnerService::runTest($path)` builds `MCP_RUNTIME_CONFIG` + `OPENAI_API_KEY` env and runs
  `Symfony\Component\Process\Process(['node', scripts/drupal_runner.js, $test_path])` (array form,
  no shell). `runPhpUnitTest()` builds a phpunit/run-tests.sh command with `escapeshellarg()` on
  every argument and `exec()`s it. Both paths are CLI/Drush-only.
- `getOpenAiApiKey()` reads the selected Key entity's value, else `getenv('OPENAI_API_KEY')`; the
  key is passed only as a subprocess env var, never rendered or logged.
- `scripts/drupal_runner.js` reads `MCP_RUNTIME_CONFIG`, launches the Playwright MCP client, and
  loops LLM ↔ MCP tool calls, writing HTML reports/screenshots to `artifacts/`.
