<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Remote — agent index

Media integration for **non-oEmbed** remote content. One media source plugin (`media_remote`,
label "Remote Media URL", `allowed_field_types = {string}`) plus **20 provider field formatters**
that turn the stored URL into an embed. Depends on core `media` + `media_library`.
No configure route (`configure: null`), no permissions, no Drush, no services, no plugin types.

- **Create a media type, wire the source field, pick the provider formatter (with drush)** →
  [configure/media-type.md](configure/media-type.md)
- **All 20 formatter ids, their settings, URL regexes and example URLs** →
  [plugins/formatters.md](plugins/formatters.md)
- **The `media_remote` constraint, `formatter_class`, auto-naming and Media Library form** →
  [plugins/source-and-validation.md](plugins/source-and-validation.md)
- **Theme hooks and the Twig templates that emit the iframes** →
  [theming/templates.md](theming/templates.md)

Non-obvious facts an agent must know:

- The provider is chosen by the **formatter on the media type's `default` view display**, not by
  any setting on the media type. Every formatter's `defaultSettings()` writes its own FQCN into a
  `formatter_class` setting, and `MediaRemoteSource::getFormatterClass()` loads
  `media.<bundle>.default` to read it.
- If the source field on the `default` display has no Media Remote formatter, saving/validating a
  media item throws `LogicException: The Remote Media validator needs the _default_ media display
  to be configured…`. Configure the display **before** creating content.
- URL validation is per-provider: the `media_remote` constraint runs the chosen formatter class's
  `getUrlRegexPattern()`; failure messages list `getValidUrlExampleStrings()`.
- Auto-created source field is named `field_media_media_remote` (type `string`), shared as one
  field storage across every Media Remote media type.
- `config/schema/media_remote.schema.yml` is missing entries for `media_remote_google_map` and
  `media_remote_matterport`, although both formatters do have `width`/`height` settings.
