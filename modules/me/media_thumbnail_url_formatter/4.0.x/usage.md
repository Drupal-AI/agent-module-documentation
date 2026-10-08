Media thumbnail URL formatter adds a single field formatter (`media_thumbnail_url`, label "Thumbnail URL") that outputs the plain URL string of a referenced media entity's thumbnail image — optionally through an image style — instead of rendering an `<img>` tag.

---

The module ships one class, `MediaThumbnailURLFormatter`, which extends core's `MediaThumbnailFormatter` and is registered for `entity_reference` fields (i.e. media reference fields). You select it on an entity's **Manage display** tab. It reuses the parent formatter's **Image style** setting, drops the parent's *Link image to* (`image_link`) option, and adds one boolean setting, **Absolute URL** (`absolute`). For each referenced media item it loads the media's `thumbnail` file URI; if an image style is chosen it emits `ImageStyle::buildUrl()`, otherwise it emits the file URL. When *Absolute URL* is on the URL is left absolute, otherwise it is passed through `FileUrlGenerator::transformRelative()` to a root-relative path. The output is a bare `#markup` string per delta (no image tag, no link), with the media entity and the image style added as cacheable dependencies. There is no global settings page (`configure` is null), no permissions, no Drush, and no services — just the formatter plugin plus a config schema (`field.formatter.settings.media_thumbnail_url`) for the `absolute` setting.

---

- Output the thumbnail URL of a referenced media entity as plain text for use in a template or Twig variable.
- Expose a media thumbnail URL to a decoupled/JSON front end via a view mode + REST/JSON:API field.
- Feed a media thumbnail URL into a meta tag (e.g. Open Graph / Twitter card image) through a rendered field.
- Produce an image-style-derived thumbnail URL (e.g. a `medium` or `thumbnail` style) rather than the original.
- Render an absolute thumbnail URL for emails, feeds, or sitemaps where root-relative paths won't resolve.
- Render a root-relative thumbnail URL (the default) for same-site markup.
- Use a media reference field's thumbnail as a background-image URL in a custom template.
- Populate a CSS custom property or inline style with a media thumbnail URL.
- Supply a preview image URL to a JavaScript widget or slider that expects a string, not markup.
- Build a "download the poster" or "copy image URL" link from a media reference.
- Provide a thumbnail URL to a third-party embed or oEmbed consumer.
- Use with Views (field formatter on a media reference) to output a column of thumbnail URLs.
- Expose remote video / document media thumbnails as URLs for card layouts.
- Generate social share image URLs sized by an image style.
- Give an AI/automation pipeline a stable thumbnail URL string for a media item.
- Reference the same thumbnail URL across multiple display modes without duplicating an image field.
- Replace a custom preprocess hook that manually derived a thumbnail URL with a configurable formatter.
- Output multiple thumbnail URLs for a multi-value media reference field.
