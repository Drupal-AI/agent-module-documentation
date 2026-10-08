# Configuration

Configuring Bitbucket login is a two‑part job: register an OAuth consumer at
Bitbucket, then enter its details in the League OAuth Login configuration for the
Bitbucket provider.

## 1. Register a Bitbucket OAuth consumer

1. In Bitbucket, go to **Workspace settings → OAuth consumers** and create a new
   **OAuth consumer**.
2. Set its **callback URL** to your site's League OAuth Login callback (the
   redirect URI).
3. Grant it **account / email** scope (the plugin requests `email` and
   `repository` scopes).
4. Note the consumer's **Key** (this is your client ID) and its **Secret**.

## 2. Enter the details in Drupal

In the League OAuth Login configuration for the Bitbucket provider, set:

- **Client ID** — the Bitbucket consumer **Key**.
- **Client secret** — the Bitbucket consumer **Secret**.
- **Redirect URI** — the callback URL you registered above; it must match exactly.

Save, and the Bitbucket login option appears on the login form. When a user signs
in, the plugin requests the `email` and `repository` scopes and reads the primary
email from `/2.0/user/emails` to match or create their Drupal account.

## Store the client secret safely

The consumer secret is a real credential. Rather than committing it to exported
configuration:

- Store it in an environment variable with DDEV's dotenv command — for example
  `ddev dotenv set .ddev/.env --bitbucket-client-secret=<value>` — then
  `ddev restart`. Never commit `.ddev/.env`.
- Reference it through a **Key** entity backed by the environment provider where
  the workflow allows.

## The OAuth flow lives in the base module

The authorize redirect, callback, and OAuth **state** handling are all
implemented by the base **League OAuth Login** module, not by this plugin. See the
[base module's configuration guide](../../../league_oauth_login/2.0.x/human-docs/configuration/index.md).
This Bitbucket plugin only maps identity fields and does not itself weaken TLS.
Always serve the site over **HTTPS**.

## Save

Click **Save configuration**, then test the full round trip over HTTPS: click the
Bitbucket login button, approve at Bitbucket, and confirm you return logged in to
the correct Drupal account.
