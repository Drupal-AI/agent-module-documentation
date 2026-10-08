# Configure the submodules (roles, attributes, provision, content)

All four live under `modules/`, depend on `lti_tool_provider`, use `package: LTI Tool Provider`, and
hang their admin forms off the `admin/config/lti-tool-provider` menu. Enable only the ones you need
(`ddev drush en lti_tool_provider_roles lti_tool_provider_attributes lti_tool_provider_provision
lti_tool_provider_content -y`).

## `lti_tool_provider_roles` — LTI → Drupal role mapping

- Config: `lti_tool_provider_roles.settings`, keys `v1p0_mapped_roles` and `v1p3_mapped_roles`
  (each a mapping of Drupal `user_role` machine name → one LTI role string).
- Forms: `V1p0LtiToolProviderRolesSettingsForm` at `/admin/config/lti-tool-provider/roles/v1p0`,
  `V1p3LtiToolProviderRolesSettingsForm` at `…/roles/v1p3`. Each row is a Drupal role; you pick which
  LTI role (from `lti_tool_provider.settings:v1p0_lti_roles` / `v1p3_lti_roles`) grants it.
- Behaviour: `LtiToolProviderRolesEventSubscriber::onProvisionUser()` (on
  `LtiToolProviderEvents::PROVISION_USER`) iterates the mapped roles and **adds** the Drupal role when
  the launch's LTI roles contain the mapped LTI role, **removes** it otherwise, then saves the user.
  Roles therefore re-sync on every launch (README warns: an Instructor in one course, Learner in
  another, flips on each launch). Only roles you explicitly map are touched.

## `lti_tool_provider_attributes` — LTI → user field mapping

- Config: `lti_tool_provider_attributes.settings`, keys `v1p0_mapped_attributes` /
  `v1p3_mapped_attributes` (mapping of Drupal `user_attribute` field name → LTI attribute/claim key).
- Forms: `V1p0LtiToolProviderAttributesSettingsForm` at `/admin/config/lti-tool-provider/attributes/v1p0`,
  `V1p3…` at `…/attributes/v1p3`.
- Behaviour: `LtiToolProviderAttributesEventSubscriber::onProvisionUser()` (on `PROVISION_USER`) does
  `$user->set($user_attribute, <launch value>)` for each mapping and saves. For 1.0 the value is
  `context[$lti_attribute]`; for 1.3 it is `payload->getClaim($lti_attribute)`.

## `lti_tool_provider_provision` — auto-create/load an entity per launch

- Config: `lti_tool_provider_provision.settings`. Per version (`v1p0_*` / `v1p3_*`):
  `entity_type`, `entity_bundle`, `entity_redirect` (bool — redirect the launch to the entity),
  `entity_sync` (bool — re-apply field defaults each launch), `entity_defaults` (mapping of entity
  field `name` → LTI attribute/claim), `allowed_roles_enabled` (bool) and `allowed_roles` (mapping of
  LTI role → bool gate).
- Forms: `V1p0LtiToolProviderProvisionSettingsForm` at `/admin/config/lti-tool-provider/provision/v1p0`,
  `V1p3…` at `…/provision/v1p3`.
- Behaviour: service `lti_tool_provider_provision.provision` (`ProvisionService`). On
  `LtiToolProviderEvents::LAUNCH`, `LtiToolProviderProvisionEventSubscriber::onLaunch()` calls
  `ProvisionService::provision($context)`: it looks up an existing `lti_tool_provider_provision`
  record keyed on `consumer_id` + `context_id` + `resource_link_id`; if none, creates the configured
  entity, records the mapping, applies `entity_defaults`, and (if `entity_redirect`) redirects the
  launch to the entity URL. `onCreateProvision()` enforces `allowed_roles`: when enabled, provisioning
  is refused unless the launch carries one of the allowed LTI roles.
- Entity `lti_tool_provider_provision` (fields `consumer_id`, `context_id`, `context_label`,
  `context_title`, `resource_link_id`, `resource_link_title`, `provision_type`, `provision_bundle`,
  `provision_id`); CRUD gated by `administer lti_tool_provider module`
  (`LtiToolProviderProvisionAccessController`).

## `lti_tool_provider_content` — LTI 1.3 Deep Linking content selection

- Config: `lti_tool_provider_content.settings`: `enabled` (bool), `entity_types` (selected content
  entity type ids), `entity_bundles` (`type-bundle` keys), `entity_defaults` (per-bundle field →
  claim map), `owner` (bool — filter list to the current user's own content), `sync` (bool — sync
  entity fields from claims on launch).
- Admin form: `LtiToolProviderContentSettingsForm` at `/admin/config/lti-tool-provider/content`.
- Flow (routes under `/lti/v1p3/content/*`, see [../api/routes.md](../api/routes.md)): the platform's
  deep-linking request reaches `content.select`, which redirects to the `content.list` picker form
  (`LtiToolProviderContentListForm`); selecting an item posts to `content.return`, which builds a
  signed `DeepLinkingLaunchResponse` and returns an auto-submit form back to the platform; a later
  `content.launch` opens the chosen entity. `LtiToolProviderContentEventSubscriber::onLaunch()`
  optionally syncs the entity's fields from the launch claims when `sync` is on.
