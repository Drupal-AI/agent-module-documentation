# Configuration

You manage webhooks at **Configuration → Web services → Webhooks**
(`/admin/config/services/webhook`), which requires the **Administer webhooks**
permission. Click **Add webhook** to create one. Each webhook is either
**incoming** or **outgoing**, and the form shows the fields relevant to the type
you pick.

## The add/edit form, field by field

- **Label** and **Machine name** — the human name and internal id. The machine
  name is what appears in the incoming URL (`/webhook/{machine_name}`).
- **Type** — **Incoming** (this site receives HTTP events) or **Outgoing** (this
  site POSTs events to a URL). The type is locked once the webhook is created.
- **Content type** — the payload format, `application/json` or `application/xml`.
- **Secret** — a shared HMAC secret. On an **outgoing** webhook it signs the
  payload (the receiver can verify it); on an **incoming** webhook it verifies the
  sender's signature. Leaving it blank when editing keeps the existing value.
- **Token** — an older-style shared token, verified from an `X-…-Token` header on
  incoming requests. Prefer the secret/signature approach for new integrations.
- **Payload URL** *(outgoing only)* — the target URL that receives the POST.
  Incoming webhooks do not need one; the form stores a placeholder for them.
- **Events** *(outgoing only)* — a table of exactly which events to send: create /
  update / delete for each content entity type, plus system events like cron,
  file download, module install, user login, user logout, user cancel, and cache
  flush. Other modules can add custom events to this list.
- **Non-blocking** *(incoming only)* — queue received webhooks and process them in
  the background (on cron) instead of handling them inline. This keeps your
  response to the sender fast.
- **Status** — whether the webhook is active. Only active webhooks fire or accept
  requests.

An outgoing webhook must have a payload URL and at least one selected event.

## How incoming webhooks are secured

The incoming endpoint (`POST /webhook/{machine_name}`) is intentionally open — it
has to be, so third parties can reach it. Security comes from the secret or token:

- If the webhook has a **secret** (or the request carries a signature), Webhooks
  verifies the HMAC signature using a timing-safe comparison and rejects a
  mismatch with a 401.
- If only a **token** is set, it verifies that instead.
- If a webhook has neither a secret nor a token *and* the request sends no
  signature or token, no verification runs — an intentionally open receiver. For
  anything sensitive, always set a secret.

Give each incoming webhook a strong secret and keep it out of exported
configuration (set it per environment).

## Module settings

The settings form at
**Configuration → Web services → Webhooks → Settings**
(`/admin/config/services/webhook/settings`) has one option:

- **Reliable queue** *(default off)* — use the reliable (durable) queue backend
  for background processing of non-blocking incoming webhooks. It is more robust
  but a little slower than the default queue.

## Toggling and testing

From the webhook list you can flip a webhook active or inactive. To test an
outgoing endpoint without waiting for a real event, use Drush:

```bash
drush webhooks:trigger entity:node:create --payload='{"ping":"pong"}'
drush webhooks:list
```

`webhooks:trigger` sends a test payload to every active outgoing webhook
subscribed to the given event; `webhooks:list` shows all configured webhooks with
their type and status.
