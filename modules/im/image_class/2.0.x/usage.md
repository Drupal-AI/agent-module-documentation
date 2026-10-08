Image Class adds a "Class" text field to Drupal's Image, Responsive Image, Media thumbnail and Media responsive thumbnail field formatters, so you can attach one or more CSS classes directly to the rendered `<img>` element from Manage display.

---

The module is a small formatter enhancement with no field type, widget, settings form or configure route of its own. It hooks into existing image formatters via `hook_field_formatter_third_party_settings_form()`, adding a single **Class** textfield to the formatter settings of the `image`, `responsive_image`, `media_thumbnail` and `media_responsive_thumbnail` formatters on any entity's *Manage display* page. The space-separated value is stored as a third-party setting (`third_party_settings.image_class.class`) on that field's component in the `entity_view_display` config entity, and echoed into the formatter summary via `hook_field_formatter_settings_summary_alter()`. At render time `hook_preprocess_field()` reads the stored class, splits it on spaces, merges it with any classes already present, and writes them to each item's `#item_attributes['class']`, so the classes land on the `<img>` tag. This lets you add utility/layout classes (e.g. `img-fluid`, `rounded`, `lazyload`) to images without a custom template or preprocess hook. Stored image values and the field itself are untouched — the effect is purely on display markup.

---

- Add a Bootstrap `img-fluid` class to images rendered by the Image formatter.
- Attach a `rounded` or `img-thumbnail` class to an article's teaser image.
- Add a `lazyload` class so a lazy-loading JS library picks up the `<img>`.
- Apply a utility class to a Responsive Image formatter's output.
- Add a class to a Media thumbnail (`media_thumbnail`) in a media library view mode.
- Add a class to a Media responsive thumbnail (`media_responsive_thumbnail`).
- Give an image multiple classes at once (space-separated, e.g. `rounded shadow border`).
- Style images per view mode by setting different classes on teaser vs full display.
- Add a hook/anchor class used by a lightbox or gallery script.
- Apply an aspect-ratio or object-fit utility class to images from a theme's CSS framework.
- Avoid writing a custom `hook_preprocess_field()` just to add a class to images.
- Keep image styling in configuration (exported `entity_view_display`) rather than templates.
- Add a print-specific or accessibility helper class to certain image fields.
- Differentiate images from different fields with distinct classes for CSS targeting.
- Add a `mx-auto d-block` centering class to a logo image field.
- Tag decorative images with a class your CSS uses to hide them on mobile.
- Add a data-driven grid/column class to media thumbnails in a grid view.
- Preserve existing item classes while appending new ones (the module merges, not replaces).
- Standardise image classes across content types by setting the same value on each display.
- Configure via config (`third_party_settings.image_class.class`) for deployment across environments.
- Add a hover-effect trigger class to product images.
- Add a theme component class (e.g. `card-img-top`) to images inside card layouts.
- Roll out a consistent image CSS hook to an editorial team through one display setting.
