<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Derivative delivery: route override, controller, token model

The module defines **no route of its own**. It rewrites core's public image-derivative route and
reuses core's delivery controller.

## Route override

`src/Routing/RouteSubscriber.php` (event subscriber, `RoutingEvents::ALTER` priority `-1025`) alters
the existing `image.style_public` route:

```php
$route->setPath(str_replace('image_style', 'image_styles', $path));           // {image_style} -> {image_styles}
$route->setDefault('_controller', '…\ImageStyleDownloadController::deliverCombined');
```

Nothing else changes — the path pattern, the `_access: 'TRUE'` gate, and the `{scheme}` /
`{required_derivative_scheme}` slugs are core's. So the effective URL is
`…/styles/{image_styles}/{scheme}/…` where `{image_styles}` is the hyphen-joined style-id folder name
(e.g. `square-thumbnail`).

## Controller

`src/Controller/ImageStyleDownloadController.php` extends core
`Drupal\image\Controller\ImageStyleDownloadController` and adds one method:

```php
public function deliverCombined(Request $request, string $scheme, $image_styles, string $required_derivative_scheme): Response {
  return $this->deliver($request, $scheme, CombinedImageStyle::fromName($image_styles), $required_derivative_scheme);
}
```

It parses the folder segment back into a `CombinedImageStyle` (via `fromName()` →
`explode('-')` → `ImageStyle::loadMultiple()`) and hands it to **core's unchanged `deliver()`**. All
of core's logic runs verbatim: token validation, `allow_insecure_derivatives` handling, source-image
existence checks, lock/generation, and the streamed `Response`.

## Token / access model (inherited from core, unchanged)

Public image derivatives are not access-controlled by permission; core protects derivative
generation with the **itok** anti-DDoS token. Core `deliver()` computes:

```php
$token_is_valid = hash_equals($image_style->getPathToken($image_uri), $token) || hash_equals(...);
```

For a combined style, `$image_style` is the `CombinedImageStyle`, whose overridden `getPathToken()`
returns a hyphen-joined string of **per-style HMAC tokens** (`Crypt::hmacBase64` keyed by each
style's private key + hash salt). An attacker cannot forge this without the site private key + hash
salt, so — exactly as with core styles — arbitrary/forced derivative generation is blocked unless the
site has set the non-default `image.settings:allow_insecure_derivatives`.

Because `fromName()` resolves the segment through `ImageStyle::loadMultiple()` (config-entity loads),
the request string is never used as a filesystem path: unknown ids just fail to load. The
`{scheme}` and source path are handled by core `deliver()` exactly as for a normal style. Legitimate
combined URLs are produced by `CombinedImageStyle::buildCombinedUrl()` (and the formatters
submodule), which appends the matching itok.
