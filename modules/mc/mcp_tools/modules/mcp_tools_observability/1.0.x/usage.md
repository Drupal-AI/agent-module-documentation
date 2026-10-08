Adds observability for MCP Tools: an event subscriber that logs every MCP tool execution — started, succeeded, failed — with timing and sanitized arguments to the mcp_tools log channel (watchdog / dblog).

---

`mcp_tools_observability` is an adapter submodule of MCP Tools. It registers one event subscriber, `ToolExecutionLogSubscriber`, that listens for the `code-wheel/mcp-events` lifecycle events dispatched by the parent's tool dispatcher (`ToolApiCallToolHandler`): `ToolExecutionStartedEvent`, `ToolExecutionSucceededEvent`, and `ToolExecutionFailedEvent`. Each is written as a structured log entry to the `mcp_tools` logger channel with the tool name, plugin id, request id, duration in milliseconds, and the (dispatcher-sanitized) arguments; succeeded/failed entries also include the structured result. Log levels are chosen by outcome: started → debug, succeeded → info, failed → warning (execution failures → error, dry-run policy → info). The module has no routes, permissions, config, or services beyond the subscriber, and adds no runtime behavior other than logging, so it is a safe drop-in for auditing what an AI assistant does through MCP Tools.

---

- Audit every MCP tool call an AI assistant makes on the site.
- Record tool execution timing (duration in ms) for performance monitoring.
- Capture failures with reason (validation, instantiation, access denied, execution, result) and exception details.
- Route MCP tool activity into the `mcp_tools` watchdog channel for review in Reports → Recent log messages.
- Feed MCP tool logs into an external log aggregator via a syslog/monolog sink on the channel.
- Distinguish successful vs failed tool runs by log severity.
- Trace a specific MCP request end-to-end via the shared request id across started/succeeded/failed entries.
- Keep an audit trail of write operations performed by remote or local MCP clients.
- Verify which tools a connection actually invoked (and with what arguments) during a session.
- Detect abuse or runaway agents by watching the rate of failed/denied tool executions.
- Confirm access-control denials are being enforced (failed events with the access-denied reason).
- Pair with the parent's audit logging and webhook notifications for layered observability.
