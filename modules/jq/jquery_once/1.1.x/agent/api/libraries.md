<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Libraries and the `$.fn.once` API

## What the module registers

`jquery_once_library_info_alter(&$libraries, $extension)` runs only for `$extension === 'core'`
and **overwrites** two entries wholesale (it replaces, it does not merge):

```php
$libraries['jquery'] = [
  'version' => '3.7.1',
  'license' => ['name' => 'MIT', 'gpl-compatible' => TRUE, 'url' => '…jquery/3.7.1/LICENSE.txt'],
  'js' => ['/' . $path . '/lib/jquery_3.7.1_jquery.min.js' => ['weight' => -20, 'minified' => TRUE]],
];
$libraries['jquery.once'] = [
  'version' => '2.2.3',
  'license' => ['name' => 'GNU-GPL-2.0-or-later', 'gpl-compatible' => TRUE, 'url' => '…jquery-once/2.2.3/LICENSE.md'],
  'js' => ['/' . $path . '/lib/jquery-once-2.2.3/jquery.once.min.js' => ['weight' => -19, 'minified' => TRUE]],
  'dependencies' => ['core/jquery'],
];
```

`$path` is `\Drupal::service('extension.list.module')->getPath('jquery_once')`, i.e. normally
`modules/contrib/jquery_once`. Note the leading `/` — the JS paths become **root-relative**, so
they are recorded with `'type' => 'file'` relative to the docroot rather than to the module.

The identical pair is also declared in `jquery_once.libraries.yml` under this module's namespace:

| Library | Version | File |
|---|---|---|
| `jquery_once/jquery` | 3.7.1 | `lib/jquery_3.7.1_jquery.min.js` |
| `jquery_once/jquery.once` | 2.2.3 | `lib/jquery-once-2.2.3/jquery.once.min.js` (depends on `jquery_once/jquery`) |

So `core/jquery.once` and `jquery_once/jquery.once` both work as a dependency target; prefer
**`core/jquery.once`** because that is what legacy code and old contrib libraries already declare.

## Depending on it

```yaml
# mymodule.libraries.yml
legacy_behaviour:
  version: 1.x
  js:
    js/legacy.js: {}
  dependencies:
    - core/jquery
    - core/jquery.once     # provided again by jquery_once
    - core/drupal
```

```php
// render array
$build['#attached']['library'][] = 'core/jquery.once';
```

## Verifying it on a live site

```bash
drush php:eval '
  $d = \Drupal::service("library.discovery");
  $o = $d->getLibraryByName("core", "jquery.once");
  print $o["version"] . " " . $o["js"][0]["data"] . "\n";'
# 2.2.3 modules/contrib/jquery_once/lib/jquery-once-2.2.3/jquery.once.min.js
```

Same for `getLibraryByName('core', 'jquery')` → `3.7.1` /
`modules/contrib/jquery_once/lib/jquery_3.7.1_jquery.min.js`.
`drush cr` after enabling/disabling — library info is cached in `cache.discovery`.

## The restored jQuery API (jquery-once 2.2.3)

| Call | Returns |
|---|---|
| `$(sel).once(id = 'once')` | the subset of elements **not yet** marked with `id`, now marked |
| `$(sel).findOnce(id = 'once')` | the subset that **has already** been marked with `id` |
| `$(sel).removeOnce(id = 'once')` | the previously-marked subset, with the mark removed |

```js
(function ($, Drupal) {
  Drupal.behaviors.myLegacyThing = {
    attach(context) {
      $('.thing', context).once('my-legacy-thing').each(function () { /* runs once per element */ });
    },
    detach(context) {
      $('.thing', context).removeOnce('my-legacy-thing');
    },
  };
})(jQuery, Drupal);
```

The marker is stored as the DOM class `<id>-processed` plus jQuery data, exactly as in Drupal 9.

## Migration note

Drupal 10+'s own API is `core/once`:

```js
once('my-thing', '.thing', context).forEach((el) => { /* … */ });
```

`jquery_once` leaves `core/once` untouched, so both can be attached on the same page. Treat this
module as an upgrade bridge and migrate call sites to `once()` when you can — there is no config
to unwind, uninstalling is enough.
