# Social Auth Strava — manual setup guide

**Social Auth Strava** (`social_auth_strava`) adds a *Log in with Strava* button to
your Drupal site, letting athletes register and sign in with their **Strava**
account. It adds a `user/login/strava` path that redirects the visitor to Strava's
consent screen; when Strava returns them, the module fetches their athlete profile
and hands it to Social Auth to log them in or create an account. It is built on the
**Social API** / **Social Auth** framework and a Strava OAuth2 SDK, and depends on
both `social_api` and `social_auth`. There are no submodules.

One quirk to be aware of: **Strava no longer returns an email address** through its
API, so this module matches returning users by their **Strava athlete id** (via
Social Auth's provider-mapping table) rather than by email. In practice that is
fine — and it sidesteps any email-collision concerns — but it means account
matching keys on the Strava id. On first login the athlete's Strava avatar can be
set as their Drupal user picture, and their Strava name maps to the Drupal
username.

The module does nothing until you register a Strava API application and enter its
client ID, secret and requested scopes into Drupal.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Social Auth.
2. [Configuration](configuration/index.md) — register a Strava app and enter the
   client id, secret and scopes.

## Where it lives in the admin menu

The settings form sits at **Configuration → Social API → Social Auth → Strava**
(`/admin/config/social-api/social-auth/strava`, route
`social_auth_strava.settings_form`), behind the **Administer social api
authentication** permission.
