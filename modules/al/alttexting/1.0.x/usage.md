Alttext.ing generates descriptive alternative text for image media using the external api.alttext.ing AI vision service.

---

Alttext.ing integrates with Drupal core Media to fill in image `alt` text using acolono GmbH's `api.alttext.ing` service. It adds a "Generate Alt Text With AI" button to image media widgets (an editor clicks it, the browser polls until the description is ready, and the alt field is filled in), and it can optionally auto-generate alt text every time an image media entity is saved with an empty alt value — either synchronously (the remote service calls a webhook back) or in the background via a queue worker run on cron. Images are first resized/converted through a bundled `alttexting` image style (scaled to 300px wide, WebP) and then either their URL is sent to the service or, for local development, the image is base64-encoded and sent inline. It requires a paid API key, supports per-language descriptions, and provides its own admin permission and settings form under `/admin/config/media/alttexting`.

---

- Auto-generate alt text for newly uploaded image media so editors never leave accessibility text blank.
- Give content editors a one-click "Generate Alt Text With AI" button on the image media edit form.
- Remediate a large backlog of images that are missing alt text.
- Improve WCAG / accessibility compliance across a media-heavy editorial site.
- Improve SEO by ensuring images carry descriptive alt attributes.
- Produce alt text in the media entity's language, using the language name passed to the service.
- Run generation in the background via cron using the `alttexting_media_processor` queue, keeping media saves fast.
- Run generation synchronously when you want alt text populated immediately after save via the webhook callback.
- Support local development where the AI service cannot reach the site, by base64-encoding the image inline.
- Downscale and convert images to a lightweight WebP derivative (the `alttexting` image style) before sending, reducing bandwidth and cost.
- Make the alt field optional on the image media source widget when auto-generation on save is enabled, so editors can save without typing alt text manually.
- Skip images that already have alt text, so manual descriptions are never overwritten.
- Restrict who can configure the integration via the "Administer Alttext.ing settings" permission.
- Only process the `image` media bundle's configured source field, leaving unrelated image fields untouched.
- Pair with the Entity Reference Media module to pass surrounding context and improve description quality.
- Provide multilingual sites with alt text generated per translation.
- Centralize alt-text generation behind a single reusable service (`alttexting.alttext_generator`).
- Log each generation attempt to the `alttexting` logger channel for auditing and troubleshooting.
- Let editors review and edit the AI-suggested alt text before saving, since AI descriptions can be imperfect.
- Reduce the manual effort of writing alt text for stock photography and user-uploaded images.
- Standardize alt-text quality across many editorial contributors.
