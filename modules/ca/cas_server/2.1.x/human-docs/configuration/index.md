# Configuration

There are two parts to configuring CAS Server: the **global settings** (ticket
lifetimes, login behaviour, messages) and the **service definitions** (one per
application that may delegate login to you). You need at least one service definition
before the server does anything useful. All of the admin screens require the
**Administer site configuration** permission.

## Global settings

Go to **Configuration → People → CAS Server → Settings**
(`/admin/config/people/cas_server/settings`).

### Ticket lifetimes (in seconds)

- **Login ticket timeout** — default `900`.
- **Service ticket timeout** — default `10` (service tickets are meant to be
  redeemed immediately).
- **Proxy ticket timeout** — default `10`.
- **Proxy‑granting ticket timeout** — default `7200`.
- **Ticket‑granting ticket timeout** — default `28800` (the SSO session length).

Expired tickets are purged automatically on cron.

### Login and SSO behaviour

- **Ticket‑granting ticket auth** — off by default. When on, the server issues a
  ticket‑granting **cookie** (`cas_tgc`) so single sign‑on works across services
  (a returning user is not re‑prompted). When off, SSO relies on the Drupal session.
- **Ticket username attribute** — which value is sent to services as the CAS
  username: the account **name** (default), **mail**, or **uid**.
- **Login username attribute** — which field a user may type at the CAS login form:
  **name** (default), **mail**, or **both**.
- **Reset password link** — off by default; when on, shows a "Reset your password"
  link on the CAS login form.

### Messages

Override the default text shown on four pages: **invalid service**, **not
permitted**, **user logout**, and **logged in**.

### Debugging

- **Debug log** — off by default; when on, logs the ticket‑validation flow for
  troubleshooting.

## Service definitions

Go to **Configuration → People → CAS Server → Services**
(`/admin/config/people/cas_server/services`) to list, add, edit, and delete service
definitions. Each one describes one application allowed to use your login server.

- **Label** — a human name for the service.
- **Service** — the **URL pattern** an incoming `service=` URL must match, where `*`
  is a wildcard. Matching is done against the service URL, so keep patterns **tight**:
  a broad pattern like `https://*` would allow *any* site to use your login server.
  Prefer something like `https://app.example.com/*`.
- **SSO** — when enabled, logging in to this service starts a single sign‑on session
  (and issues the ticket‑granting cookie if that is turned on); when disabled, it
  authenticates for that one request only. Proxy authentication requires the target
  service to be SSO‑enabled.
- **Attributes** — a list of **user field names** to release to the service on
  successful validation (for example the user's mail or a custom profile field).
  Only real user fields are accepted.
- **Roles to authenticate with this service** — a per‑service role restriction.
  Ticking roles here grants them the dynamic "log in to this service" permission.
  This section only appears to admins who also hold the **Administer permissions**
  permission. Admin roles and anyone with "log in to any service" are always allowed;
  anonymous is always disallowed.

## Permissions

- **CAS server login to any service** — the holder may authenticate to **every**
  registered service. Treat this as sensitive: it grants access to all connected
  applications.
- **CAS server login to {service} service** — a dynamic permission generated for
  each service definition; the holder may authenticate to that specific service. You
  can set these on the normal **People → Permissions** page or via the service edit
  form's role checkboxes.
- **Administer site configuration** (core) — required for all the CAS Server admin
  screens.

Admin roles are always treated as permitted, and anonymous users can reach
`/cas/login` to authenticate but cannot hold a "log in to service" grant.

## Security reminders

- Run the whole thing over **HTTPS**.
- Do not co‑install the CAS *client* module.
- Keep service URL patterns as specific as possible.
