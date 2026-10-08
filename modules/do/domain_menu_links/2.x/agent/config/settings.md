<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config object

## Route & access

- Route **`domain_menu_links.settings`** (`domain_menu_links.routing.yml`), path
  **`/admin/config/domain/domain_menu_links/settings`**, title "Domain menu links settings".
- Permission requirement: **`administer site configuration`** (core admin permission).
- Linked in the admin menu under `domain.admin` as "Domain Menu Links Settings"
  (`domain_menu_links.links.menu.yml`, weight 1). `info.yml` sets `configure:
  domain_menu_links.settings`.

## The form

`src/Form/DomainMenuLinksSettingsForm.php` (`DomainMenuLinksSettingsForm extends ConfigFormBase`),
form id `domain_menu_links_settings`. Injects `config.factory`, `config.typed`, and
`plugin.manager.menu.link`.

- `buildForm()` renders one field: `parent_menu_link_weight`, a `#type => 'number'`, `#required`,
  titled "Parent menu link weight", defaulting to the stored value or `-11`.
- `submitForm()` saves the value into config `domain_menu_links.settings` and then calls
  `$this->menuLinkManager->rebuild()` so the toolbar link's new weight takes effect immediately.
- `getEditableConfigNames()` = `['domain_menu_links.settings']`.

## Config object

Config name **`domain_menu_links.settings`** (`DomainMenuLinksConstants::SETTINGS`).

- Install default (`config/install/domain_menu_links.settings.yml`):
  `parent_menu_link_weight: '-11'`.
- Schema (`config/schema/domain_menu_links.schema.yml`): `type: config_object`, single key
  `parent_menu_link_weight` of `type: string`, label "Parent menu link weight".

Note the value is stored/typed as a **string** even though the form field is a number; the parent
`DomainMenu::getWeight()` returns it verbatim as the menu link weight.

## Update hook

`domain_menu_links.install`: `domain_menu_links_update_9001()` sets
`parent_menu_link_weight` to `'-11'` on existing sites (aligns older installs with the current
default).

## Drush

```
# Read / set the parent toolbar link weight
ddev drush config:get domain_menu_links.settings parent_menu_link_weight
ddev drush config:set domain_menu_links.settings parent_menu_link_weight '-15' -y
# After a manual config change, rebuild menu links so the weight applies:
ddev drush cr
```
