<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent actions, auth & crypt

When the DRD portal calls `/drd-agent`, the `Agent` controller decrypts + authenticates the
request and runs one **Action** class. These are plain classes under
`src/Agent/Action/` (extending `Agent\Action\Base`), not Drupal plugins.

## Actions (`Agent\Action\*`)

`Cron`, `FlushCache`, `MaintenanceMode`, `Info`, `Projects`, `Update`, `UpdateTranslations`,
`Database`, `Download`, `ErrorLogs`, `Php`, `Blocks`, `Session`, `UserCredentials`, `Ping`,
`JobScheduler`, `DomainsEnableAll`, `DomainsReceive`.

## Remote integrations (`Agent\Remote\*`)

- `Monitoring` — exposes the `monitoring` module's sensors.
- `SecurityReview` — exposes `security_review` results.
- `Requirements` — reports runtime requirements (only when the `X-DRD-Version` header is present,
  via `hook_requirements`).

## Authentication (`Agent\Auth\*`)

- `SharedSecret`
- `UsernamePassword`

## Crypt methods (`Crypt\Method\*`, advertised at `/drd-agent-crypt`)

- `OpenSsl`
- `Tls`

## Setup service

`drd_agent.setup` (`Drupal\drd_agent\Setup`, args `@state`, `@datetime.time`, `@request_stack`)
processes the authorization token (used by both the Drush command and the authorize form) and
records the authorized dashboard in State.
