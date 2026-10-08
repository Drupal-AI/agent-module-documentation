<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Raven permissions

Defined in `raven.permissions.yml`:

| Permission | Gates |
|---|---|
| `send javascript errors to sentry` | The user's browser loads/initializes the Sentry JavaScript SDK so JS errors are captured and sent to Sentry. Also required to POST to the `/raven/tunnel` route (`raven.tunnel`). |
| `send performance traces to sentry` | The user's browser sends Sentry performance traces (browser tracing). |

Grant them per role:

```bash
drush role:perm:add anonymous 'send javascript errors to sentry'
drush role:perm:add authenticated 'send performance traces to sentry'
```

Routes and their access (`raven.routing.yml`):

- `raven.tunnel` (`POST /raven/tunnel`) — `_permission: 'send javascript errors to sentry'`.
  `TunnelController::doTunnel()` only forwards to the Sentry endpoint whose DSN
  matches the configured `public_dsn` (compared with `hash_equals`).
- `raven.test` (`POST /raven/test`) and `raven.test.logs` (`POST /raven/test/logs`) —
  both require the core `administer site configuration` permission and JSON content;
  these back the "Send test message" buttons on the logging form.
