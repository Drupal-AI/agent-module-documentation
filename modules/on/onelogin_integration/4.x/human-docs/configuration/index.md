# Configuration

Configuring OneLogin Integration is a two‑sided exercise: you register Drupal as
a **service provider (SP)** at your identity provider, and you tell Drupal about
your **identity provider (IdP)**. The module's settings form is where the IdP
details and the security options live. Getting the security options right is the
most important part of this page — a SAML login that does not verify signatures is
worse than no SSO at all.

## Open the settings form

1. Log in as an administrator (the module provides its own administration
   permission — grant it only to trusted administrators).
2. Open the SAML settings form from the **Extend** page (**Configure** next to
   *OneLogin Integration*) or from the **Configuration** section of the admin
   menu.

## Service provider (your Drupal site) settings

These identify your site to the IdP:

- **SP Entity ID** — a unique identifier for your Drupal service provider, often a
  URL such as your site's SAML metadata address. It must match what you register
  at the IdP.
- **Assertion Consumer Service (ACS) URL** — the Drupal endpoint the IdP posts the
  signed SAML response back to after the user authenticates. Register this same
  URL at your IdP.

## Identity provider settings

These tell Drupal where to send users and how to trust what comes back:

- **IdP Entity ID / Issuer** — the identifier your IdP presents in its assertions.
- **IdP Single Sign‑On (SSO) URL** — the IdP endpoint Drupal redirects users to in
  order to log in.
- **IdP X.509 certificate** — the public signing certificate from your IdP. This
  is what makes signature validation possible: Drupal uses it to verify that an
  assertion really came from your IdP and was not tampered with. Paste the exact
  certificate your IdP provides; a wrong or missing certificate means signatures
  cannot be verified.

## Security options — enable these, do not skip them

SAML's safety depends entirely on these settings. The php‑saml toolkit exposes
them and the module makes them admin‑configurable, which means the responsibility
to turn them on is yours:

- **Strict mode (`strict`)** — **enable it.** In strict mode the toolkit rejects
  responses that fail validation instead of tolerating them. With strict mode off,
  validation errors do not stop a login, which defeats the purpose.
- **Want assertions signed (`wantAssertionsSigned`)** — **enable it.** This
  requires every SAML assertion to be cryptographically signed by the IdP. An IdP
  that does not require signed assertions will accept forgeable ones — the classic
  SAML hole that lets an attacker mint their own "valid" login.
- **Want messages signed (`wantMessagesSigned`)** — **enable it.** This requires
  the SAML response message itself to be signed, closing the same class of
  forgery at the message level.

Make sure your IdP is actually configured to sign assertions and messages, so that
these Drupal‑side requirements are satisfied by real signatures.

> **Note on Destination validation.** This module hardcodes
> `relaxDestinationValidation` to `TRUE`, which loosens the check that a response
> was addressed to your exact SP URL. This is a fixed behavior you cannot change
> from the form; be aware of it, and lean all the harder on strict mode and the
> signature requirements above, which are your real protections.

## Attribute mapping and user provisioning

The module reads the user's NameID and attributes from the validated assertion to
identify and provision the Drupal account. Configure the mapping so the IdP
attribute that carries the user's identity (typically email or username) lands on
the right Drupal field, and decide whether new users should be created on first
login according to your site's policy.

## Save and test

Save the form, then run a full login: click log in, authenticate at the IdP, and
confirm you are returned to Drupal logged in. If login fails, check that the IdP
certificate is correct and that the IdP is signing assertions/messages — with
strict mode on, a signature mismatch will (correctly) block the login rather than
letting an unverified assertion through.
