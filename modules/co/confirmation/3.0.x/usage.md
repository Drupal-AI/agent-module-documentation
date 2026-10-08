<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A framework of confirmation entities for confirm/disconfirm (double-opt-in style) actions via a link.

---

Confirmation provides a developer framework of confirmation entities — each represents one pending
action a user can confirm or disconfirm through a link (`/confirmation/{confirmation}/{hash}`),
carrying a per-entity hash token and an optional expiry (default 7 days). It ships only the core
mechanics: the `confirmation` content entity, its `confirmation_type` config bundle, a response
form, tokens for building the notification link, and a cron purge of expired records. All
domain-specific behaviour lives in a bundle class and its fields that an integrating module
supplies — see the bundled `confirmation_example` submodule and the tests. Supports Drupal 10 and
11, depends on core only, and has no admin settings page.

When a confirmation's state is first set, the module dispatches a `ConfirmationEvent`
(`state_settled`) so integrating code can run its logic — the example subscriber publishes the
linked node on confirm and deletes it on disconfirm.

---

- Provide confirmation entities modelling pending confirm/disconfirm actions.
- Respond via a link that carries the entity id and hash token.
- Support double-opt-in, approval, and verification flows.
- Carry a per-entity hash and an optional expiry (default 7 days).
- Keep the response form generic; domain logic lives in a per-bundle class.
- Dispatch `state_settled` events when a confirmation is answered.
- Provide `confirmation` tokens (response-url, email, expiration) for notifications.
- Purge expired confirmations on cron (up to 50 per run).
- Ship a `confirmation_example` submodule and tests demonstrating the pattern.
- Depend on Drupal core only.
- Support Drupal 10 and 11.
