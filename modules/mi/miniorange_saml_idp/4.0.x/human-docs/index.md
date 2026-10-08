# miniOrange SAML Identity Provider — manual setup guide

**miniOrange SAML Identity Provider** (`miniorange_saml_idp`) turns your Drupal
site itself into a **SAML 2.0 Identity Provider (IdP)**. In this arrangement Drupal
becomes the authentication authority: external SAML 2.0 **Service Providers** (SPs)
— apps such as Moodle, Nextcloud, AWS, Freshdesk, Rocket.Chat and many others —
trust Drupal for login, and a user already signed in to Drupal can single sign-on
(SSO) into those apps without entering credentials again. This is the inverse of a
SAML SP/consumer module: here Drupal *issues* the identity rather than *consuming*
one.

You register each Service Provider in the module (its entity ID, ACS URL, and the
user attributes to release), and Drupal issues **signed SAML assertions** that the
SP verifies. The module supports both SP-initiated and IdP-initiated SSO, SAML
Single Logout, releasing user and constant attributes, signed responses with
encrypted assertions, and custom certificate generation. As with other miniOrange
modules, the admin UI promotes paid tiers (the community tier supports one SP and
admin-only SSO; multiple SPs, all roles, Single Logout, encryption and more are
premium) — that's a licensing decision, not a technical one.

> **Security essentials.** The assertion-signing **private key** is the crown
> jewels of an IdP — anyone who holds it can forge assertions for any SP — so keep
> it secret and out of version control. Register **only intended SPs**, with their
> correct ACS URLs, and release the **minimum attributes** each SP genuinely needs.
> (This module was checked and, unlike miniOrange's *Security Login Secure* module,
> does **not** disable TLS certificate verification on its outbound calls.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set up the IdP, register a Service
   Provider, map attributes, and protect the signing key.

## Where it lives in the admin menu

The module's setup screens are reached through its **IdP Setup** configuration
(route `miniorange_saml_idp.idp_setup`), found under the miniOrange section of the
admin menu once the module is enabled.
