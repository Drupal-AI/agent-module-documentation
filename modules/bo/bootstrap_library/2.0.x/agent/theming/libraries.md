<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The asset libraries

`bootstrap_library.info.yml` declares
`libraries: [bootstrap_library/bootstrap, bootstrap_library/bootstrap-dev, bootstrap_library/bootstrap-cdn]`,
and `bootstrap_library.libraries.yml` defines three of the four (the CDN one is generated).

| Library id | CSS | JS | Selected when |
|---|---|---|---|
| `bootstrap_library/bootstrap` | `/libraries/bootstrap/css/bootstrap.min.css` | `/libraries/bootstrap/js/bootstrap.min.js` | `cdn.bootstrap == 0` and `minimized.options == 1` |
| `bootstrap_library/bootstrap-dev` | `/libraries/bootstrap/css/bootstrap.css` | `/libraries/bootstrap/js/bootstrap.js` | `cdn.bootstrap == 0` and `minimized.options == 0` |
| `bootstrap_library/bootstrap-composer` | `/libraries/bootstrap/dist/css/bootstrap.css` | `/libraries/bootstrap/dist/js/bootstrap.js` | `cdn.bootstrap == 0` and `minimized.options == 2` |
| `bootstrap_library/bootstrap-cdn` | external, from `cdn.options` | external, from `cdn.options` | `cdn.bootstrap` is a non-zero version string |

All three static libraries declare `remote: https://getbootstrap.com/`, an MIT license block
and `dependencies: [core/jquery]`. CSS is registered in the **`theme`** group.

## Local installation layout

```
web/                     # or docroot/
└── libraries/
    └── bootstrap/
        ├── css/bootstrap.css      bootstrap.min.css
        └── js/bootstrap.js        bootstrap.min.js
```

Composer (`twbs/bootstrap`, installed as a `drupal-library`) unpacks the framework with a
`dist/` folder instead — that is what `minimized.options = 2` targets:

```
web/libraries/bootstrap/dist/{css,js}/bootstrap.{css,js}
```

The module ships **no** requirements check for the files (the body of
`bootstrap_library_requirements()` is commented out), so a wrong layout simply produces
404s on the asset URLs.

## The CDN library

`bootstrap_library_library_info_build()` runs on every library-info rebuild:

1. `cdn.bootstrap` falsy → returns `[]` (no `bootstrap-cdn` library exists at all).
2. Otherwise `json_decode(cdn.options)` → `$list = $cdn_options->bootstrap` as an array,
   `$list[$cdn]['css']` becomes a single external CSS asset and each `$list[$cdn]['js']`
   entry an external JS asset (a bare string is wrapped in an array first), all with
   `dependencies: [core/jquery]`.

`cdn.options` is a hard-coded JSON blob returned by `_bootstrap_library_data()` (defined at
the bottom of `src/BootstrapLibrarySettingsForm.php`) and stored by the form in a hidden
field. Versions it offers: Bootstrap **5.2.3, 5.1.3, 5.1.1, 5.0.2, 4.6.0, 4.5.2, 4.4.1,
4.3.1, 4.2.1, 4.1.1, 4.0.0, 3.3.7 → 3.0.0(-noicons), 2.3.2 → 2.0.4**, served from
`cdn.jsdelivr.net` (5.x, incl. a Popper.js file), `stackpath.bootstrapcdn.com` /
`cdnjs.cloudflare.com` (4.x) and `maxcdn.bootstrapcdn.com` (2.x/3.x). The blob also carries
a `fontawesome` section that the module never uses.

Protocol-relative URLs (`//cdn.jsdelivr.net/…`) are used, so the browser follows the page
scheme.

## Attaching it yourself

Nothing stops a theme or module from depending on the library directly instead of relying on
the page-attachment rules:

```yaml
# my_theme.libraries.yml
global-styling:
  dependencies:
    - bootstrap_library/bootstrap
```

```php
$build['#attached']['library'][] = 'bootstrap_library/bootstrap-dev';
```

Note that the `bootstrap-cdn` library only exists while `cdn.bootstrap` is set, so a hard
dependency on it will break when the site is switched back to local files.

## Verifying what is attached

```bash
drush php:eval '$l = \Drupal::service("library.discovery")->getLibraryByName("bootstrap_library", "bootstrap");
  print_r($l["css"]); print_r($l["js"]);'
```

Or load a page with `?bootstrap=no` and diff the emitted `<link>`/`<script>` tags against a
normal load.
