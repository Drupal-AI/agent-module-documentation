# SimpleSAMLphp SP — manual setup guide

**SimpleSAMLphp SP** (`simplesamlphp_sp`) is a Drupal 11 integration layer for sites
that authenticate users through a SimpleSAMLphp service provider. It lets Drupal act
as a SAML 2.0 service provider: users authenticate against an external SAML identity
provider (single sign-on), and the module links or provisions Drupal accounts from the
identity provider's signed assertion.

It adds a configurable SAML login route that proxies requests through your
SimpleSAMLphp service provider, and links identity-provider users to Drupal accounts
via the External Authentication module — creating or connecting accounts
automatically. It deliberately protects the administrative side: admin roles and the
super administrator (user 1) cannot be taken over by external accounts. For accounts
that SAML manages, it can lock the native Drupal credential fields and login paths
(username, email, password, one-time login links and password resets), while honouring
a configurable list of exempt user IDs — user 1 is always exempt. It also coordinates
logout between Drupal and the identity provider, and redirects rejected logins to a
dedicated denial route with a helpful message.

The module's settings live at **Configuration → People → SimpleSAMLphp SP settings**
(`/admin/config/people/simplesamlphp-sp`). It depends on core's **User** module, the
**External Authentication** module, and a properly installed and configured
SimpleSAMLphp service provider.

**Where the security lives.** As with any SAML integration, assertion signatures are
validated by the SimpleSAMLphp library, so the real security work is configuring the
service-provider and identity-provider metadata, certificates and signature
validation carefully — and storing any secrets securely. The module handles the Drupal
side; the trust rests on the SimpleSAMLphp configuration outside it.

> **Note:** the maintainer states this module was written by AI agents, with the
> maintainer reviewing and taking full responsibility for the work.

This guide is written for a **human** setting SSO up through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies
   (including the SimpleSAMLphp library) and enable it.
2. [Configuration](configuration/index.md) — the service-provider name, the login
   path, attribute mapping, role restrictions and credential locking, field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → People → SimpleSAMLphp SP settings**
(`/admin/config/people/simplesamlphp-sp`).
