<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Observability (mcp_tools_observability) — agent index

Adapter submodule of **MCP Tools**. Logs every MCP tool execution (started / succeeded / failed) to
the `mcp_tools` watchdog channel via one event subscriber. Depends on `mcp_tools`. No routes,
permissions, or config. Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version dir 1.0.x
(installed 1.0.0-beta8).

- **The event subscriber and what it logs** → [events/logging.md](events/logging.md)

## What it provides (from source)

- `src/EventSubscriber/ToolExecutionLogSubscriber.php` — subscribes to `code-wheel/mcp-events`
  `ToolExecutionStartedEvent` (→ `onStarted`, debug), `ToolExecutionSucceededEvent` (→ `onSucceeded`,
  info), `ToolExecutionFailedEvent` (→ `onFailed`, warning; `REASON_EXECUTION` → error,
  `REASON_POLICY_DRY_RUN` → info).
- `mcp_tools_observability.services.yml` — registers the subscriber (`event_subscriber` tag) with
  the parent's `@logger.channel.mcp_tools` channel.

These events are dispatched by the parent's `ToolApiCallToolHandler` around tool execution; the
arguments carried in them are already redacted for sensitive keys by the dispatcher.
