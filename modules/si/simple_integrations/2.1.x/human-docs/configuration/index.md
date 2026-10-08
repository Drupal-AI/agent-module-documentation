# Configuration

Simple Integrations is configured through **Integration** entities. There is an
important thing to understand up front: you **cannot create an Integration from the
admin UI**. Integrations are created as configuration that ships with a custom
module, and only then are they editable through the interface.

## Creating an Integration

To add a new Integration, place its YAML config in the `config/install/` directory of
your own custom module. When that module is installed, the Integration is imported
and appears under **Configuration → Integrations**, where its values become editable.
The project ships an example integration config that you can copy as a starting
point.

## The fields on an Integration

Each Integration entity holds:

- **External endpoint** — the base URL of the API you are connecting to.
- **Authentication type** — one of *none*, *headers*, *basic auth*, or
  *certificate*. If the service needs no authentication, set this to **none**.
- **Credentials** — the values matching the chosen authentication type (for example
  a username and password for basic auth).
- **Certificate path** — where the client certificate lives, when certificate auth
  is used.
- **Timeout** — how long a request may run before it is abandoned.
- **Active** — whether the integration is live. If an Integration is **not** active,
  no requests should be made; the connection client enforces this and refuses to run
  for an inactive integration.
- **Debug mode** — a flag you can check in your own code to trigger request logging,
  useful for recording which requests were made with which parameters. It is up to
  the developer to act on the flag.

## Running a connection test

Once an Integration exists, administrators with the **test integration connections**
permission can use the **Perform connection test** action. It sends a GET request to
the configured endpoint and reports the returned status, so you can confirm the
endpoint and credentials work before wiring the integration into real code. The test
route lives at `/admin/config/integrations/{integration}/test-connection`.

## Permissions

Access is split into three permissions so you can separate roles cleanly:

- **view integrations** — see the list of integrations.
- **administer integrations** — edit integrations. This is a *restricted*
  permission; grant it only to trusted administrators, since it exposes endpoints and
  credentials.
- **test integration connections** — run the connection test action.

## Using it from code

For developers: to make a request you obtain a `ConnectionClient`, give it a valid
Integration, and call `configure()` — the client then applies the integration's
configuration and credentials automatically. You can build a page controller by
extending the module's `ConnectionController`, or instantiate the client directly.
If you do not actually need any per‑integration configuration for a given request,
just use Drupal's core HTTP client instead.
