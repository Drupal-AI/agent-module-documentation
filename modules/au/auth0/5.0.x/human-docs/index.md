# Auth0 — manual setup guide

**Auth0** (`auth0`) turns Drupal's login into an [Auth0](https://auth0.com/)-hosted
Single Sign-On (SSO) flow. Instead of the usual Drupal login form, visitors are
redirected to Auth0's Universal Login page; after they authenticate there, Auth0
sends them back to Drupal, and the module logs them in — creating a matching
Drupal account on first login and, optionally, keeping their roles and profile
fields in sync from Auth0 on every login.

Because Auth0 sits in front of your login, you can offer social login (Google,
GitHub, and so on), enterprise connections (SAML, Active Directory), and MFA or
adaptive policies — all configured at Auth0, without building an OpenID Connect
client by hand. The module is built on the official `auth0/auth0-php` v8 SDK and
provisions Drupal users through the ExternalAuth module, keying each Drupal
account to the Auth0 user's `sub` (subject) identifier. A legacy Drupal login form
remains available at `/user/login/legacy` for break-glass access if Auth0 is
unreachable.

Honesty about the security model: the login callback route is intentionally
reachable before authentication (a login callback has to be), and the important
checks — CSRF `state` validation, the authorization-code exchange, and ID-token
signature/issuer/audience/nonce/expiry validation — are delegated to the
maintained Auth0 SDK, with the module additionally verifying the token subject
matches the userinfo. The **client secret** and the SDK **cookie secret** should
be stored as **Key** entities (backed by an environment variable or file provider)
rather than pasted into configuration; if you put a secret directly into config,
the module logs a warning recommending the Key module. The shipped configuration
is entirely empty — there are no baked-in credentials.

> **Version note:** this is a `5.0.0-alpha1` release. Treat it as early software
> and test carefully before relying on it in production, and always keep the
> legacy login path available.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Composer
   dependencies, and enable it.
2. [Configuration](configuration/index.md) — connect your Auth0 tenant, store the
   secrets as Key entities, and set up role/claim mapping.

## Where it lives in the admin menu

- **Basic settings** are at **Configuration → Auth0** (`/admin/config/auth0`).
- **Advanced settings** (verified-email requirement, username claim, claim/role
  mapping, password reset) are at `/admin/config/auth0/advanced`.

Both forms require the **Administer site configuration** permission.

## How to use it

1. Create an Application in your Auth0 tenant and note its domain, client ID, and
   client secret. Register `https://your-site/auth0/callback` as an allowed
   callback URL in Auth0.
2. Store the client secret (and a cookie secret) as **Key** entities in Drupal.
3. Enter your domain, client ID, and the key references on the Basic settings
   form.
4. Optionally set up role and claim mapping on the Advanced form.
5. Visit `/user/login` — you should be redirected to Auth0 and, after signing in,
   returned to Drupal logged in.
