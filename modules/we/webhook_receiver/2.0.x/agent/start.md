<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhook Receiver (webhook_receiver) — agent index

Token-protected POST endpoints dispatching payloads to **plugins**. Routes:
`/webhook-receiver/{plugin_id}/{token}` and `…/simulate`, both **`_access: 'TRUE'`** with
authorisation done in code — the correct arrangement for a webhook, whose caller is a machine with
a token, not a Drupal user. Submodules `webhook_receiver_defer` (queue the work) and
`webhook_receiver_example`. Version **2.0.0**. Core requirement `^10 || ^11`.

**The token design is better than most contrib webhook endpoints.** Tokens are **encrypted at rest
with libsodium**, keyed from `Settings::getHashSalt()` — deliberately not stored in the database
("in case the database is compromised") — and the module **throws rather than degrades** if the
hash salt is empty or under 32 bytes. Compare the usual pattern: a shared secret in configuration,
exported to version control.

**Two caveats:**
1. **The token is compared with `!=`, not `hash_equals()`** — a non-constant-time comparison of a
   secret on an unauthenticated, unmetered endpoint. (Type juggling is not the issue: both operands
   are typed `string`.)
2. **The `info.yml` carries another project's metadata.** Verified: Drupal reports this module as
   **"Expose Status Report"**, described as *"Expose a Drupal site's status report via JSON"*. An
   administrator auditing enabled modules is told the wrong thing about the module that opens the
   site's anonymous POST endpoints.
