<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Content Hub unsubscribe content (acquia_contenthub_unsubscribe_checkbox) — agent index

**Surfaces a per-entity checkbox that stops a Content Hub subscriber entity from being auto-updated, and pushes a `disable_syndication` interest-list update to Content Hub on submit.**

- **Version:** 3.1.x  •  **Core:** `^8.8 || ^9 || ^10 || ^11`  •  **Package:** Acquia ContentHub  •  **License:** GPL-2.0-or-later
- **Depends on:** `acquia_contenthub:acquia_contenthub`, `acquia_contenthub:acquia_contenthub_unsubscribe` (composer `require` is empty; these are Drupal deps).
- **No routes, permissions, config, services, plugins, schema, or Drush of its own.** The whole module is two functions in `acquia_contenthub_unsubscribe_checkbox.module`.

## What it actually is

- `hook_form_alter(&$form)` — only acts when `$form['acquia_contenthub_unsubscriber_sync']` exists (that element is provided by `acquia_contenthub_unsubscribe`). It forces `#access = TRUE`, relabels the checkbox *"Check to desynchronise content"*, sets a description, and appends `acquia_contenthub_unsubscribe_checkbox_sync_state_submit` to `$form['actions']['submit']['#submit']`.
- `..._sync_state_submit($form, $form_state)` — the submit handler. On the entity from `$form_state->getFormObject()->getEntity()` it sets the subscriber tracker status and, if a webhook UUID is configured and updates should be sent, calls the Content Hub client.

## Mechanism / services used (from source)

- Tracker: `\Drupal::service('acquia_contenthub_subscriber.tracker')` → `setStatusByTypeId(type, id, SubscriberTracker::AUTO_UPDATE_DISABLED)` when checked, else `SubscriberTracker::QUEUED`.
- Config: `\Drupal::service('acquia_contenthub.configuration')` → webhook UUID + `shouldSendContentHubUpdates()` gate.
- Client: `\Drupal::service('acquia_contenthub.client.factory')->getClient($settings)->updateInterestListBySiteRole($webhook_uuid, 'subscriber', ['uuids' => [$uuid], 'disable_syndication' => $bool])`, wrapped in try/catch that logs to the `acquia_contenthub` channel.

## Details

- **The form-alter, submit flow, service calls, and operating notes** → [api/unsubscribe-flow.md](api/unsubscribe-flow.md)

**Security:** no endpoints, routes, or permissions of its own; the checkbox and its submit handler ride on the host entity form's existing edit-access and form token. TLS for the Content Hub call lives in `acquia_contenthub`, not here.
