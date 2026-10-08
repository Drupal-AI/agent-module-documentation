<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — per-domain GA measurement ids

Single settings form, one text field per Domain record.

## Route & access

- Route name: `multidomain_google_analytics.google_admin_settings_form`
- Path: `/admin/config/system/multidomain-google-analytics`
- Title: `Multidomain Google Analytics`; menu parent `system.admin_config_system`
  (Administration › Configuration › System).
- Requirement: `_permission: 'administer google analytics'`. This permission is **provided by the
  `google_analytics` contrib module**, not by this module — so the form is only reachable when Google
  Analytics is installed and the acting role has been granted that permission. (`domain:domain` is the
  only declared `dependencies` entry in the info.yml; the `google_analytics` requirement is implicit
  through this permission string.)

## Form — `MultidomainGoogleAnalyticsAdminSettingsForm` (`src/Form/`)

- Extends `ConfigFormBase`; `getFormId()` → `multidomain_google_analytics_admin_settings`;
  `getEditableConfigNames()` → `['multidomain_google_analytics.settings']`.
- `buildForm()` loads all `domain` entities via `entity_type.manager` →
  `getStorage('domain')->loadMultiple()`. For each domain with a truthy `id()` it renders one element:
  - `#type` `textfield`, `#title` `Google Analytics ID for Domain: @hostname`
    (`@hostname` = `$domain->getHostname()`),
  - `#description` `The ID assigned by Google Analytics for this website container.`,
  - `#maxlength` 64, `#size` 64,
  - `#default_value` = `config('multidomain_google_analytics.settings')->get($domain->id())`.
  - The element **key is the domain id** (`$form['general'][$domain->id()]`).
- If **no** domain records exist, the form renders only a message linking to `domain.admin`
  (Domain records) and returns without any input — you must create Domain records first.

## Config storage

- `submitForm()` iterates every domain and does
  `$config->set($domainId, $form_state->getValue($domainId))->save()` on
  `multidomain_google_analytics.settings`.
- Result: config object `multidomain_google_analytics.settings` holds one key per domain id, e.g.

  ```yaml
  # multidomain_google_analytics.settings
  default: 'G-XXXXXXXXXX'
  example_com: 'G-YYYYYYYYYY'
  ```

- No config schema ships (`config/schema/` absent), so these keys are untyped/schema-less config.
- Set the same value programmatically:

  ```php
  \Drupal::configFactory()
    ->getEditable('multidomain_google_analytics.settings')
    ->set('default', 'G-XXXXXXXXXX') // key = domain entity id
    ->save();
  ```

The stored id for the active domain is what the response subscriber emits into every page — see
[../events/response-subscriber.md](../events/response-subscriber.md).
