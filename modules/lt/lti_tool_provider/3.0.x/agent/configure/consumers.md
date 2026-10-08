# Configure consumers and settings

## Global settings — `lti_tool_provider.settings`

Form `Drupal\lti_tool_provider\Form\LtiToolProviderSettingsForm`, route
`lti_tool_provider.settings` (`/admin/config/lti-tool-provider/settings`, requires permission
`administer site configuration`). Two editable keys:

- `iframe` (bool, default `false`) — "Allow iframe embeds". When on, the site's `X-Frame-Options`
  header is stripped **only** on authenticated requests that carry a valid LTI session context, so an
  LMS can embed the tool in an iframe. Enforced by `RemoveXFrameOptionsSubscriber` (kernel RESPONSE,
  priority -10).
- `destination` (string, default `/`) — internal path the user lands on after a successful launch,
  unless the launch supplies a `custom_destination` (1.0) / `destination` custom claim (1.3).
  `validateForm()` rejects anything not starting with `/` and anything `PathValidator::isValid()`
  fails, so it must be a routable internal path.

The same config object also stores the read-only allow-lists the UI uses to build mapping forms:
`v1p0_lti_launch` / `v1p3_lti_launch` (known launch param / claim keys) and `v1p0_lti_roles` /
`v1p3_lti_roles` (the full IMS role vocabularies). These are populated by
`config/install/lti_tool_provider.settings.yml` and the `hook_update_N` migrations in
`lti_tool_provider.install`.

## Consumer entity — `lti_tool_provider_consumer`

Each remote platform is one `lti_tool_provider_consumer` content entity
(`src/Entity/LtiToolProviderConsumer.php`, `fieldable = FALSE`, admin permission
`administer lti_tool_provider module`). Manage them at:

| Route | Path |
|---|---|
| `entity.lti_tool_provider_consumer.collection` | `/admin/config/lti-tool-provider/consumer` |
| `lti_tool_provider.consumer.add` | `/admin/config/lti-tool-provider/consumer/add` |
| `entity.lti_tool_provider_consumer.canonical` | `…/consumer/{id}/view` |
| `entity.lti_tool_provider_consumer.edit_form` | `…/consumer/{id}/edit` |
| `entity.lti_tool_provider_consumer.delete_form` | `…/consumer/{id}/delete` |

Form `LtiToolProviderConsumerForm` shows/hides fields by the `lti_version` select
(`v1p0` = "LTI 1.0/1.1", `v1p3` = "LTI 1.3") via `#states`.

Base fields (all `string`/512 unless noted):

- `consumer` (required) — human label of the platform.
- `lti_version` (`list_string`, required) — `v1p0` or `v1p3`.
- **LTI 1.0/1.1 fields:** `consumer_key`, `consumer_secret` — the OAuth key/shared secret the LMS
  signs launches with. Give these to the LMS. The launch endpoint for the LMS is `/lti`.
- `name` (required, default `lis_person_contact_email_primary`) — which launch param provides the
  Drupal **username** during provisioning.
- `mail` (required, default `lis_person_contact_email_primary`) — which launch param provides the
  Drupal **email**.
- **LTI 1.3 fields:** `platform_id` (issuer), `client_id`, `deployment_id`, `key_set_url` (platform
  public JWKS), `auth_token_url`, `auth_login_url`, and `public_key` / `private_key` —
  `entity_reference` to **Key** entities (`target_type: key`) holding the tool's RSA keypair. The
  tool publishes its public JWKS at `/lti/v1p3/jwks?client_id=…`; the OIDC login init is
  `/lti/v1p3/login`; the launch endpoint is `/lti/v1p3/launch`.

The tool's own registration (issuer, launch/login URLs, keychain, deployment ids) is assembled from
each consumer on the fly by `LTIToolProviderRegistrationRepository::getRegistrationFromConsumer()`
(uses `<front>` as tool id/audience, the site name as tool name, and the routed launch/login URLs).

## What the LMS must send

For 1.0 the launch is a signed `POST /lti` with `lti_message_type=basic-lti-launch-request`,
`lti_version` in `{LTI-1p0, LTI-1p2}`, a valid `oauth_consumer_key`, `resource_link_id`, and the
configured `name`/`mail` fields (README requires the LMS to expose name + email). For 1.3 it is the
standard OIDC third-party-init → `id_token` + `state` launch. The `destination` custom parameter
(`destination={internal path}`) overrides the global redirect target.
