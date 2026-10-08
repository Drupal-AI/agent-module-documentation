Consumer Image Styles lets a decoupled Consumer declare which image styles it needs, then adds derivative (image-style) links to image files in that consumer's JSON:API responses.

---

The module integrates [Consumers](https://www.drupal.org/project/consumers) with JSON:API. It adds an unlimited `image_styles` base field (entity reference to `image_style`) to the `consumer` entity, so each registered consumer (front end) can be configured with the exact set of image styles it will render. On JSON:API responses it decorates the core link-collection normalizer (`serializer.normalizer.link_collection.consumer_image_styles`) so that, for image file resources, it appends a derivative link per image style the negotiated consumer requested — each link carrying the absolute derivative URL plus `width`/`height`/`type` metadata (`ImageStylesProvider::buildDerivativeLink()`). A JSON:API `ResourceFieldEnhancer` plugin, `image_styles` (`Drupal\consumer_image_styles\Plugin\jsonapi\FieldEnhancer\ImageStyles`), can be attached to an image field via jsonapi_extras to add the same links, optionally refined to a custom selection of styles (config schema `jsonapi_extras.enhancer_plugin.image_styles`). The service `consumer_image_styles.image_styles_provider` exposes `loadStyles($consumer)` and `buildDerivativeLink()`. It requires `image`, `consumers`, and `jsonapi`; it has no admin settings page of its own (you configure the consumer entity and, optionally, the field enhancer). The consumers listing is augmented with an "Image Styles" column.

---

- Give a React/Next.js front end exactly the image derivatives it needs via JSON:API.
- Attach `thumbnail`, `medium`, and `large` styles to a mobile app consumer.
- Serve responsive image variants to a decoupled site without hardcoding derivative URLs.
- Let each consumer (web, mobile, TV) request its own set of image styles.
- Expose absolute derivative links with width/height metadata for client-side `srcset`.
- Configure the image styles a consumer needs on the consumer entity edit form.
- Add derivative links to image files in api_json responses automatically per consumer.
- Use the `image_styles` field enhancer on a specific image field via jsonapi_extras.
- Refine the enhancer to a custom subset of styles for one image field.
- Avoid shipping every image style to every client by scoping styles per consumer.
- Provide art-directed/responsive images to a headless storefront.
- Read a consumer's configured styles programmatically with `loadStyles($consumer)`.
- Build a single derivative link for a URI + style with `buildDerivativeLink()`.
- Include image dimensions in JSON:API so clients can lay out images before load.
- Support external/remote image sources by emitting derivative links without downloading them.
- See which image styles each consumer has from the consumers admin list column.
- Drive a design system's image sizes from backend image-style config for decoupled apps.
- Keep front-end and back-end image sizing in sync through consumer configuration.
- Add newly created image styles to a consumer to roll them out to that client.
- Power a Gatsby/Nuxt image pipeline with Drupal-generated derivatives.
- Negotiate image styles by the consumer identified on the JSON:API request.
- Offer different image quality/size sets to free vs premium client apps.
- Provide `jsonapi:image-derivative` rel links that clients can discover generically.
