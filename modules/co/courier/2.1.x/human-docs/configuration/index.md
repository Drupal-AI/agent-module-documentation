# Configuration

Courier is an API module, so its own configuration is intentionally small — most of
the real setup (channels, template collections, contexts) is done by the module
that drives Courier, or in code. What you configure directly is how messages are
sent and who can administer it.

## Open the settings form

1. Log in as a user with the restricted **Administer courier** permission.
2. Go to **Configuration → Communication → Courier**, or navigate directly to
   `/admin/config/communication/courier`.

Settings are stored in the `courier.settings` config object.

## Settings

- **Skip queue** (`skip_queue`, default **off**) — when off, Courier saves each
  message to its queue and sends it in the background on cron, which keeps the
  page request fast. Turn it on to send messages **in the same request** instead.
  This is convenient for time‑sensitive messages but, as the module warns, can
  impact performance significantly on busy sites.
- **Channel preferences** (`channel_preferences`) — for each identity (recipient)
  type, the ordered list of channels to try. The default maps the **user** identity
  type to the **email** channel (`courier_email`). If you add more channels (for
  example SMS), list them here in the order Courier should prefer them per identity
  type.

Click **Save configuration** to apply.

## Maintenance form

A separate **Maintenance** form at **Configuration → Communication → Courier →
Maintenance** (`/admin/config/communication/courier/maintenance`) provides
housekeeping operations for Courier's stored messages and queue. It also requires
the *Administer courier* permission.

## Permissions

Courier defines two permissions (at **People → Permissions**):

- **Administer courier** *(restricted)* — access to the settings and maintenance
  forms above. Grant to trusted administrators only.
- **Courier bypass queue** — lets a caller skip the message queue and send in the
  same request. This is a performance/behavior toggle rather than an access‑control
  boundary, and (like *Skip queue*) can affect performance.

> **Note on the email entity:** the bundled `courier_email` entity is guarded by an
> `administer courier_email` permission that this module does **not** define, so by
> default its view/edit/delete routes are effectively locked down (only user 1, or a
> role granted every permission, can reach them) unless another module — such as the
> Courier System submodule — grants access. This is by design for a framework whose
> messages are normally managed programmatically.

## Sending in the background

If you leave **Skip queue** off (the recommended default), make sure **cron runs
regularly** on your site, since queued messages are processed by Courier's queue
worker on cron. Without cron, queued messages won't be delivered.
