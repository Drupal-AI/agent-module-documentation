# Configuration

Audit Trail's configuration is about three things: the **HMAC key** that makes the
log tamper-evident, **who may read the trail**, and **what gets audited**.

## Open the settings form

1. Log in as an administrator.
2. Go to the **Extend** (module list) page and follow Audit Trail's **Configure**
   link, which opens its settings form (route `audit_trail.settings_form`).

This is where you configure what is audited and how the chained logger behaves.

## Set the HMAC key — keep it secret

The tamper-evidence depends entirely on the secrecy of the HMAC key: its secrecy
is what makes undetected tampering detectable. Do **not** store the key in
committed configuration. Keep it as a real secret in an environment variable:

- With DDEV, save the value into the container's environment, for example
  `ddev dotenv set .ddev/.env --audit-trail-hmac-key=<value>` (keep `.ddev/.env`
  out of version control), then `ddev restart`.
- Reference that environment variable from the module's key setting — via a **Key**
  entity (env provider) where supported, or `getenv()` from settings — so the
  secret never lands in exported config.

## Grant the permissions

Audit Trail provides its own permissions. On **People → Permissions**, grant the
audit-viewer permission **only to trusted administrators** — audit logs record who
did what and may contain sensitive detail.

## Record events

Any module can route its log messages into the tamper-evident chained logger by
adding `chain: TRUE` to the log context; the submodules (entity, file, user auth,
…) do this for you for the areas they cover. The canonical `event()` write API is
available for custom code that needs to record audit events directly.

## Read and verify the trail

- **Viewer** — the admin viewer lists audit events and offers a side-by-side
  **diff** so you can see exactly what changed.
- **Chain verifier** — run the built-in verifier periodically to confirm the chain
  is intact and nothing has been altered or removed.
- **Drush** — Audit Trail provides Drush commands, so verification and maintenance
  can also run from the command line (handy in CI or on a schedule).

## Trusted timestamping (optional)

If you enabled the **TSA** submodule (`audit_trail_tsa`), entries can carry trusted
timestamps from a timestamping authority, strengthening the evidentiary value of
the trail.
