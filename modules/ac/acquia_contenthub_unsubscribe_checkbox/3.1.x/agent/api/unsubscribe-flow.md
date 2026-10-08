<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unsubscribe checkbox: form alter + submit flow

Everything lives in `acquia_contenthub_unsubscribe_checkbox.module`. There is no `src/`, no
routing, no permissions, no services file, no config. Enable with
`drush en acquia_contenthub_unsubscribe_checkbox`; it pulls in `acquia_contenthub` and
`acquia_contenthub_unsubscribe`. README: "No configuration is needed."

## The checkbox itself is NOT provided here

The form element `acquia_contenthub_unsubscriber_sync` is created by the
`acquia_contenthub_unsubscribe` submodule. This module only *reveals and wires up* that element.
If it is absent from a form, `hook_form_alter` returns without doing anything.

## `acquia_contenthub_unsubscribe_checkbox_form_alter(&$form)`

Guard: `if (isset($form['acquia_contenthub_unsubscriber_sync']))`. When present it:
- sets `['#access'] = TRUE` (unconditionally makes the checkbox visible on that form),
- sets `['#title']` = *"Check to desynchronise content"* and a `['#description']`,
- if `$form['actions']['submit']` exists, appends
  `'acquia_contenthub_unsubscribe_checkbox_sync_state_submit'` to `['#submit']`.

Note the hook is declared as `hook_form_alter(&$form)` — one parameter only (no `$form_state`,
`$form_id`); it applies to *every* form that carries the element, with a `@todo` in source about
whether to scope it per entity type.

## `acquia_contenthub_unsubscribe_checkbox_sync_state_submit(&$form, $form_state)`

1. Returns early if `!$form_state->hasValue('acquia_contenthub_unsubscriber_sync')`.
2. `$entity = $form_state->getFormObject()->getEntity()`; returns if no entity.
3. Resolves three services via `\Drupal::service(...)`:
   `acquia_contenthub.client.factory`, `acquia_contenthub.configuration`,
   `acquia_contenthub_subscriber.tracker`.
4. Tracker update on the entity's `(getEntityTypeId(), id())`:
   - checkbox on  → `SubscriberTracker::AUTO_UPDATE_DISABLED`, `$disable_syndication = TRUE`;
   - checkbox off → `SubscriberTracker::QUEUED` (a `@todo` notes re-enqueue is not fully wired).
5. Only if `webhook_uuid && uuid && $ach_configuration->getContentHubConfig()->shouldSendContentHubUpdates()`:
   builds `['uuids' => [$entity->uuid()], 'disable_syndication' => $disable_syndication]` and, if
   `getClient($settings)` returns a client, calls
   `$client->updateInterestListBySiteRole($webhook_uuid, 'subscriber', $interest_list)` inside a
   try/catch that logs failures to `\Drupal::logger('acquia_contenthub')->error(...)`.

## Operating notes / caveats

- **Access**: the handler performs no access check of its own — it runs only as the submit handler
  of the host entity form, so it inherits that form's edit access and CSRF form token. It does not
  widen who can reach the form; it only appends behaviour to a form the user could already submit.
- **Latent bug**: the submit handler type-hints `FormStateInterface $form_state`, but the `.module`
  file has no `use Drupal\Core\Form\FormStateInterface;` and no namespace, so the hint resolves to a
  non-existent global `\FormStateInterface`. On sites where this fires it can fatal on the missing
  class. `hook_help()` and the tracker/`SubscriberTracker` import are fine; only the submit hint is
  unimported. Treat the desync action as best-effort and test on your Content Hub version.
- The Content Hub HTTP call is delegated entirely to `acquia_contenthub`'s client factory; this
  module sets no TLS/verify options and passes no secrets in URLs.
