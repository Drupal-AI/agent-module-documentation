# Configuration

Configuring Microsoft Graph API is about two things: **registering an app in
Microsoft Azure / Entra ID** (this is where the important permission decisions
live), and **creating the Key entities in Drupal** that hold the resulting
credentials for the client to use.

> The module's own README carries the exact, current click-path for the Azure
> registration and the key fields. This page explains what you're setting up and
> the decisions that matter; follow the README for the precise steps.

## Step 1 — register an app in Azure / Entra ID

In the Azure portal, create an **app registration** for this Drupal site. You'll
end up with:

- A **Directory (tenant) ID** and an **Application (client) ID**.
- A **client secret** generated for the app.
- A set of **Microsoft Graph API permissions (scopes)** granted to the app.

**Get the permissions right — this is the crux.** Grant the **minimum** scopes
your integration actually needs, and prefer **delegated** permissions (acting as
a signed-in user) over **application** permissions (acting as the app itself)
wherever the use case allows. Broad scopes like `User.Read.All` or
`Directory.Read.All` expose your whole organisation's directory to whoever holds
the credential — and a Drupal site holding an application-permission credential is
effectively a standing directory-read capability on a web server. Rotate the
client secret periodically, and re-audit the granted scopes.

## Step 2 — store the credentials as Key entities in Drupal

This module uses the **[Key](https://www.drupal.org/project/key)** module, so the
client secret is stored as a **Key entity**, not as plain configuration:

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`).
2. Create the Key(s) the module expects — including an **MS Graph API Key** type
   that carries the tenant ID, client ID, and a reference to the client secret,
   as described in the module's README.
3. For the **client secret**, use a key provider that keeps it out of
   configuration and version control — ideally the **environment** provider, so
   the secret lives in an environment variable. With DDEV you can store it with
   `ddev dotenv set .ddev/.env --ms-graph-client-secret=<value>` (restart DDEV
   afterwards), confirm it's present in the container without printing it
   (`ddev exec 'test -n "$MS_GRAPH_CLIENT_SECRET"'`), then point an env-backed Key
   at that variable.

### Default key vs. custom keys

- **Single Azure subscription:** configure the **default** key, and consuming
  code gets an authenticated client from the `ms_graph_api.graph` service.
- **Multiple Azure subscriptions:** you don't have to use the default key —
  instead define a separate **MS Graph API Key** for each deployment, and code
  builds a client per key via the `ms_graph_api.graph.factory` service and
  `buildGraphFromKeyId('your_key_id')`.

## Verify it worked

Because this module has no UI feature, verification is a code check: have a
module (or a quick `drush php:eval`) obtain the `ms_graph_api.graph` service and
make a simple Graph request (for example `GET /me` for a delegated setup). A
successful response confirms the app registration, permissions, and Key wiring
are all correct.
