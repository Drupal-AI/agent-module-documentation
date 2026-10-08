<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Sticky

One global settings form drives the whole module. UI: **Configuration → System → Sticky**
(`/admin/config/system/sticky`, route `sticky.sticky_settings_form`, permission
`administer sticky`). All values live in the **`sticky.settings`** config object and are read by
`StickyManager::getJsSettings()` into `drupalSettings.sticky` on every page.

## Settings keys, types, defaults

| Key | Form field | Default | Meaning (garand/sticky option) |
|---|---|---|---|
| `selector` | DOM Selector (textfield) | `.menu--main` | CSS selector of the element to make sticky. **Global — one selector site-wide.** |
| `top_spacing` | Top spacing (number) | `0` | Pixels between page top and the element's top. Saved as int. |
| `bottom_spacing` | Bottom spacing (number) | `0` | Pixels between page bottom and the element's bottom. Saved as int. |
| `class_name` | Class name (textfield) | `is-sticky` | CSS class added to the element's wrapper when stuck. |
| `wrapper_class_name` | Wrapper class name (textfield) | `sticky-wrapper` | CSS class added to the generated placeholder wrapper. |
| `center` | Center (checkbox) | `false` | Horizontally center the sticky element. |
| `get_width_from` | Get width from (textfield) | `''` | Selector of another element to copy a fixed width from. |
| `width_from_wrapper` | Width from wrapper (checkbox) | `true` | Match the sticky element's width to the wrapper (only when `get_width_from` is empty). |
| `responsive_width` | Responsive width (checkbox) | `false` | Recalculate widths on window resize (uses `get_width_from`). |
| `z_index` | Z-index (textfield) | `auto` | Stacking order of the stuck element. |

Config **schema** is shipped in `config/schema/sticky.schema.yml` (typed: `selector`,
`class_name`, `wrapper_class_name`, `get_width_from`, `z_index` = string; `top_spacing`,
`bottom_spacing` = integer; `center`, `width_from_wrapper`, `responsive_width` = boolean). The
defaults above are **form fallbacks** — the module ships **no** `config/install` default, so until
the form is saved once the `sticky.settings` keys may be unset (the `?:` fallbacks in the form and
the null values from `StickyManager` apply).

## Read / write with drush

```bash
drush cget sticky.settings                    # whole config
drush cget sticky.settings selector           # just the selector
drush cset sticky.settings selector '.header-wrapper' -y
drush cset sticky.settings top_spacing 20 -y
```

Or programmatically:

```php
\Drupal::configFactory()->getEditable('sticky.settings')
  ->set('selector', '#footer')
  ->set('top_spacing', 0)
  ->set('z_index', '1000')
  ->save();
```

## How it reaches the page

`StickyHooks::pageAttachments()` (`hook_page_attachments`, in `src/Hook/StickyHooks.php` — an
attribute-based `#[Hook('page_attachments')]` implementation) runs on every page:

1. `$attachments['#attached']['drupalSettings']['sticky'] = \Drupal::service('sticky.manager')->getJsSettings()`
   — the ten keys above.
2. Adds the `sticky/sticky` library (`js/sticky.js`), which depends on `sticky/sticky.library`
   → the external file **`/libraries/sticky/jquery.sticky.js`**.

So two things must be true for it to work: the **target element must exist** in the rendered
markup for `selector`, and the **garand/sticky library must be installed** at
`/libraries/sticky/` (download from https://github.com/garand/sticky, or let
`composer/installers` place it). The module itself has no other Drupal module dependencies.

## Permission

`administer sticky` (`restrict access: TRUE`) — gates the settings form. That is the only
permission the module defines.

## Help

`StickyHooks::help()` implements `hook_help`: on `help.page.sticky` it renders the module's
`README.md` inside a `<pre>` block. No behavior beyond documentation display.
