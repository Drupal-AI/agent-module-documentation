<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image styles over remote originals

Core's image system assumes the original lives in a writable local scheme. This module makes
derivatives of `http://` / `https://` originals work, in two moves. Both are automatic once the
module is enabled — there is nothing to configure.

## 1. The `image_style` entity class is swapped

`remote_stream_wrapper_entity_type_alter()`:

```php
$entity_types['image_style']->setClass('Drupal\remote_stream_wrapper\Entity\ImageStyle');
```

That subclass overrides **only** `buildUri()`. When `file_is_uri_remote($uri)` is TRUE it stores
the derivative under the site's *default* scheme, keeping the original scheme as a path segment:

```
public://styles/<style_id>/<original_scheme>/<host>/<path><.derivative_ext>
```

Concretely (verified on this site, default_scheme `public`):

| Original URI | `buildUri()` result |
|---|---|
| `http://web/core/misc/druplicon.png` | `public://styles/<style>/http/web/core/misc/druplicon.png` |
| `https://example.com/pics/photo.jpg` | `public://styles/<style>/https/example.com/pics/photo.jpg` |
| `public://photo.jpg` (local) | `public://styles/<style>/public/photo.jpg` (core behaviour) |

Non-remote URIs fall through to `parent::buildUri()` unchanged. Check the swap took effect:

```php
\Drupal::entityTypeManager()->getDefinition('image_style')->getClass();
// Drupal\remote_stream_wrapper\Entity\ImageStyle
```

## 2. A delivery route per remote scheme

`remote_stream_wrapper.routing.yml` declares a **route callback**, not static routes:

```yaml
route_callbacks:
  - '\Drupal\remote_stream_wrapper\Routing\RemoteImageStyleRoutes::routes'
```

`RemoteImageStyleRoutes::routes()` skips everything if `image` is not installed, otherwise walks
every registered stream wrapper, keeps the ones where `file_is_wrapper_remote()` is TRUE, and
registers one route per remote scheme:

```
image.style_<scheme>   /<public_directory_path>/styles/{image_style}/<scheme>
   _controller: …\Controller\RemoteImageStyleDownloadController::deliver
   scheme: <scheme>
   required_derivative_scheme: <system.file:default_scheme>
   _disable_route_normalizer: TRUE
   _access: 'TRUE'
```

The scheme is baked into the **path** (not left as the `{scheme}` placeholder core's
`image.style_public` uses) so these routes win over `image.style_public`. On this site that
yields `image.style_http` → `/sites/default/files/styles/{image_style}/http` and
`image.style_https` → `/sites/default/files/styles/{image_style}/https`.

Inspect them:

```php
\Drupal::service('router.route_provider')->getRouteByName('image.style_https')->getPath();
```

## Practical usage

```php
use Drupal\image\Entity\ImageStyle;

$style = ImageStyle::load('thumbnail');
$style->buildUri('https://example.com/pics/photo.jpg');
// public://styles/thumbnail/https/example.com/pics/photo.jpg
$style->buildUrl('https://example.com/pics/photo.jpg');
// https://<site>/sites/default/files/styles/thumbnail/https/example.com/pics/photo.jpg?itok=…
```

Notes:

- A new remote scheme you add only needs to implement `RemoteStreamWrapperInterface` — the route
  callback picks it up on the next router rebuild (`drush cr`).
- `RemoteImageStyleRoutes` calls `$streamWrapperManager->register()` before `getWrappers()`,
  working around the manager returning an empty list during route building.
- Derivatives are ordinary local files, so the usual image-style flush/regeneration applies; the
  remote original is only fetched when the derivative is generated.
