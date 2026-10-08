<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Rules API Post provides an 'API POST' Rules action that sends node/entity data as HAL+JSON to a remote REST endpoint, demonstrating how to replicate content between Drupal sites when a rule fires.

---

The module registers a single `@RulesAction` plugin (`RulesAPI_POST`) with context for URL, service link URL, node type, API user/password, session token and title/body/author fields. When the containing rule executes, `doExecute()` builds a serialized entity payload and issues a Guzzle `POST` with HTTP basic auth and an `X-CSRF-Token` header to the configured URL. It installs an `api_post` / `rules_api_post_transaction` content type and fields as a demo. Rules and their actions are configured by administrators (typically `administer rules`), so this action can only be triggered by whoever can build/execute the rule and against the URL configured there — there is no public route and no anonymous action execution. TLS verification is left at Guzzle defaults (enabled); self-signed certs would require the commented-out `verify` option. Credentials are stored in the rule configuration.

---

- POST new nodes to a remote Drupal REST endpoint when a rule fires.
- Replicate content from one site to another on save.
- Authenticate the outbound request with HTTP basic auth.
- Attach an X-CSRF-Token header for the remote REST API.
- Map title/body/author fields into a HAL+JSON payload.
- Trigger the push from any Rules event or condition.
- Serve as a worked example of custom Rules actions.
- Send content to a headless/consumer service.
- Configure the target URL and service URL per rule.
- Include a node-type target for the remote content type.
- Chain the action after content-moderation transitions.
- Push transaction records to an external API.
- Reuse Guzzle's default TLS verification for HTTPS endpoints.
- Keep replication logic in Rules rather than custom code.
- Demonstrate cross-site publishing patterns for editors.
