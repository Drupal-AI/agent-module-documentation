<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Opigno Mobile App is the server-side companion for the Opigno LMS native mobile application. It exposes a versioned REST API under `/api/v1/*` (trainings, categories, statistics, user profile, and private messaging) and issues JWT tokens so the app can authenticate subsequent requests. It is meant to be installed on an existing Opigno LMS site.

---

The module registers a custom authentication provider `json_auth` (`JsonAuth`, priority 100) that authenticates a username/password supplied in a JSON POST body (with core flood protection), and a `TokenRestResource` at `POST /api/v1/token` that finalizes the login and returns a signed JWT (built via the `jwt`/`jwt_auth_issuer` modules and a Key). Most endpoints live in `*.routing.yml` controllers (Groups/LearningPathController, Messaging/MessagingController, Users/UsersController, StatisticsController, OpignoMoxtraController) and REST resource plugins. Messaging and statistics routes enforce `_user_is_logged_in`, entity access, and Opigno permissions; several catalogue endpoints are intentionally public (`_access: TRUE`). The bundled `opigno_onesignal` submodule integrates OneSignal push notifications with `opigno_notification`. Dependencies are heavy: `jwt`, `jwt_auth_consumer`, `jwt_auth_issuer`, `key`, `restui`, plus core `rest`, `hal`, and `serialization`. Note (see agent notes): some user/group listing routes are gated only by `_access: TRUE`, so treat the access matrix carefully when exposing this API.

---

- Back an Opigno LMS native mobile app with a JSON login + JWT token flow.
- Let the app authenticate once (`POST /api/v1/token`) and reuse the JWT for later calls.
- Serve the training catalogue and categories to the app (`/api/v1/training/*`).
- Return a learner's latest active trainings and progress to the mobile dashboard.
- Expose per-user profile info (progress, time spent, certificates, badges) to the app.
- Power in-app private messaging (list threads, read, post messages) with entity-access checks.
- Feed LMS statistics/years to the app for admins with the statistics dashboard permission.
- Provide Moxtra meeting credentials/meetings to the app.
- Send OneSignal push notifications to devices via the `opigno_onesignal` submodule.
- Reuse core flood protection to throttle brute-force login attempts against the JSON auth endpoint.
- Manage which REST resources are enabled through the RESTui UI.
- Sign tokens with a managed Key (via the `key` module) rather than a hard-coded secret.
- Enumerate LMS users/groups for the app's people picker (review access before public exposure).
- Integrate a headless mobile client without building a bespoke API layer.
- Support offsite/native clients that cannot use Drupal session cookies directly.
- Localize the API to an existing Opigno install's trainings, classes and memberships.
