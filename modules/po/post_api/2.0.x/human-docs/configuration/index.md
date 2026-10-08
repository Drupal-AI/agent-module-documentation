# Configuration

Post API is mostly configured **in code** — the endpoint path and payload for each request are
set when your module adds an item to the queue (see the
[manual setup guide](../index.md)). What the admin UI gives you is a way to watch and manage the
queue, plus two permissions that control who can do so.

## The queue management UI

Go to **Configuration → Web Services → Post API → Queue**
(`/admin/config/post-api/queue`). This is a basic queue management screen where you can:

- **Review** the items currently waiting in the Post API queue.
- **Process** the queue manually, rather than waiting for the next cron run.

In normal operation the queue is drained automatically on **cron**, so day‑to‑day you may not
need this page — it's most useful for debugging a stuck integration or forcing an immediate
send.

## Permissions

On **People → Permissions** (`/admin/people/permissions`), grant these as appropriate:

- **Administer post api settings** — control of the module's settings.
- **Access post api queue ui** — access to the queue management screen described above.

Grant both only to trusted administrators, since processing the queue triggers real outbound
requests to your external endpoints.

## Where to keep credentials

Post API sends data to endpoints you choose, and those endpoints usually require authentication
(an API key, a bearer token, and so on). Post API does not store those secrets for you — your
code supplies them when it builds the request. **Keep them out of the database and out of version
control:** store each secret in an environment variable (with DDEV,
`ddev dotenv set .ddev/.env --my-endpoint-key=…` then `ddev restart`) and read it from your code
(for example with `getenv()` or, where appropriate, a **Key** entity) when you assemble the
payload or headers. Always send to endpoints over HTTPS.
