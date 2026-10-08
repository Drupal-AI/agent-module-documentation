# Social Auth PBS — manual setup guide

**Social Auth PBS** (`social_auth_pbs`) adds "Log in with PBS" to a Drupal site,
letting visitors register and sign in with their **PBS.org account** over OAuth2.
It adds a `user/login/pbs` path that redirects the visitor to PBS to authenticate;
when PBS returns them, the module matches them to an existing account (by PBS user
id or email address) or creates a new one, and an already-logged-in user can link
their PBS account.

What makes this module a little different from other Social Auth providers is that
it bundles several **PBS sign-in variants** in one plugin: the base **PBS Account**
plus PBS-federated **Apple**, **Facebook** and **Google** sign-in, and a
**register** variant that first sends new users through PBS's account-creation page
and forces PBS's VPPA activation check. All of these share one redirect route and
one callback route; the variant in use is carried through the flow so the callback
knows which provider was used. Under the hood it is built on the **Social Auth** /
**Social API** framework and the `openpublicmedia/oauth2-pbs` OAuth client.

It is a well-behaved Social Auth plugin: the login start routes are open to
anonymous users by necessity (you have to be able to start a login before you have
an account), but the security-sensitive parts — the OAuth `state`/CSRF check and
the TLS token exchange — are handled by the shared Social Auth base, not
re-implemented here. It depends on **Social Auth** (`social_auth`) and has no
submodules. The module does nothing until you register an OAuth2 application with
PBS and enter the client ID, secret and scopes into Drupal.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Social Auth.
2. [Configuration](configuration/index.md) — register a PBS app and enter the
   client ID, secret and scopes, plus the sign-in variants.

## Where it lives in the admin menu

The settings form sits at **Configuration → Social API → Social Auth → PBS**
(`/admin/config/social-api/social-auth/pbs`, route
`social_auth_pbs.settings_form`). Visitors sign in from the **PBS** button in the
Social Auth login block, or from any link you place to `user/login/pbs`.
