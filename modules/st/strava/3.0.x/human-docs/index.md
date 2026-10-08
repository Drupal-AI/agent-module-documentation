# Strava — manual setup guide

**Strava** (`strava`) integrates the [Strava](https://www.strava.com) fitness and
activity platform with Drupal, implementing Strava's API (v3) so athlete
activities and related data can be fetched and shown or synced on your site — handy
for club sites, event sites, and similar communities built around Strava activity.

Connecting to Strava uses OAuth. A Drupal user signs in first, then links their
account to Strava through the module's **Strava login block** or the `/admin/strava`
page; once linked, signing in via Strava works as expected. A couple of behaviours
are worth knowing up front. Strava no longer exposes athlete email addresses, so
the module **cannot create new Drupal accounts** from a Strava login — only
*existing* Drupal users can link their accounts (sign-up through Strava is not
supported). And as of the 3.0 line the module supports **refresh tokens**, so
linked sessions no longer expire after six hours; access tokens are refreshed
automatically.

Because this is an OAuth integration, you register an application on Strava's side
to obtain client credentials, and Drupal is configured with those credentials. Keep
the client secret and any tokens out of version control — store them in an
environment variable and reference them from your configuration. The module depends
on core's **Serialization** module and supports Drupal 10.3 and newer, including
Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Register an application in your Strava account to get OAuth **client
   credentials** (client ID and secret).
2. Provide those credentials to Drupal, keeping the secret in an environment
   variable rather than committing it.
3. As a signed-in Drupal user, link your account to Strava via the **Strava login
   block** or the **`/admin/strava`** page.
4. Once linked, Strava sign-in works, and the module can fetch and display or sync
   the athlete's activity data. Remember that Strava sign-up cannot create new
   Drupal accounts — the user must already exist and be signed in to link.
