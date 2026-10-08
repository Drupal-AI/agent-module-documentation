# Tool — manual setup guide

**Tool** (`tool`) provides a plugin type for defining "well-defined actions" — self-
describing units of work with typed inputs, typed outputs, an operation semantic
(read/write/etc.), an access check, and a uniform execution/result contract. The point is
that you write an action once and the same code can be driven from Drush, from an admin UI,
or from an AI / MCP function-call bridge, without rewriting it for each caller.

Each tool is a small PHP plugin class carrying a `#[Tool]` attribute that declares its id,
label, description, operation, whether it is destructive, and its input and output
definitions. Inputs and outputs are typed (built on Drupal's Typed Data), so callers get
validation and, for function-calling clients, a JSON Schema. A notable feature is the
**entity handle** system: entity outputs can be downcast to opaque, tempstore-backed handle
strings, so — for example — an LLM never receives raw entity data it should not see, yet can
pass the handle back as input to a later call.

**Tool is a framework, not a ready-made tool.** The base module ships no concrete actions —
other modules provide them under `Plugin/tool/Tool/`. It has no admin settings page. Two
submodules extend it: `tool_ai_connector` exposes every tool as an AI-module function call,
and `tool_explorer` adds an admin UI to browse and run tools.

This guide is written for a **human** (here, mostly a developer) working through the setup.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   pick the submodules you need.

## How to use it

Tool has no configuration UI in the base module — you use it by writing tool plugins and
running them.

**Write a tool.** Add a class in `your_module/src/Plugin/tool/Tool/` that extends
`ToolBase` and carries a `#[Tool]` attribute declaring its `id`, `label`, `description`,
`operation` (`Explain` / `Read` / `Transform` / `Trigger` / `Write`), a `destructive` flag,
and typed `input_definitions` / `output_definitions`. Implement two methods:
`doExecute(array $values): ExecutableResult` (the work) and `checkAccess()` (who may run
it). The full plugin reference — attribute fields, input-definition variants, results, and
the typed-data adapter plugin type for teaching the framework new value types — is in the
[`agent/`](../agent/start.md) docs.

**Run a tool from Drush** (the base module ships four commands):

| Command | What it does |
|---------|--------------|
| `drush tool:list` | List available tools. |
| `drush tool:search "email send"` | Search tools by keyword. |
| `drush tool:info <id>` | Show a tool's inputs/outputs/schema (as a table, markdown, or `--format=json`). |
| `drush tool:run <id> --input='{...}'` | Execute a tool; add `--uid=2` to run as a specific user for permission testing. |

**Run a tool from an admin UI or from AI.** Enable the submodules below — `tool_explorer`
for a click-through UI, `tool_ai_connector` to expose every tool to the AI module's
function calling with no per-tool wiring.

### Permission

The base module defines one permission, **Administer tool** (not a restricted permission).
It is consumed by the Tool Explorer submodule to gate its browse-and-run UI. There is
nothing else to configure in the base module.
