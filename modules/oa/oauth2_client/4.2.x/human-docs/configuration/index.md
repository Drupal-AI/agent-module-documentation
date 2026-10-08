# Configuration

The admin side of OAuth2 Client is about creating **OAuth2 client** entities: each
one pairs a client plugin (which a developer has written to describe a provider)
with the credentials for your account on that provider.

> **Before you start:** a matching **client plugin** must exist in code. Plugins
> describe the provider's endpoints and grant type; they are written by a
> developer (see the `agent/` docs and the `oauth2_client_example_plugins`
> submodule for examples). The admin UI can only reference plugins that already
> exist.

## Open the OAuth2 clients list

1. Log in as a user with the **Administer oauth2 clients** permission. This is a
   restricted, sensitive permission — grant it only to trusted administrators.
2. Go to **Configuration → System → OAuth2 Client**, or navigate directly to
   `/admin/config/system/oauth2-client`.

Here you can add a new client, and edit, enable, or disable existing ones.

## Add a client

Click **Add OAuth2 client** and fill in the fields:

- **Label** — a human‑friendly name for this client (for example "GitHub API").
- **Machine name** — the internal id, generated from the label.
- **Description** — optional notes about what the client is for.
- **Plugin** — which client plugin (provider) this client uses. Pick from the
  plugins available on your site.
- **Credential provider** — where the client id and secret are stored. Choose
  either:
  - **Key** *(recommended)* — read the credentials from a **Key** entity. This
    keeps secrets out of configuration and lets you source them from an
    environment variable. Requires the Key module.
  - **OAuth2 Client (State)** — store the credentials in Drupal's State store.
- **Credential storage key** — depending on the provider you chose above, this is
  either the **id of the Key entity** to read from, or the **State key name**
  under which the credentials are stored.

A new client is **disabled by default**, and stays disabled until its credentials
are in place — so set up the credentials before you expect it to work.

## Keep credentials out of configuration

This is the most important point. The client id and secret are **never** stored in
the OAuth2 client entity, so they are never written into exported configuration.
They live only in the credential store you selected above.

The recommended approach is:

1. Put the secret in an **environment variable** (never hard‑code it, never commit
   it to version control).
2. Create a **Key** entity whose provider reads that environment variable.
3. On the OAuth2 client, set **Credential provider** to **Key** and point
   **Credential storage key** at that Key entity.

That way, exported configuration only names the Key — never the secret itself —
and each environment supplies its own credentials through its own environment
variables.

## Configure the provider's redirect/callback URL

For interactive **authorization code** flows, the remote provider needs to know
the URL to send the user back to after they approve access. The module exposes a
code‑capture route for this (of the form `/oauth2-client/{plugin}/code`).
Whitelist that callback URL in the provider's own application settings so the
round trip completes.

## Enable, disable, and manage clients

Back on the clients list you can enable or disable each client and edit its
settings at any time — for example to switch a client between providers or to
point it at a different credential store — without touching code. You can manage
as many clients as you need, one per provider or account.
