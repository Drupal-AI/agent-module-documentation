<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Select2 applies, opts out, and loads its library

## What gets targeted

`select2_all_element_info_alter()` appends `#pre_render` → `Select2::preRenderSelect` to:
- the `select` element type, and
- any element type id that **starts with `select_`** or **ends with `_select`**.

(`date_combo` handling is present but commented out.)

## When it actually attaches Select2

`Select2::preRenderSelect($element)` computes admin context =
`router.admin_context->isAdminRoute()` OR active theme == the configured admin theme. Then:

| Element state | Result |
|---|---|
| `#select2 === TRUE` (or class `select2-enable`) | opt-in → library attached, class `select2-enable` added |
| `#select2 === FALSE` (or class `select2-disable`) | opt-out → returns early, **no library** |
| neither set | falls through to the default (site-wide/admin) criteria and attaches |

So the two ways to **force a decision on one element** are the `#select2` FAPI property or the
`select2-enable` / `select2-disable` CSS class.

For multi-value entity-reference selects (`#field_name` + `#multiple`) it removes the `_none`
option and, when cardinality is limited and > 1, sets `#attributes['data-cardinality']`.
`select2_all_field_widget_form_alter()` stamps `#entity_type`, `#bundle`, `#cardinality` onto
field widgets so the JS can read the limit.

## The libraries

Defined in `select2_all.libraries.yml`:
- **`drupal.select2`** — the module's CSS/JS (`js/select2.js`, `css/select2.css`), depends on
  jQuery, Drupal, drupalSettings, once, and **`select2`**. This is what gets attached.
- **`select2`** — the upstream library. By default it loads the JS/CSS from the jsDelivr CDN
  (`select2@4.1.0-rc.0`).
- **`select2.ckeditor4`** — extra CSS added as a dependency of `drupal.ckeditor` via
  `hook_library_info_alter()`.

## Serving Select2 locally instead of the CDN

`select2_all_library_info_alter()` checks for **`DRUPAL_ROOT/libraries/select2/dist`**. If that
directory exists, it **replaces** the `select2` library's CDN `js`/`css`/`version` with local
paths:
- `/libraries/select2/dist/js/select2.min.js`
- `/libraries/select2/dist/css/select2.min.css`

To switch from CDN to local: place the Select2 distribution at
`web/libraries/select2/dist/...` (so that `js/select2.min.js` and `css/select2.min.css` exist)
and rebuild caches. Verify the resolved definition:

```php
$lib = \Drupal::service('library.discovery')->getLibraryByName('select2_all', 'select2');
// $lib['js'][0]['data'] is '/libraries/select2/dist/js/select2.min.js' when local,
// or the jsDelivr CDN URL (type 'external') when not.
```

## Trusted callbacks

`Drupal\select2_all\Select2` implements `TrustedCallbackInterface` and whitelists
`preRenderSelect`, `preRenderDateCombo`, `preRenderSelectOrOther`. There is no service and no
plugin — everything is static render-callback plus hooks.
