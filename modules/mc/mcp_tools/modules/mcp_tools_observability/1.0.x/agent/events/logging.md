<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools Observability — tool-execution logging

## Enable

`drush en mcp_tools_observability -y` (needs `mcp_tools`). No config; logging starts immediately.

## The subscriber

`ToolExecutionLogSubscriber` (`src/EventSubscriber/`) implements `EventSubscriberInterface` and maps
the three `code-wheel/mcp-events` lifecycle events to handlers:

| Event | Handler | Level |
| --- | --- | --- |
| `ToolExecutionStartedEvent` | `onStarted` | debug |
| `ToolExecutionSucceededEvent` | `onSucceeded` | info |
| `ToolExecutionFailedEvent` | `onFailed` | warning* |

*`onFailed` escalates by `reason`: `REASON_EXECUTION` → error, `REASON_POLICY_DRY_RUN` → info,
everything else → warning.

## Logged context

Written to the parent's `@logger.channel.mcp_tools` (so entries appear under the `mcp_tools`
channel in dblog). Fields: `tool_name`, `plugin_id`, `request_id`, `arguments`, plus `duration_ms`
(succeeded/failed), `structured` (the result's structured content), `reason` (failed), and
`exception` / `exception_message` when an exception is present.

## Notes

- The `arguments` in these events are the dispatcher's **sanitized** copy — keys containing
  password/secret/token/key/api_key are `[REDACTED]` (see `ToolApiCallToolHandler::sanitizeArguments`).
- `structured` on succeeded/failed events is the tool's structured result; a tool that returns
  configuration or entity data will have that data in the log. Watchdog entries are viewable only by
  users with `access site reports`, but treat the `mcp_tools` channel as sensitive when routing it
  to an external sink.
- The subscriber only logs; it never blocks or alters tool execution.
