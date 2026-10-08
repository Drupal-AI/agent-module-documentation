# SimpleSAMLphp Authentication — manual setup guide

**SimpleSAMLphp Authentication** (`simplesamlphp_auth`) lets Drupal users log in
through a remote SAML identity provider — an enterprise directory such as Azure AD,
Okta, ADFS, Shibboleth or a university federation — via a locally installed
SimpleSAMLphp service provider. Users authenticate once at the central identity
provider, and your Drupal site trusts its signed assertion instead of holding local
passwords.

Built on the `simplesamlphp/simplesamlphp` PHP library and Drupal's **External
Authentication** (`externalauth`) module, it delegates login to the identity provider
and, once the library reports the session authenticated, reads the configured SAML
attributes to resolve or create a Drupal account keyed on a unique-identifier
attribute (default `eduPersonPrincipalName`). It can just-in-time provision users on
first login, sync username and email on every login, and map SAML attribute values to
Drupal roles through a rule string. A set of hooks lets other modules veto a login,
match a different existing user, alter the stored authname, remap roles, and copy
extra attributes to profile fields. It also ships a login block, adds a "Federated
login" link to the standard login form, and adds a per-user checkbox to enable SAML on
an individual account. Its companion project `simplesamlphp_custom_attributes` maps
additional SAML attributes onto user fields.

The module's settings live at **Configuration → People → SimpleSAMLphp
Authentication** (`/admin/config/people/simplesamlphp_auth`), and — importantly —
**nothing takes effect until you turn on the `activate` switch**, so you can configure
everything safely first and enable SAML last.

**Where the security actually lives.** This is a sound module, and it correctly
delegates all the cryptography to the SimpleSAMLphp library — it never re-implements
assertion validation. That means SAML security rests on the SimpleSAMLphp
configuration *outside* Drupal: the service-provider metadata, the identity provider's
certificate, and signature validation. A service provider that does not validate
assertion signatures is the classic SAML hole. On the Drupal side the identity mapping
is deliberately strict: the authname is the non-empty unique-identifier attribute (an
empty one throws), and an existing local username is linked to a SAML login only when
an administrator explicitly enables that behaviour — otherwise a username collision
aborts the login rather than hijacking the account. The two permissions the module
adds are high-privilege and marked restricted; grant them to trusted admins only.

> **Maintenance note from the maintainer:** this project is minimally maintained and
> has a complex, version-specific dependency chain (Symfony, Guzzle and more) that can
> conflict with `drupal/core-recommended`. The maintainer suggests checking whether a
> lighter alternative such as **SAML Authentication** meets your needs before adopting
> it.

This guide is written for a **human** setting SSO up through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies
   (including the SimpleSAMLphp library and a working service provider), and enable it.
2. [Configuration](configuration/index.md) — the three settings tabs, attribute
   mapping, role rules, local-login rules, and the activate switch, field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → People → SimpleSAMLphp Authentication**
(`/admin/config/people/simplesamlphp_auth`). It has three tabs — Basic, Local
authentication, and User info and syncing.
