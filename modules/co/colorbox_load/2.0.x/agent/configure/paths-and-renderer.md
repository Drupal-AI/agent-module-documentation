<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Colorbox Load

Colorbox Load ships **no config of its own**. Everything is in `ng_lightbox.settings`
(module `ng_lightbox`), which is why `colorbox_load.info.yml` declares
`configure: ng_lightbox.settings` → `/admin/config/media/ng-lightbox`.

## The settings keys (all in `ng_lightbox.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `patterns` | string | `''` | Newline-separated paths that open in the lightbox. Must start with `/`. `*` is the wildcard, e.g. `/comment/*/reply`. Empty ⇒ nothing is lightboxed. |
| `renderer` | string | `drupal_modal` | Which main-content renderer to use. Colorbox Load adds **`drupal_colorbox`**; core options are `drupal_modal` and `drupal_dialog`. |
| `default_width` | integer | `700` | Width passed as `data-dialog-options.width`. |
| `lightbox_class` | string | `''` | Extra CSS class, passed as `data-dialog-options.dialogClass`. |
| `skip_admin_paths` | boolean | `true` | When TRUE, admin routes never get the lightbox. |

Installing `colorbox_load` sets `renderer` to `drupal_colorbox` for you
(`colorbox_load_install()`); uninstalling sets it back to NULL.

## Read the current setup

```bash
drush cget ng_lightbox.settings
drush cget ng_lightbox.settings renderer      # expect: drupal_colorbox
```

## Set it with Drush (scriptable)

```bash
drush cset ng_lightbox.settings renderer drupal_colorbox -y
drush cset ng_lightbox.settings default_width 900 -y
drush cset ng_lightbox.settings lightbox_class 'my-overlay' -y
drush cset ng_lightbox.settings skip_admin_paths 0 -y
```

Multi-line `patterns` is easiest from PHP:

```bash
drush php:eval '\Drupal::configFactory()->getEditable("ng_lightbox.settings")
  ->set("patterns", "/node/*\n/gallery/*")
  ->set("renderer", "drupal_colorbox")
  ->save();'
```

## Via the UI

1. Go to *Configuration → Media → NG Lightbox* (`/admin/config/media/ng-lightbox`).
2. **Paths** — one pattern per line, leading slash, `*` wildcard.
3. **Renderer** — choose **Colorbox** (this is the option `colorbox_load` contributes).
4. **Default Width** / **Lightbox Class** / **Skip all admin paths** as needed. Save.

## Opting a single link in

Independent of `patterns`, NG Lightbox lightboxes any link that already carries the
`ng-lightbox` CSS class:

```php
$link = Link::createFromRoute('Details', 'entity.node.canonical', ['node' => 1], [
  'attributes' => ['class' => ['ng-lightbox']],
]);
```

You can also override the admin-path exclusion for one-off paths with
`hook_ng_lightbox_ajax_path_alter($vars)` (an NG Lightbox hook).

## Gotchas

- If `patterns` is empty, nothing happens no matter what `renderer` says.
- The renderer id must be exactly `drupal_colorbox`; NG Lightbox strips the `drupal_` prefix
  to build `data-dialog-type="colorbox"`.
- Admin routes are skipped by default — set `skip_admin_paths: false` to lightbox them.
- `colorbox_load` lightboxes a **page you navigate to**. To lightbox markup that is already
  on the page, use the separate `colorbox_inline` project instead.
