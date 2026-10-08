# SAML Service Provider — manual setup guide

**SAML Service Provider** (`saml_sp`) turns your Drupal site into a SAML 2.0
**Service Provider (SP)** — the "relying party" side of a single sign‑on setup.
It validates authentication responses coming from an external SAML **Identity
Provider (IdP)** such as Okta, Microsoft Entra ID (Azure AD), OneLogin, ADFS,
Ping or Shibboleth, using the well‑established OneLogin PHP SAML toolkit under the
hood.

It is important to understand that this is an **API / toolkit module**: on its
own it does **not** log anyone in. It exposes the standard SP endpoints, lets you
register one or more Identity Providers, and validates the SAML responses they
send — but "what to do once a user is authenticated" is left to a callback. The
bundled **SAML SP Drupal Login** submodule (`saml_sp_drupal_login`) provides that
callback and is what actually signs Drupal users in from the IdP. If your goal is
"let staff log into this Drupal site with our corporate SSO," you will enable both
the base module and that submodule.

Once configured, the module publishes three fixed endpoints an IdP administrator
needs: an **assertion consumer service (ACS)** at `/saml/consume` where the IdP
POSTs its response, **SP metadata** at `/saml/metadata.xml` that you hand to the
IdP, and a **logout** callback at `/saml/logout`. Site‑wide settings cover your
technical/support contacts, organization details, the SP's own X.509 certificate
and key (used to sign requests and metadata), and a set of security flags that
decide what must be signed or encrypted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the programmatic
`saml_sp_start()` flow and the alter hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its required
   `onelogin/php-saml` library with Composer, then enable it and the login
   submodule.
2. [Configuration](configuration/index.md) — the site‑wide SP settings form and
   how to register your Identity Providers, field by field.

## Where it lives in the admin menu

The main settings form is at **Configuration → People → SAML Service Provider**
(`/admin/config/people/saml_sp`), and the list of Identity Providers is at
`/admin/config/people/saml_sp/idp_collection`. Both are gated by the
**Configure SAML SP** (`configure saml sp`) permission — grant it only to trusted
administrators.

## How to use it

A typical rollout looks like this:

1. Install the module and the `onelogin/php-saml` library, enable
   `saml_sp` and the `saml_sp_drupal_login` submodule.
2. Give Drupal an SP certificate and key on disk, and fill in the site‑wide SP
   settings (entity ID, contacts, security flags).
3. Hand your IdP administrator the SP metadata from `/saml/metadata.xml`.
4. Register the IdP in Drupal (you can paste the IdP's XML metadata to auto‑fill
   most fields), providing its login/logout URLs and X.509 certificate.
5. Test the round trip — Drupal sends the user to the IdP, the IdP posts a
   response back to `/saml/consume`, and the login submodule signs the matching
   Drupal account in.

> **A note on certificates and secrets.** SAML relies on public/private key
> pairs. The **certificates are public** — you exchange them openly with the IdP
> and publish yours in metadata. The **private key is a secret**: point Drupal at
> a key file on disk that only the server (PHP) can read, and never commit it to
> version control. If you keep the key material in an environment variable,
> reference it from `settings.php` rather than hard‑coding it.
