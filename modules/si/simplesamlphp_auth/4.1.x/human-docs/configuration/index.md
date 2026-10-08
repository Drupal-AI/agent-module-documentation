# Configuration

Configuration has two halves. The **SimpleSAMLphp service provider** is configured
outside Drupal — its metadata, the identity provider's certificate, and assertion
signature validation — and that is where SAML security actually lives. The **Drupal
module** is configured on a settings form that tells Drupal how to map an
authenticated SAML user onto an account. Get the SP right first; then work through the
form below.

## Prerequisite outside Drupal

You need a working SimpleSAMLphp SP, either via the Composer-installed
`vendor/simplesamlphp/simplesamlphp` or a standalone install pointed to by
`$settings['simplesamlphp_dir']` in `settings.php`. The SP's `store.type` must **not**
be `phpsession` — the login controller refuses to run otherwise. Make sure the
identity-provider certificate and signature validation are correct; an SP that does
not validate assertion signatures is the classic SAML vulnerability.

## Open the settings form

Go to **Configuration → People → SimpleSAMLphp Authentication**
(`/admin/config/people/simplesamlphp_auth`). Only users with the **Administer
simpleSAMLphp authentication** permission can reach it. The form is organised into
three tabs: **Basic**, **Local authentication**, and **User info and syncing**.

## The master switch

- **Activate** *(default: off)* — the master switch. While it is off the module does
  nothing and the status report shows an informational notice. Turn it on only once
  the rest of the configuration is correct.

## Basic — connecting to the identity provider

- **Authentication source** *(default `default-sp`)* — the name of the SimpleSAMLphp
  auth source to use; it must match a source defined in your SP's `authsources.php`.
- **Unique identifier attribute** *(default `eduPersonPrincipalName`)* — the SAML
  attribute used as the stable **authname** that links a login to a Drupal account. It
  must be unique and non-empty; an empty value aborts the login. This is the single
  most important mapping to get right, because it is what keeps a returning user tied
  to the same account.
- **Username attribute** *(default `eduPersonPrincipalName`)* — the attribute used as
  the Drupal username.
- **Email attribute** *(default `mail`)* — the attribute used as the account email.

## Local authentication — who may still log in with a password

- **Register users** *(default: on)* — automatically create a Drupal account on a
  user's first SAML login. When off, an unknown SAML user is simply logged straight
  back out with a message.
- **Automatically enable SAML for existing accounts** *(default: off)* — when on, a
  successful SAML login whose authname matches an existing Drupal username links and
  logs in as that account. When off, a username collision **aborts** the login instead
  of taking over the account — the safer default.
- **Allow local (non-SAML) logins** *(default: on)* — permit ordinary Drupal password
  logins alongside SAML. You can whitelist specific users (by default user 1) and
  roles that may still log in locally. If you switch local logins off, the login page
  redirects straight to the SAML login route.
- **Allow SAML users to set a Drupal password** *(default: on)* — when off, the
  password fields are hidden on those users' account forms.

## User info and syncing — keeping accounts in step with the IdP

- **Sync email / Sync username** *(default: on)* — overwrite the account's email and/or
  username from the SAML attributes on every login, so the identity provider stays
  authoritative.
- **Role mapping** — assign Drupal roles from SAML attribute values using a rule
  string. Each rule matches a SAML attribute against a value with an operator: `=`
  (the value is present in the attribute), `@=` (the part after `@` in the first
  attribute value equals the value), or `~=` (the value is a substring of an attribute
  value). Multiple rules and multiple roles are supported. You can also choose to
  **re-evaluate roles on every login**, in which case roles that no longer match are
  removed (except locked roles).
- Additional options cover the post-logout redirect URL, the flags on the module's
  return-to cookie (secure / http-only), a no-cache header option, the label of the
  "Federated login" link, and a debug toggle.

## The two permissions

Both are marked restricted (high-privilege) — grant them to trusted administrators
only:

- **Administer simpleSAMLphp authentication** — access to all three settings tabs,
  including the activate switch, attribute mapping, role rules and local-login
  allow-lists.
- **Change SAML authentication setting** — controls who sees the per-user "Enable this
  user to leverage SAML authentication" checkbox on the register/edit forms, i.e. who
  may link or unlink an individual account's SAML entry.

## Save and test

With everything set, enable **activate** and test the flow end to end: confirm a user
is redirected to the identity provider, returns authenticated, and is linked to (or
provisioned as) the right Drupal account with the expected username, email and roles.
