<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Natural Language Test — configuration, Drush & runtime

## Install / enable

```
composer require drupal/ai_nl_test drupal/key
drush en ai_nl_test
cd web/modules/contrib/ai_nl_test && npm install   # pulls the MCP SDK + Playwright MCP framework
```

Requires Node.js 18+ on the host. `TestRunnerService::runTest()` returns a failure immediately if
`node_modules/` is missing. There is no `.install` file.

## Config object `ai_nl_test.settings`

Schema `config/schema/ai_nl_test.schema.yml`:

| Key | Type | Meaning |
|---|---|---|
| `node_binary` | string | Path to the Node.js binary (form default `node`). |
| `script_timeout` | integer | Per-script timeout in seconds (form default 300). |
| `openai_api_key` | string | Key-module key **id**, or `_none` to use the env var. |
| `llm_model` | string | OpenAI model name (form default `gpt-5`). |
| `browser_headless` | boolean | Headless vs. headed browser. |
| `screenshots_dir` | string | Relative screenshots dir. |
| `reports_dir` | string | Relative reports dir. |

Caveat: the install-defaults file is `config/install/mcp_integration.settings.yml` (a leftover
machine name), so its values land under `mcp_integration.settings`, **not** `ai_nl_test.settings`.
Code and schema use `ai_nl_test.settings`; the form supplies `?:` fallbacks, so this is a cosmetic
/ dead-defaults bug, not a runtime blocker.

## Settings form `SettingsForm`

`src/Form/SettingsForm.php`, route `ai_nl_test.settings` at `/admin/config/system/ai-nl-test`,
`_permission: 'administer ai nl test'`. The permission string is **not defined** by the module
(no `*.permissions.yml`), so only user 1 (or another module defining it) can reach the form. The
form lists Key entities via `entity_type.manager` storage `key` for the `openai_api_key` select.
`getEditableConfigNames()` = `['ai_nl_test.settings']`.

## Drush command `mcp:test`

`src/Commands/McpIntegrationCommands.php` (registered in `drush.services.yml`). Alias `mcp-test`.
Options: `--folder`, `--filter`, `--tags` (comma-separated), `--headless`, `--list`.

```
drush mcp:test                 # discover + run all *.test.yml
drush mcp:test --list          # list discovered tests only
drush mcp:test --folder=smoke  # limit to a folder
drush mcp:test --filter=login  # name contains "login"
```

Headless is `--headless OR config browser_headless`. (README also references `mcp:run-test`,
`mcp:run-all-tests`, `mcp:list-tests`; only `mcp:test` is actually registered.)

## Services

- **`TestDiscoveryService`** (`ai_nl_test.test_discovery`) — `discoverTests($filters)` scans three
  locations for `*.test.yml`: this module's `tests/`, `core/tests/playwright`, and each
  `modules/contrib/*/tests/playwright`. It also has `discoverPhpUnitTests()` scanning contrib
  `tests/src` for `*Test.php`, extracting FQCN by regex. Filters: `folder`, `filter` (name
  substring), `tags`, `location`.
- **`TestRunnerService`** (`ai_nl_test.test_runner`, ctor arg `@?key.repository`):
  - `runTest($test_path, $options)` — resolves module path, checks `node_modules/`, builds
    `$runtime_config` (`llm.apiKey`, `browser.viewport`, `paths.screenshots|reports`), sets env
    `MCP_RUNTIME_CONFIG` (JSON), `OPENAI_API_KEY`, `PLAYWRIGHT_HEADLESS`, then runs
    `Process(['node', DRUPAL_ROOT.'/.../scripts/drupal_runner.js', $test_path])` with a null
    timeout. Returns `status`/`exit_code`/`output`/`error`. (Note: it hardcodes `'node'` and model
    `'gpt-5'` here rather than reading `node_binary`/`llm_model` config.)
  - `runPhpUnitTest($test_info, $options)` — builds a phpunit or `core/scripts/run-tests.sh`
    command with `escapeshellarg()` on every interpolated value and `exec()`s it.
  - `getOpenAiApiKey()` — Key entity value if `openai_api_key` is a real id and `key.repository`
    is available, else `getenv('OPENAI_API_KEY')`.

## Runtime (`scripts/drupal_runner.js`)

ES-module Node script. `loadRuntimeConfig()` requires `MCP_RUNTIME_CONFIG`; connects a
`@modelcontextprotocol/sdk` stdio client to the Playwright MCP server, streams the YAML steps to
the OpenAI model, executes returned tool calls against the browser, and writes an HTML report +
screenshots via `playwright-mcp-framework`. All model/browser I/O happens in Node, not PHP.

## Operating notes

- Everything that executes a test is CLI/Drush-gated; no web route runs tests, and the module
  serves no dashboard (the `mcp_dashboard` library/`js/mcp_client.js` is not attached anywhere).
- Store the OpenAI key as a Key entity (Configuration key type, or File/Environment provider) and
  select it in the form; otherwise export `OPENAI_API_KEY` in the CLI environment.
