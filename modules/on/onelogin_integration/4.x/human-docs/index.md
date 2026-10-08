# OneLogin Integration — manual setup guide

**OneLogin Integration** (`onelogin_integration`) lets Drupal authenticate users
through SAML single sign‑on against [OneLogin](https://www.onelogin.com/) — or,
in fact, any SAML identity provider (IdP). It is built on the official
`onelogin/php-saml` v3 toolkit, so all the security‑critical work of validating
SAML responses, signatures, and assertions is delegated to a well‑established
library rather than reimplemented.

In an SSO setup, your Drupal site is the **service provider (SP)** and OneLogin
(or your chosen IdP) is the **identity provider (IdP)**. A user clicks "log in",
gets redirected to the IdP to authenticate, and returns to Drupal with a signed
SAML assertion that the module validates before logging them in and mapping their
identity to a Drupal account.

A close review of this module found the validation flow **correctly built**: the
authentication factory caches the SAML `Auth` instance, so the response is
validated and its errors are checked on the *same* validated object, and a user is
only logged in when there are no errors. (It looks at a glance as though errors
might be checked on a fresh, unvalidated object — verified that they are not.)

**The security that remains is yours to configure, and it matters.** SAML is only
as safe as its signature settings. The toolkit's `strict`, `wantAssertionsSigned`,
and `wantMessagesSigned` options are all admin‑configurable, and they **must be
enabled** for validation to mean anything — an IdP that does not require signed
assertions will accept forgeable ones, which is the classic SAML misconfiguration
that leads to authentication bypass. Also be aware that
`relaxDestinationValidation` is hardcoded to `TRUE` in this module, which relaxes
the SAML Destination check. The [Configuration](configuration/index.md) page
walks through getting these settings right.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its php‑saml
   library) with Composer and enable it.
2. [Configuration](configuration/index.md) — the SP and IdP settings, the
   signature/strict options you must enable, and where the IdP certificate goes.

## Where it lives in the admin menu

Once enabled, reach the module's SAML settings form from the **Extend** page by
clicking **Configure** next to *OneLogin Integration*, or from the
**Configuration** section of the admin menu. See
[Configuration](configuration/index.md) for the fields.
