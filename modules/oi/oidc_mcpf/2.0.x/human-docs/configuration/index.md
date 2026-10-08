# Configuration

Because this module works through the OpenID Connect Client (`oidc`) module, you
configure it by setting up the **ACM realm** and its role mappings in the OIDC realm
administration — behind the **Administer OIDC** permission (a restricted permission,
so grant it only to trusted administrators).

## 1. Configure the ACM/IDM connection

In the ACM realm, provide the ACM/IDM connection details and the OpenID Connect
client credentials (client ID and client secret) issued for your site by the Flemish
Government identity service. Save the realm; users can then authenticate against ACM
through it.

## 2. Map IDM roles to Drupal roles — carefully

You can map IDM roles to Drupal roles, which are assigned or revoked automatically on
each login. This mapping decides what each SSO user can do on your site, so keep it
conservative: a permissive mapping over‑grants. Review exactly which IDM role grants
which Drupal role, and remember that because IDM/ACM accounts are audience‑specific,
a person acting as themselves and as an organisation representative will have two
separate local accounts with potentially different roles.

## 3. Enable the toolbar (optional)

If you enable it, the "Mijn Burgerprofiel" toolbar is added automatically to the top
of the page for authenticated users.

## Security posture

- **Client secret storage.** The OIDC client secret is a credential — store it as
  one. With DDEV, keep it out of version control in an environment variable
  (`ddev dotenv set .ddev/.env --oidc-client-secret=<value>`, never commit
  `.ddev/.env`, then `ddev restart`), and prefer supplying it via the
  [Key](https://www.drupal.org/project/key) module or a settings override rather than
  exported configuration.
- **Audience validation.** This module ships ID‑token **audience** validation — make
  sure it stays in force, since it's what keeps the audience‑specific accounts
  correct.
- **State/nonce (login CSRF).** The standard OpenID Connect `state`/`nonce` checks
  are provided by the underlying OIDC layer — leave them in force to protect against
  login CSRF and token replay.
- **Role mapping.** As above, treat the role mapping as a security control and keep
  it minimal.

(These notes reflect what the module's agent docs describe — shipped audience
handling, reliance on the OIDC layer's state/nonce checks, and careful role mapping.
Where the docs don't speak to a specific implementation detail, this guide does not
assume one.)
