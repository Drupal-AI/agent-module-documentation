# Configuration

Configuration has two halves. The **SimpleSAMLphp service provider** is set up outside
Drupal — its auth sources, identity-provider metadata and certificates — and that is
where the assertion trust and signature validation live. The **Drupal module** is
configured on a settings form that connects to that service provider and decides how
SAML users map onto Drupal accounts.

## Open the settings form

Go to **Configuration → People → SimpleSAMLphp SP settings**
(`/admin/config/people/simplesamlphp-sp`).

## Connect to the service provider

- **Service provider name** — the SP name exactly as defined in your
  `config/authsources.php`. The default is `default-sp`.
- **SAML login path** — the public path the module dynamically exposes and routes
  through the identity provider. The default is `/saml/login`.

## Map identity-provider attributes to Drupal fields

- **Unique identifier attribute** — used to look up or create the Drupal account. This
  is the stable key that keeps a returning user tied to the same account.
- **Username attribute** — the account username; falls back to the unique identifier
  when left empty.
- **Email attribute** — required for account linking and provisioning.

## Restrict which roles may use SAML

- Optionally limit which Drupal **roles** are allowed to authenticate via SAML. Leave
  the selection empty (or choose "None") to allow all roles.

## Lock native credentials for SAML accounts

- Decide whether to **lock the username, email and password fields** for accounts
  provisioned by SAML. When locked, you can also disable native Drupal login, one-time
  login links and password resets for those accounts, so they can only ever
  authenticate through the identity provider.
- **Exempt user IDs** — specify accounts that are exempt from credential locking and
  the native-login restrictions. **User 1 is always exempt**, which — together with the
  module's protection of admin roles and the super admin — keeps external accounts from
  taking over administrative access.

## Save and test

Save the configuration, then test the single sign-on flow by visiting the configured
SAML login path. Confirm a user is sent to the identity provider, returns
authenticated, and is linked to (or provisioned as) the correct Drupal account — and
that rejected logins are redirected to the denial route with a clear message.
