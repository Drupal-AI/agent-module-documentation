<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NG Lightbox settings

Config object **`ng_lightbox.settings`** — the module's only configuration.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `patterns` | string | `''` | Newline-separated paths to lightbox. Must start with `/`. `*` is the wildcard, e.g. `/comment/*/reply`. Empty = nothing is lightboxed. |
| `default_width` | integer | `700` | Dialog width, passed as `width` in `data-dialog-options`. |
| `lightbox_class` | string | `''` | Extra CSS class, passed as `dialogClass`. |
| `skip_admin_paths` | boolean | `true` | When TRUE, links on admin routes are never lightboxed. |
| `renderer` | string | `drupal_modal` | `drupal_modal` ("Core Modal") or `drupal_dialog` ("Core Dialog"); the `drupal_` prefix is stripped to form `data-dialog-type`. |

Schema: `config/schema/ng_lightbox.schema.yml`. Defaults ship in `config/install/ng_lightbox.settings.yml`.

## Admin form

Route `ng_lightbox.settings` → **`/admin/config/media/ng-lightbox`** (menu link under
*Configuration › Media*, title "NG Lightbox"), guarded by the permission
**`administer ng lightbox`** (`restrict access: true`).

Fields map 1:1 to the keys above: *Paths*, *Default Width*, *Lightbox Class*,
*Skip all admin paths*, *Renderer*.

## drush

```bash
drush cget ng_lightbox.settings

# lightbox /contact and everything under /node/
printf '%s\n' '/contact' '/node/*' | drush cset ng_lightbox.settings patterns - -y
drush cset ng_lightbox.settings default_width 900 -y
drush cset ng_lightbox.settings lightbox_class my-lightbox -y
drush cset ng_lightbox.settings skip_admin_paths 0 -y
drush cset ng_lightbox.settings renderer drupal_dialog -y
drush cr
```

or in PHP (note `default_width` must stay an **integer** and `skip_admin_paths` a **boolean** to
satisfy the schema):

```php
\Drupal::configFactory()->getEditable('ng_lightbox.settings')
  ->set('patterns', "/contact\n/node/*")
  ->set('default_width', 900)
  ->set('lightbox_class', 'my-lightbox')
  ->set('skip_admin_paths', FALSE)
  ->set('renderer', 'drupal_dialog')
  ->save();
```

## Pattern matching rules

- Patterns and paths are lower-cased before matching; the base path is stripped.
- The **internal path** is tried first (`path.matcher`); if it does not match, the **alias** of
  that path is tried (`path_alias.manager`), so `/node/12` matches a pattern written against its
  alias and vice versa.
- URLs that are external, empty, or do not start with `/` are never lightboxed.
- Results are cached per path inside the service for the duration of the request.

## Marking a single link by hand

Add the class `ng-lightbox` to the anchor — `hook_link_alter()` also triggers on that class,
regardless of `patterns`:

```php
$build['link'] = [
  '#type' => 'link',
  '#title' => t('Read the terms'),
  '#url' => Url::fromUri('internal:/terms'),
  '#options' => ['attributes' => ['class' => ['ng-lightbox']]],
];
```

## Verify the effect

```bash
drush ev '$l = ["options" => []];
\Drupal::service("ng_lightbox")->addLightbox($l);
print json_encode($l) . PHP_EOL;'
# {"options":{"attributes":{"class":["use-ajax"],"data-dialog-type":"modal",
#  "data-dialog-options":"{\"width\":700,\"dialogClass\":\"\"}"}}}

drush ev 'var_dump(\Drupal::service("ng_lightbox")
  ->isNgLightboxEnabledPath(\Drupal\Core\Url::fromUserInput("/contact")));'
```
