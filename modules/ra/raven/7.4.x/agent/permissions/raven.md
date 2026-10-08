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

Note: the test routes `raven.test` / `raven.test.logs` (the "Send test message"
buttons on the logging form) instead require the core
`administer site configuration` permission.
