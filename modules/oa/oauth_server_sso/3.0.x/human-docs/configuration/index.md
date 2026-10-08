# Configuration

All configuration happens on the module's setup screen (the
`oauth_server_sso.setup` route), reached as an administrator with the module's own
permission. The job is to register each external application that will trust your
Drupal site for login, tell it which scopes and user information it may receive,
and manage the keys that sign the tokens.

## Register a client application

For each external app (Salesforce, Slack, Jira, WordPress, and so on) you create a
client entry. Drupal generates a **client id** and **client secret** for that
client, which you copy into the external app's OAuth/OIDC settings. The most
important field you set here is the client's **redirect / callback URI(s)** — the
address the browser returns to after login.

**Register exact redirect URIs.** The authorize endpoint validates every incoming
`redirect_uri` against the list you register for the client (RFC 6749 §3.1): an
unregistered URI is rejected, and when a client has several registered URIs the
request must name one explicitly. Register the precise URIs each app uses and avoid
wildcards or overly broad entries — this is the main defense against tokens being
redirected to an attacker.

> The module offers an option to **bypass callback URI validation** for clients
> with genuinely dynamic callback URLs. Leave this off unless you truly need it;
> turning it off weakens the redirect‑URI protection described above.

## Scopes, attributes, and roles

Define the **scopes** each client may request, and configure the **server
response** — which user attributes and roles Drupal shares back to the client in
the ID token / userinfo response. Follow least privilege: give each client only
the scopes and attributes it actually needs.

## Grant types and the state parameter

The server supports the common grants — **authorization code**, implicit,
password, client credentials, and refresh token. For browser‑based login, prefer
the authorization code grant.

The module lets you **enforce the `state` parameter** per client requirements.
The `state` value is what protects the login redirect against CSRF, so enable this
enforcement wherever the client application supports it (well‑behaved OAuth clients
always send `state`). Leave it enforced unless a specific legacy client cannot
provide one.

For **public clients** (single‑page apps, mobile apps, and anything that cannot
keep a secret confidential), enable **PKCE** so the authorization code cannot be
intercepted and replayed.

## Signing keys and token settings

- **JWT signing algorithm.** Choose the algorithm that matches the client
  (symmetric **HS** or certificate‑based **RS**). RS algorithms use a
  public/private key pair so clients can verify tokens with your public key.
- **Access‑token length and lifetime**, and **ID‑token lifetime**, are
  configurable — tune them to your organization's security standards, balancing
  shorter lifetimes (safer) against re‑authentication frequency.

## Keeping the server secure

- **Store client secrets and signing keys securely.** They are the crown jewels of
  an identity provider. Where the module or your workflow allows, keep secret
  material in an environment variable rather than in code or version control — with
  DDEV, `ddev dotenv set .ddev/.env --some-secret=<value>` then `ddev restart`, and
  reference it through the [Key](https://www.drupal.org/project/key) module where
  supported. Make sure outbound egress rules permit any calls the server needs to
  make.
- **Serve everything over HTTPS** — tokens and secrets must never cross the network
  in the clear.
- **Register exact redirect URIs** per client (see above).
- **Enforce `state`** and **enable PKCE** for public clients.
- **Review scopes and consent** so each client receives only what it needs.
- **Keep the module updated** — as the authorization server, its fixes are
  high‑impact.

## Save

Save the configuration when you finish. Then complete the pairing on the external
app's side using the client id, client secret, and endpoints Drupal shows you, and
test a login end to end before relying on it.
