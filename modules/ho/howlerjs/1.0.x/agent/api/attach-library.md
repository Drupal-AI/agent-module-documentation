<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attaching Howler and self-hosting it

`howlerjs` exposes the library; it never attaches it for you. Attach it wherever your markup or
behaviour needs the `Howler`/`Howl` globals, then write plain howler.js.

## Attach from a render array

```php
$build['#attached']['library'][] = 'howlerjs/howler';        // full build
// or, smaller, if you don't need 3D/spatial audio:
$build['#attached']['library'][] = 'howlerjs/howler.core';
// spatial plugin — pulls in howler.core automatically via its dependency:
$build['#attached']['library'][] = 'howlerjs/howler.spatial';
```

## Attach from your own library

In `mymodule.libraries.yml`, depend on it so it loads alongside your behaviour:

```yaml
player:
  js:
    js/player.js: {}
  dependencies:
    - core/drupal
    - howlerjs/howler
```

## Attach from a template / preprocess

```php
function mymodule_preprocess_page(&$variables) {
  $variables['#attached']['library'][] = 'howlerjs/howler';
}
```

## Using it in JS

Howler is a global, not an ES module here (the CDN/local files are UMD builds):

```js
const sound = new Howl({
  src: ['/sites/default/files/clip.webm', '/sites/default/files/clip.mp3'],
  // Autoplay is blocked without a user gesture — start on a click, not on load.
});
document.querySelector('#play').addEventListener('click', () => sound.play());
```

## CDN vs. self-hosting (no configuration needed)

- **Default:** the JS is pulled from the jsDelivr CDN (`howler@2.2.3`), declared as an external asset.
- **Self-host:** drop the matching files into `/libraries/howlerjs/` at the site root —
  `howler.min.js`, `howler.core.min.js`, `howler.spatial.min.js`. `hook_library_info_alter()` in
  `howlerjs.module` detects them through the `library.libraries_directory_file_finder` service and
  rewrites each library's `js` to the local path automatically. No settings, no toggle; the presence
  of the file is the switch. Prefer this for privacy, CSP-strictness, and offline/air-gapped sites.
- **Version note:** the module pins **2.2.3**. If you self-host, ship that version (or newer at your
  own risk) so behaviour matches the declared library metadata.
