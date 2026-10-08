# OpenID Connect Microsoft Azure Active Directory client — manual setup guide

**OpenID Connect Microsoft Azure Active Directory client** (`openid_connect_windows_aad`)
lets your Drupal users **sign in with their Microsoft accounts** — Microsoft Entra ID
(formerly Azure AD), including Azure AD B2C for external/consumer identities. It adds a
"Windows Azure AD" client to the [OpenID Connect](https://www.drupal.org/project/openid_connect)
framework, so you get a "Log in with Microsoft" option on the Drupal login form and accounts
can be provisioned automatically the first time someone signs in.

Beyond basic single sign‑on, it can **map a user's Entra security groups onto Drupal roles**
— either automatically (matching group name or ID) or through explicit `role | group‑id`
mappings — with an optional strict mode that removes roles a user no longer qualifies for. It
speaks the modern Microsoft Graph API (and still supports the deprecated Azure AD Graph for
legacy setups), auto‑detects Azure AD B2C tenants, and offers fine control over email
handling, the immutable identifier used to match accounts (`sub` vs `oid`), single‑logout,
and the Entra sign‑in prompt.

This module does not add any menus, permissions, or settings pages of its own — it is a
**plugin for OpenID Connect**, so you configure it by adding an OpenID Connect *client* and
choosing "Windows Azure AD" as its type. It requires the **OpenID Connect** module and the
**Key** module (the client secret is always stored as a Key entity, never in plain config),
plus PHP 8.0+ and the `lcobucci/jwt` library. The installed 2.0 release is a **beta**
(`2.0.0-beta10`). A real login flow needs a working Microsoft Entra tenant with an app
registration.

This guide is written for a **human** wiring up Microsoft sign‑in through the admin UI. If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it brings in OpenID
   Connect, Key, and the JWT library) and enable the module.
2. [Configuration](configuration/index.md) — create the Windows Azure AD client, enter your
   Entra endpoints and credentials, store the secret in a Key, and set up group‑to‑role
   mapping.

## Where it lives in the admin menu

There is **no settings page belonging to this module**. Everything happens under OpenID
Connect's own screen at **Configuration → Web services → OpenID Connect**
(`/admin/config/services/openid-connect`), where you add a client and pick **Windows Azure
AD** as its plugin. The client secret is created beforehand as a **Key** at **Configuration →
System → Keys** (`/admin/config/system/keys`).
