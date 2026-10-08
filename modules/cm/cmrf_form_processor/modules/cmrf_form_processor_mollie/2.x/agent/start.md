<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mollie Support for CMRF (cmrf_form_processor_mollie) — agent index

Submodule of **[cmrf_form_processor](../../../../2.x/agent/start.md)**. Bridges the parent's Form
Processor handler with the **Mollie** payment module so that, when a Webform also carries an active
Mollie payment handler, the CiviCRM Form Processor call is **deferred until the Mollie payment
webhook fires** — i.e. CiviCRM is only invoked after the payment provider reports back. Package
`CiviCRM`. Core `^8 || ^9 || ^10 || ^11`. Depends on `mollie:mollie_webform` and
`cmrf_form_processor`. Installed **2.2.20**.

## What it provides (from source)

- **Event subscriber** `MollieFormProcessorSubscriber` (`mollie_ke.event_subscriber`, service in
  `.services.yml`, ctor arg `@entity_type.manager`) subscribed to Mollie's
  `MollieNotificationEvent`. On the event it:
  1. loads the `webform_submission` by `$event->getContextId()`,
  2. filters the Webform's handlers to those provided by `cmrf_form_processor`,
  3. loads the `mollie_payment` transaction by `$event->getTransactionId()`,
  4. for each matching handler that passes `checkConditions()`, calls
     `$handler->postSave($submission, TRUE, ['mollie_payment_id' => …, 'mollie_payment_status' =>
     $transaction->getStatus()])` — running the deferred Form Processor call with the payment
     **status read back from the persisted `mollie_payment` entity** (not from request input).
  It returns HTTP 200 to Mollie normally, 500 on an exception (logged).
- **Handler hook** `hook_webform_handler_invoke_post_save_alter`
  (`cmrf_form_processor_mollie.module`): when a submission is saved and the Webform has an **active
  Mollie payment handler** whose conditions match, it calls `$handler->disable()` on the Form
  Processor handler so the normal post-save submission is suppressed — the webhook path above owns
  the CiviCRM call instead. Also a `hook_help`.
- No routes, permissions, schema, or install hooks of its own. The Mollie webhook/notification
  route itself belongs to the `mollie` / `mollie_webform` project.

See the parent for the handler that is invoked: [[cmrf_form_processor]].
