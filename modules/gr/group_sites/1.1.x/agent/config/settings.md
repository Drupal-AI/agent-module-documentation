<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Sites — configuration & settings form

## Install / enable
`composer require drupal/group_sites` then `drush en group_sites`. Requires **Group**
(`drupal/group ^2 || ^3`) which is pulled in as a dependency. Also install a context provider that
returns a Group entity (recommended: `group_context_domain`).

## Config object: `group_sites.settings`
Install defaults (`config/install/group_sites.settings.yml`) and schema
(`config/schema/group_sites.schema.yml`, type `config_object`):

| Key | Type | Install default | Meaning |
|-----|------|-----------------|---------|
| `context_provider` | string | `@group.group_route_context:group` | Context service ID whose Group becomes the active site. The default is the "Group from URL" context that the README **discourages** — pick a real one (e.g. domain-based). |
| `no_site_access_policy` | string | `group_sites.no_site_access_policy.deny_all` | Service ID of the policy run when the context provider returns **no** Group. |
| `site_access_policy` | string | `group_sites.site_access_policy.single` | Service ID of the policy run when a Group **is** found. |

The negotiator adds cache tag `config:group_sites.settings`, so editing this config invalidates
scoped-permission caches.

## Settings form — `GroupSitesSettingsForm`
Route `group_sites.settings` → path `/admin/group/sites/settings`, permission
`configure group_sites`. Form id `group_sites_settings`; extends `ConfigFormBase`; editable config
`group_sites.settings`. Menu link under `system.admin_group`; local task under
`entity.group.collection`.

`buildForm()`:
- Builds the **context_provider** radios from `context.repository`
  `getAvailableContexts()` filtered by `context.handler` `getMatchingContexts()` against
  `EntityContextDefinition::fromEntityTypeId('group')` — so only contexts that expose a **Group**
  are offered. Field is `#required`. Warns against contexts that don't always return a Group.
- Builds **no_site_access_policy** radios from
  `GroupSitesAccessPolicyRepository::getNoSiteAccessPolicies()` and **site_access_policy** radios
  from `getSiteAccessPolicies()`, using each policy's `getLabel()` / `getDescription()`. Both
  `#required`.

`submitForm()` writes each of the three keys only when changed, then `parent::submitForm()`.

## Permissions (`group_sites.permissions.yml`)
Both carry `restrict access: TRUE`:
- `configure group_sites` — access the settings form.
- `use group_sites admin mode` — toggle admin mode (see [../access/admin-mode.md](../access/admin-mode.md)).

## Operating notes
- The negotiator (`GroupSitesNegotiator::getActiveGroup()`) throws `\InvalidArgumentException` if
  the chosen context returns a non-Group value; keep `context_provider` pointed at a Group context.
- Referencing an access-policy service ID that no longer implements the right interface makes the
  calculator throw `GroupSitesAccessPolicyException` — reconfigure after removing a custom policy.
