Tool provides a plugin type for defining "well-defined actions" — self-describing units of work with typed inputs, typed outputs, an operation semantic (read/write/etc.), access checks, and a uniform execution/result contract — so the same action can be driven from Drush, an admin UI, or an AI/MCP function-call bridge without rewriting it.

---

Each tool is a plugin class extending `ToolBase` and carrying a `#[Tool]` attribute that declares its `id`, `label`, `description`, `operation` (`Explain`/`Read`/`Transform`/`Trigger`/`Write`, each with idempotency/modifying semantics), `destructive` flag, `input_definitions`, optional `input_definition_refiners`, `output_definitions`, and `forms`. Inputs/outputs are typed via the module's `InputDefinition` layer (built on core Typed Data), and a `TypedDataAdapter` plugin type maps each data type to schema/validation/coercion. A tool implements `doExecute(array $values): ExecutableResult` and `checkAccess()`; the base class runs input-transform events, executes, wraps success/failure in an `ExecutableResult`, and exposes results both raw (`getResult()`) and invoker-formatted (`getFormattedResult()`). An "invoker" string (e.g. the AI connector) is carried on pre/post events so subscribers can transform values per caller — notably the entity **handle** system, which downcasts entity outputs to opaque tempstore-backed handle strings (`ToolHandleStore`) so, e.g., an LLM never receives raw entity data it should not see, and can pass the handle back as input later. Normalizers serialize input/output definitions to JSON Schema for function-calling consumers. The module ships four Drush commands (`tool:list`, `tool:info`, `tool:run`, `tool:search`) and a single non-restricted `administer tool` permission (used by the Tool Explorer submodule). Tool core defines the framework only — it ships no ready-made tools; other modules provide `Plugin/tool/Tool/*` plugins. Two submodules extend it: `tool_ai_connector` exposes every tool as an AI-module function call, and `tool_explorer` adds an admin UI to browse and run tools.

---

- Define a reusable, self-describing "action" (send email, fetch entity, run a job) as a `#[Tool]` plugin.
- Declare typed, validated inputs and outputs for an action instead of ad-hoc array shapes.
- Tag an action's semantics with an operation (`Read`/`Write`/`Transform`/`Trigger`/`Explain`) and a `destructive` flag.
- Run any tool from the CLI with `drush tool:run <id> --input='{...}'`.
- List and search available tools from Drush (`tool:list`, `tool:search "email send"`).
- Inspect a tool's inputs/outputs/schema as a table, markdown, or JSON (`tool:info <id> --format=json`).
- Enforce per-tool access with a `checkAccess()` method that all callers (CLI/UI/AI) honor uniformly.
- Execute a tool as a specific user for permission testing (`drush tool:run --uid=2`).
- Expose an action to an LLM as a function call by enabling `tool_ai_connector` (no per-tool wiring).
- Give site admins a UI to browse and manually execute tools via `tool_explorer`.
- Return structured outputs from an action and read them via `getOutputValues()` / formatted result.
- Get a uniform success/failure + message result object (`ExecutableResult`) from every action.
- Serialize a tool's input definitions to JSON Schema for a function-calling / MCP client.
- Transform an entity output into an opaque handle so a caller (e.g. an LLM) never sees unviewable data.
- Pass an entity handle from one tool call as the input to a later tool call in the same request.
- Coerce and validate incoming values per data type using `TypedDataAdapter` plugins.
- Refine input definitions dynamically based on other inputs (`input_definition_refiners` + refiner interface).
- Attach configure/execute forms to a tool for admin-driven use, reusing the same plugin.
- React to or rewrite a tool's inputs/outputs per caller by subscribing to the transform events.
- Provide a `field_exists` validation constraint for tools that take a field-name input.
- Build a deterministic automation layer that the same code can expose to humans, CLI, and AI.
- Add a new value type to the framework by implementing a `TypedDataAdapter` plugin.
- Alter discovered tool definitions across the site with `hook_tool_info_alter()`.
- Distinguish "executed" vs "has a result" (e.g. failure recorded before execution) for retry/telemetry logic.
