# Configuration

SODa SCS manager needs its external services connected before it can provision
anything. All of that lives on one settings form, and access to the whole
platform is governed by two permissions.

## Open the settings form

Go to **Configuration → SODa SCS manager → Settings**
(`/admin/config/soda-scs-manager/settings`). This form requires the **soda scs
manager admin** permission.

Here you configure the endpoints and credentials the action services use:

- **Portainer / Docker** — the base URL and API token. These are used by the
  Portainer and Docker action services that create, run and exec containers, and
  manage volumes and the registry. Treat the Portainer token as a high-value
  secret.
- **Keycloak** — the realm and client used by OIDC login and the Keycloak action
  services. Because the module disables core's own `user.login` and `user.pass`
  routes, Keycloak/OIDC becomes the way users authenticate, so this must be
  configured for login to work.
- **Nextcloud** — the endpoint and the Login-Flow-v2 connection. Mount
  credentials are stored via an encrypted credentials store.
- **Triplestore / OpenGDB** — the endpoint used by the OpenGDB action service.

## The permission model

Access is layered into two permissions, granted at **People → Permissions**:

- **soda scs manager user** — required by almost every route. Owner-scoped access
  handlers restrict editing, deleting, snapshotting and service-linking a resource
  to that resource's owner, so ordinary users manage only their own stacks and
  components.
- **soda scs manager admin** — required for destructive or global operations: the
  settings form, service keys, automated updates across all components, and the
  debug tools.

Site administrators with *administer site configuration* have full access as
usual.

## User registration and approval

- New users register at **`/user/register`**, which presents a Keycloak-backed
  form. Registration does not provision anything on its own — it inserts a
  *pending* record for admin approval.
- Approve or reject pending registrations at
  **`/admin/people/keycloak-registrations`**, which requires the *administer
  users* permission.

## Admin tools

- **Debug tools** are at `/soda-scs-manager/debug`, and snapshot-integrity checks
  at `/soda-scs-manager/debug/snapshots`. Both are admin-only.
- **Snapshots** provide backup and restore of stack data; **Service Keys** are
  managed as their own entities.

## Security reminders

- Treat the **Portainer token** and the **Keycloak and Nextcloud credentials** as
  high-value secrets — anyone holding them can act on the underlying
  infrastructure.
- Every Docker exec/run route is gated by owner or admin access; the commands are
  built server-side, and the review of this module found no disabled TLS and no
  hardcoded secrets. Keep it that way by supplying credentials through
  configuration, Key entities or Service-Key entities rather than pasting them
  into code or exported YAML.
