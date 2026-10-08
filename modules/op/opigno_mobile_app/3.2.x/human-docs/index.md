# Opigno Mobile App — manual setup guide

**Opigno Mobile App** (`opigno_mobile_app`) is the **server-side backend** that lets
the official Opigno LMS native mobile application (for iOS and Android) talk to your
Opigno site. It is not an app you install on a phone — it is the Drupal module that
exposes the REST API the app needs. It publishes a versioned API under `/api/v1/*`
covering trainings and categories, learner statistics, user profiles, and private
messaging, and it issues **JWT tokens** so the app can authenticate its requests.
It is meant to be installed on an existing [Opigno LMS](https://www.drupal.org/project/opigno_lms)
site.

The login flow works like this: the app sends a username and password in a JSON
POST to `POST /api/v1/token`; a custom authentication provider (`json_auth`) checks
those credentials (protected by Drupal's core flood/brute-force throttling) and
returns a signed **JWT**, built through the `jwt` / `jwt_auth_issuer` modules and
signed with a managed **Key**. The app then reuses that JWT on subsequent calls.
Most endpoints enforce login, entity access, and Opigno permissions — messaging and
statistics in particular — while several catalogue endpoints are intentionally
public so the app can show a training catalogue before sign-in.

A bundled submodule, **`opigno_onesignal`**, integrates
[OneSignal](https://onesignal.com/) push notifications with Opigno's notification
system so the app can push alerts to devices.

> **Security note worth reading before you expose this API.** Some user- and
> group-listing routes are gated only by `_access: TRUE`, and while the JWT is
> listed among their auth options it is not strictly *required* on those routes —
> so anonymous callers can reach a few of them. Before opening this API to the
> public internet, review the access rules on the user/group endpoints (for example
> `/api/v1/users/get-groups-members` and `/api/v1/user/profile`) and confirm the
> exposure is acceptable for your data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its several dependencies, and set up the JWT signing key.

This module has **no settings form of its own**. What setup it needs is done
through the modules it depends on — the **Key** module (for the JWT signing key)
and the **RESTui** module (to review which REST resources are enabled) — described
in "How to use it" below.

## Where it lives in the admin menu

- **Configuration → System → Keys** (`/admin/config/system/keys`) — where the JWT
  signing key is managed (via the Key module).
- **Configuration → Web services → REST** (RESTui, `/admin/config/services/rest`) —
  where you can review and manage which REST resources are enabled.
- The API itself lives at **`/api/v1/*`** — consumed by the mobile app, not browsed
  by admins.

## How to use it

1. Install the module and its dependencies on your Opigno LMS site, and enable them
   (see [Installation](installation/index.md)).
2. Make sure a **signing Key** exists for the JWT issuer, so tokens are signed with
   a managed secret rather than a hard-coded value (the Key module handles this).
3. Use **RESTui** to review the enabled REST resources and confirm the endpoints
   you expect are available.
4. **Review the access rules** on the user/group listing endpoints before exposing
   the API publicly (see the security note above).
5. Point the Opigno native mobile app at your site's URL. The app authenticates via
   `POST /api/v1/token`, receives a JWT, and uses it to load trainings, progress,
   profiles, and messages.
6. To send push notifications, enable and configure the **`opigno_onesignal`**
   submodule (it needs Opigno's notification module).
