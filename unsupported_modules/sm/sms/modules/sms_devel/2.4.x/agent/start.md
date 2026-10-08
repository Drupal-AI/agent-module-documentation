# SMS Devel (`sms_devel`) — agent index

Submodule of SMS Framework. Developer tool: an admin form to send/simulate test SMS. Not for
production. No config, schema, or Drush.

- Route `sms_devel.message` → **`/admin/config/development/sms`**, permission
  **`sms_devel form`** ("Send any message").
- `SmsDevelMessageForm` composes and dispatches test messages through the configured gateways
  (and can exercise incoming/simulation paths) for debugging gateway config, routing, events,
  and delivery reports.
- Depends on `sms`. No solution docs needed.
- Parent: [../../../../2.4.x/agent/start.md](../../../../2.4.x/agent/start.md)
