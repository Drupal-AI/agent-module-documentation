<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sentry context hooks

## Install / enable

`drush en activecampaign_api_raven_context`. Both `activecampaign_api` and `raven` must be enabled
(hard dependencies); `raven` must be configured with a Sentry DSN for anything to be transmitted.
There is nothing else to configure — no routes, forms, config objects or schema.

## The two implementations

Both live in `activecampaign_api_raven_context.module` and hook into the parent client's payload-alter
points (fired from `Endpoint::createResource()` / `updateResource()` before the HTTP request):

- `..._activecampaign_api_endpoint_createresource_alter(object &$data, Endpoint $endpoint)`
  ```php
  configureScope(function (Scope $scope) use ($data, $endpoint) {
    $scope->setContext('create ' . $endpoint->getResourceName() . 'resource', [
      'data' => json_decode(json_encode($data)),
      'url'  => $endpoint->getUrl(),
    ]);
  });
  ```
- `..._activecampaign_api_endpoint_updateresource_alter(...)` — same shape, context key
  `update <resource>resource`, and the array additionally carries `method => 'updateresource'` and
  `resource => $endpoint->getResourceName()`.

`Sentry\configureScope` and `Sentry\State\Scope` come from the `raven` module's Sentry SDK. The
context is only *sent* to Sentry if an event (error) is actually captured while the scope is active.

## Behavior notes

- **Read-only enrichment.** The hooks never write back to `$data`; they cannot change what is sent to
  ActiveCampaign. Disabling the submodule removes the context but leaves the parent client unchanged.
- **No token exposure.** `getUrl()` is `base_url . '/' . resource` and `$data` is the resource body;
  the ActiveCampaign `Api-Token` is attached by the parent module as an HTTP header, so it is not
  present in either value captured here.
- **Payload contents.** `data` is a JSON round-trip of the exact object being created/updated (for a
  contact: e-mail, first/last name, phone, custom field values). Operators should treat the linked
  Sentry project as a place where that resource data may appear in error events.
- **Double-report guard.** Separately, the parent module's `activecampaign_api_raven_filter_alter()`
  sets `process = FALSE` for an `activecampaign_api\Exception` that was already reported to the
  create/update/delete error webhook, avoiding duplicate Sentry reporting.
