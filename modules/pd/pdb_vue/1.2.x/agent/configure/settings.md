<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: pdb_vue settings

One simple config form controls how every discovered Vue block is rendered site-wide.

- Route: `pdb_vue.form` → `/admin/config/services/pdb-vue`
- Form: `\Drupal\pdb_vue\Form\VueForm` (a `ConfigFormBase`)
- Menu link: `pdb_vue.admin_settings` under `system.admin_config_services` (Configuration › Web services)
- Access: permission `administer decoupled vue blocks`
- Config object: `pdb_vue.settings` (schema `config/schema/pdb_vue.schema.yml`)

## Config keys

| Key | Type | Default | Effect |
|---|---|---|---|
| `version` | string `vue3`\|`vue2` | `vue3` | Which Vue major to load. `vue3` makes `hook_library_info_alter` rewrite each component's `pdb_vue/vue*` dependency to its `vue3*` equivalent. |
| `development_mode` | boolean | `FALSE` | Loads the un-minified `*.dev` / non-`.prod.js`/`.min.js` library files (for Vue Devtools) **and** un-hides the demo example components in the block list (see [../blocks/vue-component.md](../blocks/vue-component.md)). |
| `use_spa` | boolean | `FALSE` | Single-Page-App mode: components (`component: true` in their info.yml) are rendered as custom-element tags into one root Vue app instead of one app per block. Adds the `*.spa-create` / `*.spa-init` libraries. |
| `spa_element` | string | `#page-wrapper` | CSS selector the global SPA Vue instance mounts on. Only used when `use_spa` is on; exposed to JS as `drupalSettings.pdbVue.spaElement`. |

`VueForm::submitForm()` saves the four values and then calls `drupal_flush_all_caches()`, so a
settings change immediately re-derives blocks and re-resolves libraries.

The schema also declares `block.settings.vue_component:*` as `type: ignore` — a Vue block's own
per-instance settings (the component's configuration fields) are not schema-typed by this module.

## Set without the UI

drush:

```bash
drush config:set pdb_vue.settings version vue3 -y
drush config:set pdb_vue.settings use_spa true -y
drush config:set pdb_vue.settings spa_element '#main-content' -y
drush cr
```

PHP:

```php
\Drupal::configFactory()->getEditable('pdb_vue.settings')
  ->set('version', 'vue3')
  ->set('development_mode', FALSE)
  ->set('use_spa', FALSE)
  ->set('spa_element', '#page-wrapper')
  ->save();
drupal_flush_all_caches();
```

Note: `pdb_vue_update_8101` sets `version: vue2` on sites that predate the Vue 3 default, so update
runs will not silently switch an existing site to Vue 3.
