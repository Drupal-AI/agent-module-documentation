# Asset libraries (api)

The module's only public "API" is the two asset libraries it registers. They are **not** declared
in a static `vuejs.libraries.yml`; they are generated at runtime by `hook_library_info_build`
(`vuejs.module`, `vuejs_library_info_build()` line 38) from the `vuejs.settings` config.

## The libraries

| Library id | Runtime | Built when |
|---|---|---|
| `vuejs/vue` | full Vue runtime (Vue 2 or 3, whatever the path/version points at) | `vue.enabled` is TRUE **and** `vue.path` is non-empty |
| `vuejs/petitevue` | `petite-vue` build | `petitevue.enabled` is TRUE **and** `petitevue.path` is non-empty |

Because generation is conditional, a library that is disabled or has an empty path **does not
exist** — attaching it then does nothing. Default install: `vue` enabled (CDN), `petitevue`
disabled, so only `vuejs/vue` is present until you enable petite-vue on the settings form.

## Attaching a library

Three equivalent ways (from `README.md`), same for `vuejs/vue` and `vuejs/petitevue`:

```twig
{{ attach_library('vuejs/vue') }}
```

```php
function MYMODULE_page_attachments(array &$attachments) {
  $attachments['#attached']['library'][] = 'vuejs/vue';
}
```

```yaml
# In MYMODULE.libraries.yml — declare it as a dependency of your own library.
my_widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - vuejs/vue
```

## How the definition is generated

`_vuejs_vue_generate_library_definition()` (line 61) and
`_vuejs_petitevue_generate_library_definition()` (line 90) produce a standard Drupal library array:

- `js` has a single entry keyed by the configured `path`. When `installation` is not `local` the
  entry is marked `external => TRUE` (a remote `<script src>`); for `local` it is `external => FALSE`
  and Drupal serves the file from the given path (typically under `/libraries/…`).
- `minified => TRUE` is always set (the prod builds are already minified; the dev build is not
  re-minified).
- `version` = the configured `cdn_version` for a CDN install, or the literal string `VERSION` for a
  local install (the module cannot know the on-disk version).
- `license` is set to MIT (Vue's own license), `gpl-compatible => TRUE`.
- **petite-vue only:** `defer` and `init` script attributes are added when the matching config
  booleans are TRUE (line 118-123) — `init` triggers petite-vue's manual-init mode.

## Notes for an agent

- After changing `vuejs.settings` programmatically, clear the library cache so the new definition is
  picked up: `\Drupal::service('library.discovery')->clearCachedDefinitions();` (the settings form
  and the update hooks do this).
- The `path` is emitted verbatim as the script source. A `local` path is resolved relative to the
  Drupal root, so it usually begins `/libraries/…`. A CDN path is a protocol-relative URL such as
  `//unpkg.com/vue@3.5.13/dist/vue.global.prod.js`.
- There is no `Drupal.vue` JS behavior, wrapper, or component API shipped — the module only makes
  the upstream Vue global available; your own JS uses the global `Vue` / `PetiteVue` object.
