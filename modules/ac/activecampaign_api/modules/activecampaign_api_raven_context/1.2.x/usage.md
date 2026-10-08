Enriches Sentry (Raven) error reports with the request payload and URL of ActiveCampaign create/update API calls.

---

`activecampaign_api_raven_context` is an optional submodule of `activecampaign_api` that bridges the client library to the `raven` module's Sentry integration. It implements the parent module's `hook_activecampaign_api_endpoint_createresource_alter()` and `hook_activecampaign_api_endpoint_updateresource_alter()` hooks and, for each outbound create or update, calls Sentry's `configureScope()` to attach a named context containing the data object being sent and the endpoint URL. The goal is diagnostic: when an ActiveCampaign API call subsequently throws, the Sentry event carries exactly what Drupal was trying to send, making failures far easier to reproduce. The module has no configuration, no routes, no services and no schema of its own — enabling it (alongside `raven`, which must be configured with a Sentry DSN) is the entire setup. Because the attached context mirrors the resource payload, operators should be aware it can include contact data captured by their Sentry project.

---

- Attach the create/update request payload of ActiveCampaign API calls to Sentry error events.
- Diagnose failing contact/list/tag/field writes by seeing the exact data that was submitted.
- Record the target endpoint URL alongside each captured payload for faster reproduction.
- Improve observability of a Drupal ↔ ActiveCampaign integration without adding custom logging.
- Enable richer breadcrumbs/context in Sentry only where the parent client library is used.
- Pair with the parent module's error-reporting webhook for both self-hosted and Sentry-based monitoring.
- Turn on per-environment (e.g. staging/production) simply by enabling the submodule where `raven` is active.
- Give support engineers the submitted contact/field data in the Sentry issue rather than re-tracing code paths.
- Distinguish create vs. update failures via the separate `create <resource>` / `update <resource>` context keys.
- Leave the parent module's behavior unchanged when the submodule is disabled (hooks simply do not fire).
