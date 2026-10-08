# Domain Alias Extras (domain_alias_extras) 3.0.x

![Domain Alias Extras settings form (/admin/config/domain/domain_alias_extras)](../../../../../../../../screenshots/domain_alias_extras/3.0.x/settings.png)

Utility add-on for Domain Alias: an admin form to edit the named environments (e.g. local, staging, production) used when defining domain aliases.

## Facts

- **Depends on:** `domain:domain_alias` (info.yml).
- **Package:** Domain. **Core:** `^10.2 || ^11`.
- **Route:** `domain_alias_extras.settings` — path `/admin/config/domain/domain_alias_extras`, `_form: \Drupal\domain_alias_extras\Form\DomainAliasExtrasSettingsForm`, requires permission `administer domains` (`domain_alias_extras.routing.yml`). This is the `configure:` route (info.yml).
- **Menu link:** `domain_alias_extras.settings`, parent `domain.admin`, weight 20 (`domain_alias_extras.links.menu.yml`).
- **Form:** `DomainAliasExtrasSettingsForm` (`src/Form/DomainAliasExtrasSettingsForm.php`) — `ConfigFormBase` + `RedundantEditableConfigNamesTrait`; form id `domain_alias_extras_settings_form`. One textarea "Development environments" bound to `#config_target` `domain_alias.settings:environments`.
- **Service / hook:** `Drupal\domain_alias_extras\Hook\DomainAliasExtrasHooks` (`domain_alias_extras.services.yml`) implements `hook_domain_config_ui_disallowed_routes_alter()` (`#[Hook(...)]`), appending `domain_alias_extras.settings` to the disallowed list. Legacy `.module` shim marked `#[LegacyHook]`.
- **Own config/schema:** none — it edits `domain_alias.settings` owned by the base module.
- **Permissions:** none defined (no `*.permissions.yml`).
- **Plugins / Drush:** none.

## How to use

Go to `/admin/config/domain/domain_alias_extras` (Domain Alias Extras, under the Domain admin menu; needs the `administer domains` permission). The "Development environments" textarea takes one environment name per line. On save the input is trimmed, empty lines are dropped, `default` is prepended if absent, and the result is stored as a re-indexed sequence in `domain_alias.settings:environments`. A `#process` callback renders the stored array back to newline-separated text on load. Because the hook adds this route to Domain Config UI's disallowed routes, the environments list is a single site-wide value and is not offered as a per-domain override.
