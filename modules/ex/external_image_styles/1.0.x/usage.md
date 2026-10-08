<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Image Styles lets a site delegate image derivative (image style) creation to an external service instead of generating the resized images on the Drupal server.

It is a developer/site-builder framework: it ships the plugin API (an `ImageStyleProvider` annotation, a provider plugin manager, and a base plugin) plus an override of the core `image_style` config entity, but it does NOT ship a concrete remote provider. A contrib/custom module supplies the actual provider plugin that builds the external URL. The chosen provider is stored as a third-party setting on each image style, selected by the site builder on the image style add/edit form.

---

- Requires the core `image` module; Drupal 9 or 10.
- Enable with `drush en external_image_styles`; no configuration UI of its own.
- On `admin/config/media/image-styles/add` a new "Image Style Provider" select appears, defaulting to "Drupal Core". Choosing a provider stores it as the `external_image_styles.provider` third-party setting on that image style.
- Provider plugins are discovered via the `@ImageStyleProvider` annotation under `Plugin/ImageStyleProvider`.
- To add a provider, implement `ImageStyleProviderInterface` (optionally extend `ImageStyleProviderBase`) and, for cacheable URLs, `CacheableUrlImageStyleInterface`.
- The module throws a RuntimeException at enable-time if another module already overrides the `image_style` entity class (incompatible with other image_style class overrides).

---

- Serve image-style derivatives from an external image-resizing/CDN service instead of the local server.
- Keep Drupal's normal image style UI while redirecting URL generation to a remote provider.
- Avoid on-server GD/ImageMagick derivative generation for scalability.
- Select "Drupal Core" per style to keep default behavior for some styles and external for others.
- Store the provider choice per image style as a third-party setting.
- Build a permanently-cacheable GeneratedUrl for external derivatives via `buildGeneratedUrl()`.
- Delegate `buildUrl()`, `flush()`, `transformDimensions()`, `getDerivativeExtension()`, and `supportsUri()` to the provider plugin.
- Fall back to core behavior when a provider throws a `DelegateException`.
- Provide a plugin manager (`external_image_styles.provider_manager`) for discovering providers.
- Implement a custom provider plugin to integrate a specific SaaS image service.
- Extend `ImageStyleProviderBase` for the common provider boilerplate.
- Prevent local derivative creation: `buildUri()`/`createDerivative()` throw when a provider is set.
- Add the provider as a config dependency of image styles that use it.
- Use with responsive image styles that reference the overridden image style entity.
- Diagnose conflicts when another module overrides `image_style` (fatal at cache rebuild).
- Serve as a base for building a Cloudinary/imgix/thumbor-style integration.
- Note it is a framework: without a provider module it behaves like Drupal Core.
