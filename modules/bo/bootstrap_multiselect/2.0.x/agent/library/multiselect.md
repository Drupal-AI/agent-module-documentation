<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bootstrap_multiselect/multiselect` library

Everything this module ships lives in two files: `bootstrap_multiselect.libraries.yml` and
`bootstrap_multiselect.module`. There is no `src/`, no config, no routes.

## Install / enable
`composer require drupal/bootstrap_multiselect` then `drush en bootstrap_multiselect`. No
configuration step — there is no settings form and `configure` is null. Enabling the module simply
makes the asset library available for attaching.

## The library definition (`bootstrap_multiselect.libraries.yml`)
Key `multiselect` → attach as `bootstrap_multiselect/multiselect`:
- `remote: https://github.com/davidstutz/bootstrap-multiselect`, `version: 1.1.1`,
  license Apache 2.0 (gpl-compatible).
- **CSS (theme group, external):**
  `//cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/1.1.1/css/bootstrap-multiselect.min.css`
- **JS (external, `defer: true`):**
  `//cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/1.1.1/js/bootstrap-multiselect.min.js`
- `dependencies: [core/jquery, core/drupal]`.

URLs are protocol-relative (`//cdnjs...`), so they follow the page scheme. Note the module ships
**no `js/` or `css/` of its own** and no Drupal.behaviors — it does not initialise the plugin on any
element. It also declares no `bootstrap`/dropdown CSS dependency; the checkbox dropdown expects the
site theme to already provide Bootstrap's dropdown component styling.

## CDN → local override (`bootstrap_multiselect_library_info_alter()`)
`bootstrap_multiselect.module` implements `hook_library_info_alter()`. Only for this module's own
libraries, it uses the core service `library.libraries_directory_file_finder` to look for:
- `bootstrap_multiselect/js/bootstrap-multiselect.min.js`
- `bootstrap_multiselect/css/bootstrap-multiselect.min.css`

If found (under the site/profile `libraries/` directory), it rewrites the library's `js`/`css` to
the local path with `external => FALSE`, `minified => TRUE`. If a file is absent, that asset stays
on the CDN. So the expected local layout is:

```
libraries/
  bootstrap_multiselect/
    js/bootstrap-multiselect.min.js
    css/bootstrap-multiselect.min.css
```

(Reference: https://www.drupal.org/node/3099614.) This is the only way to control where the assets
come from — there is no admin toggle.

## How to actually use it (consumer side)
The module gives you the library; you wire up the plugin. In a custom module/theme:

1. Attach the library to your render array or form:
   ```php
   $form['field']['#attached']['library'][] = 'bootstrap_multiselect/multiselect';
   ```
2. Initialise the plugin on the `<select multiple>` in your own JS behavior:
   ```js
   Drupal.behaviors.myMultiselect = {
     attach(context) {
       once('bms', 'select[multiple].my-select', context)
         .forEach(el => $(el).multiselect({ /* options */ }));
     }
   };
   ```
Keep the underlying element a real `select[multiple]` so keyboard use, form submission and
assistive tech keep working. Pass plugin options (e.g. `enableFiltering`, `includeSelectAllOption`,
`numberDisplayed`, `nonSelectedText`) per the upstream bootstrap-multiselect docs; the module does
not set or restrict any of them.

## Uninstall
`drush pmu bootstrap_multiselect`. Nothing to clean up — no config entities, state, or schema are
created.
