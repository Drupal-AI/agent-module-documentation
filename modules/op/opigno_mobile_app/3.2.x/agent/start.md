<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Opigno Mobile App — agent index

Server-side REST API + JWT auth for the Opigno LMS native mobile app. Endpoints under `/api/v1/*`.
Depends on `jwt`, `jwt_auth_consumer`, `jwt_auth_issuer`, `key`, `restui`, `rest`, `hal`, `serialization`.

Quick facts:
- Login: `POST /api/v1/token` (`TokenRestResource`) returns a JWT; auth provider `json_auth` (`JsonAuth`) reads `{username,password}` from the JSON body, with core flood protection.
- Domains: trainings/categories (LearningPathController), private messaging (MessagingController, entity-access gated), users (UsersController), statistics (StatisticsController), Moxtra (OpignoMoxtraController).
- Submodule: `opigno_onesignal` — OneSignal push notifications (needs `opigno_notification`).
- Security note: several user/group listing routes use `_access: TRUE` (see `/api/v1/users/get-groups-members`, `/api/v1/user/profile`); the JWT is listed in `_auth` but not required, so anonymous callers can reach some of them.
