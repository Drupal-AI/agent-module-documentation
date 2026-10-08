<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Confirmation — agent index

info.yml name **Confirmation**, version **3.0.1**, core `^10 || ^11`, core-only (no deps).

A **developer framework** for confirm/disconfirm (double-opt-in style) flows. It ships only the
core mechanics — an entity type plus API; the domain logic (what a confirmation actually does)
lives in a per-bundle entity class supplied by an integrating module. See the bundled
`confirmation_example` submodule and `tests/` for the pattern. No admin settings page.

## Model

- **`confirmation`** — content entity (`base_table: confirmation`), the pending action. Bundle
  is `confirmation_type`. Base fields (`src/Entity/Confirmation.php`): `state` (boolean;
  on=Accepted / off=Rejected; unset until answered), `hash` (string, default
  `bin2hex(random_bytes(20))`), `created`, `changed`, `last_sent` (timestamp), `expiration`
  (timestamp, default now + 7 days), `email` (optional; a bundle can require it via
  `RequiredEmailFieldTrait`). Integer auto-increment ids; `label` key = id.
- **`confirmation_type`** — config bundle entity (`ConfirmationType`), admin at
  `/admin/structure/confirmation_types`. Field UI enabled (add your domain fields per bundle).
- Bundle class must override `getConfirmationQuestion()` (base throws `LogicException`); the
  example returns e.g. "Confirm publishing of node: %label".

## Response flow

- Route `entity.confirmation.response_form` → `/confirmation/{confirmation}/{hash}`
  (`confirmation.routing.yml`). The response link carries the entity id and its hash token and is
  intended to be delivered to the recipient over a private channel (typically the email built with
  the `confirmation` tokens). Form = `ConfirmationResponseForm` (extends `EntityConfirmFormBase`).
- `buildForm()`: if `state` already set → shows "already confirmed/disconfirmed"; if
  `isExpired()` → "expired"; otherwise renders radios **Confirm / Disconfirm** + Submit.
- `submitForm()`: sets `state` TRUE (confirm) or FALSE (disconfirm) and saves. Redirect after
  submit is a `@todo` (not implemented).
- `Confirmation::getResponseUrl()` builds the absolute link (`response-form` rel, includes the
  hash). `urlRouteParameters()` supplies `{confirmation}` and `{hash}`.

## Events (reacting to answers)

`Confirmation::postSave()` dispatches `ConfirmationEvent` once, the first time `state` becomes
set (`src/Entity/Event/ConfirmationEvent.php`). Three event names fire, most- to least-specific:
`confirmation.{bundle}.state_settled.{true|false}`, `confirmation.{bundle}.state_settled`,
`confirmation.state_settled`. Subscribe to run domain logic (example subscriber publishes the
linked node on confirm, deletes it on disconfirm).

## Other surface

- **Tokens** (`confirmation.tokens.inc`): type `confirmation` with `response-url`, `email`,
  `expiration` (chainable) — for building the notification link/message.
- **Cron** (`confirmation_cron` → `confirmation.cron` service, `ConfirmationCron`): purges
  expired confirmations, up to 50 per run across bundles (`getEntityIdsToPurge`).
- **Permissions** (`confirmation.permissions.yml`, both restricted): `administer confirmation`,
  `administer confirmation types`. Admin entity collection at `/admin/content/confirmations`.
- **Theme**: `confirmation` (`templates/confirmation.html.twig`) for the canonical view.

## Build your own

Define a bundle config entity (`confirmation_type.*`), a bundle class extending `Confirmation`
that overrides `getConfirmationQuestion()` (and optionally implements
`ConfirmationWithEmailInterface` + `RequiredEmailFieldTrait`), add fields, then create entities
in code and email `getResponseUrl()`. Subscribe to a `state_settled` event to act on the answer.
Mirror `modules/confirmation_example/`.

See also: [usage.md](../usage.md), [human guide](../human-docs/index.md).
