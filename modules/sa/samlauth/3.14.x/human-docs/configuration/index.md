# Configuration

SAML is a two‑sided handshake: your Drupal site (the **Service Provider**) and your
organization's login system (the **Identity Provider**) each have to know a few
things about the other. All of Drupal's SAML settings live in one configuration
object (`samlauth.authentication`), edited across two admin forms. You'll need the
**Configure SAML** permission.

Everything on both forms exports and deploys with `drush config:export` — though
you'll usually keep environment‑specific values (URLs, certificates) out of shared
config or reference them from a Key entity.

## The two forms

- **SAML Authentication settings** — `/admin/config/people/saml`
  (**Configuration → People → SAML authentication**): login/logout behavior and how
  Drupal creates, links and synchronizes users.
- **SAML configuration** — `/admin/config/people/saml/saml`: the SP and IdP identity,
  endpoints, certificates, and security options.

## Give the IdP administrator your SP details

The module's own endpoints are fixed (you can't change their paths):

| Endpoint | Path | What it's for |
|----------|------|---------------|
| Login | `/saml/login` | Starts a login and redirects the user to the IdP. |
| Assertion Consumer Service (ACS) | `/saml/acs` | Receives and validates the IdP's response. |
| Single Logout (SLS) | `/saml/sls` | Handles logout that originates at the IdP. |
| Metadata | `/saml/metadata` | Publishes your SP metadata XML for the IdP. |

Hand the IdP administrator your **SP Entity ID**, the **ACS URL** (`…/saml/acs`) and
the **SLS URL** (`…/saml/sls`) — or simply point them at your metadata URL so they
can import everything at once. Note that your IdP's single sign‑on endpoint must
offer the **HTTP‑Redirect** binding (the POST binding is not supported).

## Service Provider settings (`/admin/config/people/saml/saml`)

- **SP Entity ID** — a unique identifier for your site as a service provider. It may
  contain the `[site:base-url]` token so it stays correct across environments.
- **NameID format** — the format the SP requests for the identifier the IdP returns.
- **SP certificate** and **SP private key** — the key pair used to sign outgoing
  requests and to decrypt encrypted assertions. You can store these in configuration,
  point to a file on disk, or (recommended) reference them from a **Key** entity.
- **New SP certificate** — a second certificate slot used during a certificate
  roll‑over, so you can rotate keys without downtime.

## Identity Provider settings (`/admin/config/people/saml/saml`)

Copy these from the IdP's own metadata XML (the module does not parse metadata for
you yet):

- **IdP Entity ID** — the identity provider's unique identifier.
- **Single Sign‑On service URL** — where Drupal sends users to log in.
- **Single Logout service URL** — where Drupal sends logout requests.
- **Change‑password service URL** — optional; enables the `/saml/changepw` redirect.
- **IdP certificate(s)** — the public certificate(s) Drupal uses to validate signed
  messages from the IdP, plus an optional separate encryption certificate.

## Unique ID and user mapping (`/admin/config/people/saml`)

- **Unique ID attribute** — the stable identifier that ties a SAML login to a Drupal
  account (a NameID, or a named attribute such as an employee number).
  **Choose this carefully and never change it** once users have logged in — changing
  it breaks the link to existing accounts.
- **Create users** — create a new Drupal account on first SAML login when no match
  exists.
- **Link existing accounts** — match an incoming login to an existing Drupal user by
  name, by email, and/or by a prepopulated authmap entry.
- **Synchronize username / email** — update the Drupal username and/or email from
  configured SAML attributes on each login, and which attributes to read them from.

Account links are stored by External Authentication (provider `samlauth`); you can
review and delete wrong links at `/admin/people/authmap/samlauth`.

## Login and logout behavior (`/admin/config/people/saml`)

- **Redirect the login form to SAML** — send users who hit Drupal's normal login form
  straight to the IdP.
- **Roles allowed to log in locally** — which roles may still use Drupal's own login
  form even when SAML is enabled (keep an administrator role here so you don't lock
  yourself out).
- **Log out of the IdP too** — when a user logs out of Drupal, also end their IdP
  session (Single Logout).
- **Redirect URLs** — fixed destinations to send users to after login, after logout,
  or after an error.

## Security (message signing and validation)

The **SAML configuration** form has a group of security options that control whether
messages and assertions must be signed and/or encrypted — for example: sign outgoing
authentication and logout requests, require incoming messages/assertions to be
signed, encrypt assertions or the NameID, and require a signed NameID. There are also
signature‑ and encryption‑algorithm selectors, and a **strict** mode. Out of the box
the module ships with signing enabled and strict mode on; keep these on in production.

## Debugging

If you're not sure which attribute names your IdP sends, turn on the debug‑logging
options (log incoming SAML messages) temporarily. The logged assertion shows the
exact attribute names, which you then plug into the Unique ID / username / email
mapping above. Turn debug logging back off once you're done.

## Save

Each form has its own **Save configuration** button. After filling in both forms, do
a test login at `/saml/login`.
