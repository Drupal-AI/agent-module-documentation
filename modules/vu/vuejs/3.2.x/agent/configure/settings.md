# Settings form (configure)

Route `vuejs.settings` → `/admin/config/development/vuejs`, form
`Drupal\vuejs\Form\SettingsForm` (form id `vuejs_settings`), permission
`administer vuejs configuration` (`restrict access: true`). It edits the single config object
`vuejs.settings`, which has two parallel mappings: `vue` and `petitevue`.

## Config keys (`vuejs.settings`)

| Key | Type | Values / default | Meaning |
|---|---|---|---|
| `vue.enabled` | bool | default `true` | Register the `vuejs/vue` library. Unchecked ⇒ library not built. |
| `vue.installation` | string | `local` or `cdn` (default `cdn`) | Where the file comes from. |
| `vue.path` | string | default `//unpkg.com/vue@3.5.13/dist/vue.global.prod.js` | The script src. For `local`, usually `/libraries/vue/package/dist/vue.global.prod.js`. Empty ⇒ library not built. |
| `vue.cdn_provider` | string | `unpkg` \| `cdnjs` \| `jsdelivr` (default `unpkg`) | Used to compute `path` on submit when installation is `cdn`. |
| `vue.cdn_version` | string | default `3.5.13` | Version to request from the CDN; also becomes the library `version`. |
| `petitevue.enabled` | bool | default `false` | Register the `vuejs/petitevue` library. |
| `petitevue.installation` | string | `local` \| `cdn` (default `cdn`) | As above. |
| `petitevue.path` | string | default `//unpkg.com/petite-vue@0.4.1/dist/petite-vue.iife.js` | As above. |
| `petitevue.cdn_provider` | string | `unpkg` \| `cdnjs` \| `jsdelivr` | As above. |
| `petitevue.cdn_version` | string | default `0.4.1` | As above. |
| `petitevue.defer` | bool | default `false` | Adds the `defer` attribute to the petite-vue `<script>`. |
| `petitevue.init` | bool | default `false` | Adds the `init` attribute (petite-vue manual-init mode). |

`installation`, `cdn_provider` values are constrained by the config schema (`Choice`) in
`config/schema/vuejs.schema.yml`.

## Form behaviour

- Two checkboxes (`vue_enabled`, `petitevue_enabled`) toggle each fieldset; per fieldset, an
  `installation` select shows either the CDN fields (`cdn_provider` + `cdn_version`) or the `path`
  textfield via `#states`.
- **Validation** (`validateForm`, line 230): `cdn_version` for both runtimes must match
  `^(v)?\d+\.\d+\.\d+(-(alpha|beta|rc)\.\d)?$`, else "Version format is incorrect."
- **Submit** (`submitForm`, line 249): when `installation === 'cdn'` and the runtime is enabled, the
  `path` is **recomputed** from `cdn_provider` + `cdn_version`. For `vue`, the filename depends on the
  version — `vue.global.prod.js` for `>= 3.0.0`, otherwise `vue.min.js` (Vue 2). Provider URL shapes:
  - `unpkg` (default): `//unpkg.com/vue@<ver>/dist/<file>` / `//unpkg.com/petite-vue@<ver>/dist/petite-vue.iife.js`
  - `jsdelivr`: `//cdn.jsdelivr.net/npm/vue@<ver>/dist/<file>` / `.../npm/petite-vue@<ver>/dist/petite-vue.iife.js`
  - `cdnjs`: `//cdnjs.cloudflare.com/ajax/libs/vue/<ver>/<file>` / `.../libs/petite-vue/<ver>/petite-vue.iife.js`
- On save the config is written and `library.discovery` cached definitions are cleared so the new
  library takes effect immediately.

## Local install (installation = `local`)

The module bundles no JS, so a local install means putting the Vue files under the Drupal
`libraries/` directory and pointing `path` at them:

- **Composer Merge Plugin (Vue 3 only):** `composer require wikimedia/composer-merge-plugin`, add
  `web/modules/contrib/vuejs/composer.libraries.json` to `extra.merge-plugin.include`, then
  `composer update drupal/vuejs`. That file declares the `drupal-library/vuejs-vue` package
  (`vue-3.5.13.tgz`) installed to `libraries/vue`. Set path to
  `/libraries/vue/package/dist/vue.global.prod.js`.
- **Manual:** download `vue-3.5.13.tgz` (or `vue-2.7.16.tgz`, or `petite-vue-0.4.1.tgz`), extract into
  `libraries/vue` (or `libraries/petitevue`), and set the matching path (`…/vue.min.js` for Vue 2).

`hook_requirements` (`vuejs.install`, line 15) adds a WARNING on the status report when a runtime is
enabled + `local` but its file cannot be resolved by `library.libraries_directory_file_finder`
(the check strips a leading `/libraries` before searching).

## Set config from code

```php
\Drupal::configFactory()->getEditable('vuejs.settings')
  ->set('vue', [
    'enabled' => TRUE,
    'installation' => 'cdn',
    'path' => '//unpkg.com/vue@3.5.13/dist/vue.global.prod.js',
    'cdn_provider' => 'unpkg',
    'cdn_version' => '3.5.13',
  ])
  ->save();
\Drupal::service('library.discovery')->clearCachedDefinitions();
```

## Upgrade note

Upgrading from the old `8.x-1.x` branch resets settings to 3.x defaults (`vuejs_update_93001`);
`93002`–`93004` restructure old keys and correct the Vue path. Take a backup before upgrading a
pre-3.x site (see the module's issue #3404816).
