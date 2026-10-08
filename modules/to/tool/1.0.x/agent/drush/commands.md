# Tool Drush commands

Four commands (registered via Drush attributes in `src/Drush/Commands/`, autowired — no
`drush.services.yml`). All operate on the `plugin.manager.tool` definitions.

## `tool:list` (aliases `tools`, `tlist`)

List all tools.

```bash
ddev drush tool:list
ddev drush tool:list --format=markdown          # full descriptions as markdown
ddev drush tool:list --operation=read           # filter: explain|read|transform|trigger|write
```

## `tool:search <keywords>` (aliases `tsearch`)

Search id + label + description.

```bash
ddev drush tool:search "email send"             # OR match (default)
ddev drush tool:search "email send" --match=and # AND match
ddev drush tool:search "email" --operation=read --format=markdown
```

## `tool:info <tool_id>` (aliases `tinfo`)

Show one tool's label/description/operation/`destructive`/provider plus input & output definition
tables and a ready-to-run usage example.

```bash
ddev drush tool:info greeting_tool
ddev drush tool:info greeting_tool --format=markdown
ddev drush tool:info greeting_tool --format=json     # machine-readable, incl. locked inputs
```

## `tool:run <tool_id>` (aliases `trun`)

Execute a tool.

```bash
# JSON input:
ddev drush tool:run greeting_tool --input='{"name":"Ada","greeting":"Hi"}'
# key=value inputs (repeatable; values may themselves be JSON for complex types):
ddev drush tool:run greeting_tool --input=name=Ada --input=greeting=Hi
# run as a specific user (permission testing); DEFAULT is --uid=1 (admin):
ddev drush tool:run greeting_tool --uid=2 --input=name=Ada
# machine-readable result:
ddev drush tool:run greeting_tool --input='{"name":"Ada"}' --json
```

Behavior:
- `--uid` switches the account (`AccountSwitcherInterface`) around execution; **defaults to `1`
  (admin)**. Access is then enforced by the tool's own `checkAccess()`.
- Inputs are parsed as JSON first, else `key=value` (value re-parsed as JSON when possible), then set
  via `setInputValue()` (which runs input-transform events).
- Exit code: `0` on success, non-zero on missing tool / unknown user / input error / access denial /
  failed result. Outputs are read only on success.
