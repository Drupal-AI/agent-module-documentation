<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Image Styles — agent orientation

Framework module (D9/D10, package "Web services") that offloads image-style derivative generation to an external service. It overrides the core `image_style` config entity (`src/Entity/ImageStyle.php`) and adds a provider select to the image style add/edit form.

- Provides the plugin API only; ships NO concrete remote provider. Custom/contrib code implements `ImageStyleProviderInterface`.
- Provider is chosen by a site builder and stored as the `external_image_styles.provider` third-party setting per image style.
- Key services: `external_image_styles.provider_manager` (plugin manager).
- `buildUri()`/`createDerivative()` throw when a provider is active — URL building is delegated to the provider.
- Conflicts fatally with any other module that overrides the `image_style` entity class.
- Security: the base module performs NO server-side HTTP fetch of a request-supplied URL; provider selection is config, not user input. SSRF risk (if any) lives in a concrete provider plugin, not here.
