<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Credential & asset config entities, forms, admin UI

## Install / enable

`drush en cloudflare_sdk` (pulls in `cloudflare_api`). No settings form: the module exposes two
config-entity admin screens under **Configuration → Web services**, both gated by the
`administer cloudflare` permission (`restrict access: true`).

## `cloudflare_credentials` entity

`Entity/Credentials` (`ConfigEntityType` id `cloudflare_credentials`, `config_prefix: credentials`,
`admin_permission: administer cloudflare`). `config_export` is **`[id, label]` only** — deliberately
no account ID or token field. Handlers: `CredentialsListBuilder`, `AdminHtmlRouteProvider`,
`CredentialsForm` (add/edit) + core `EntityDeleteForm`.

Routes (from the route provider):

| link | path |
|------|------|
| collection | `/admin/config/services/cloudflare/credentials` |
| add-form | `/admin/config/services/cloudflare/credentials/add` |
| edit-form | `/admin/config/services/cloudflare/credentials/{cloudflare_credentials}/edit` |
| delete-form | `/admin/config/services/cloudflare/credentials/{cloudflare_credentials}/delete` |

`Form/CredentialsForm` renders only a **Label** textfield, a **machine name**, and a static help
item telling the admin to add `account_id` + `token` to `settings.php` under
`$settings['cloudflare']['credentials']` keyed by the machine name. The form does not collect or
display the token. `configure` in `.info.yml` points at the credentials collection.

### Token scope third-party setting

`Hook/CloudflareSdkHooks::formCloudflareCredentialsFormAlter` (`form_cloudflare_credentials_form_alter`)
adds a **Token scope** select — `auto` (default) / `read-only` / `read-write` (values from the
`TokenScope` enum). The entity builder `_cloudflare_sdk_credentials_builder` (in `.module`) stores it
as third-party setting `cloudflare_sdk.scope`, or unsets it when `auto`/empty. This is the manual
half of hybrid capability detection (see the API doc) used when a locked-down token cannot report
its own permissions. Schema: `cloudflare_sdk.credentials.*.third_party.cloudflare_sdk` (`scope`).

## `cloudflare_asset` entity

`Entity/CloudflareAsset` (`ConfigEntityType` id `cloudflare_asset`, `config_prefix: asset`,
`admin_permission: administer cloudflare`). Records durable **intent** for a tracked Cloudflare
resource; runtime outputs live in State (see provisioning doc). Fields (`config_export`):

| field | meaning |
|-------|---------|
| `id`, `label` | machine name + label |
| `type` | primitive type id (each provider owns its own type ids) |
| `name` | the resource name in the Cloudflare account |
| `credentials` | credential-set id the asset lives under (nullable) |
| `origin` | `managed` (provisioned by the suite) or `external` (registered by hand) |
| `settings` | type-specific map, e.g. `endpoint` for an external asset |

Helpers: `getType/getResourceName/getCredentialsId/getOrigin/getSetting`, `isManaged`/`isExternal`
(external ⇔ `origin === 'external'`). Schema `cloudflare_sdk.asset.*` (settings is a `sequence` of
`ignore`).

Routes: collection / add-form / edit-form / delete-form under
`/admin/config/services/cloudflare/assets`, plus a **canonical detail** route defined explicitly in
`cloudflare_sdk.routing.yml` (`entity.cloudflare_asset.canonical` →
`AssetDetailController::viewAsset`, `_permission: administer cloudflare`).

`Form/CloudflareAssetForm` (the "Register existing asset" entry point) collects label, machine name,
**type** (a select of upstream-registered type labels via `AssetTypeRegistry::options()`, falling
back to a free-text field when none are registered), **resource name**, **credential** (select of
existing credential sets), **origin** radios (defaults to `external` for new assets), and an
**endpoint URL** shown only for external origin (stored under `settings.endpoint`).
`copyFormValuesToEntity` moves the endpoint into `settings`.

`AssetDetailController` renders a core-fields table (type label, name, origin, credential, resolved
URL from `AssetResolverInterface::url()`) plus any kind-specific `detail()` panel. `titleAsset`
falls back to the resource name when the label is empty.

## Menu / action links

- `cloudflare_sdk.links.menu.yml`: "Cloudflare credentials" and "Cloudflare assets" under
  `system.admin_config_services`.
- `cloudflare_sdk.links.action.yml`: "Add credential set" and "Register existing asset" actions on
  the respective collections.

## Asset cleanup hook

`Hook/CloudflareSdkHooks::cloudflareAssetDelete` (`hook_ENTITY_TYPE_delete` for `cloudflare_asset`)
calls `AssetResolver::clear()` to purge the deleted asset's recorded State outputs.
