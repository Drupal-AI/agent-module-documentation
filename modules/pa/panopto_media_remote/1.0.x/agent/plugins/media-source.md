# Media source integration (media_remote) & install pipeline

**This module defines no media source.** The source is `media_remote`'s **`media_remote`** source plugin
(label "Remote Media URL", `Drupal\media_remote\Plugin\media\Source\MediaRemoteSource`, from the required
`drupal/media_remote` dependency). `panopto_media_remote` only contributes the **`panopto`** field formatter
(see [../fields/formatters.md](../fields/formatters.md)) that plugs into that source's display. This page
records how the pieces fit so an agent can set a Panopto media type up correctly.

## How the parts connect

1. A **media type** uses the `media_remote` source. That source stores the remote URL in a `string` source
   field (`allowed_field_types = {"string"}`).
2. `MediaRemoteFormatterBase::isApplicable()` only lets the `panopto` formatter be chosen when the media
   type's source is an instance of `MediaRemoteSource` — so the formatter only appears for Remote-Media-URL
   media types.
3. On the media type's **default** view display, the source field's formatter is set to **`panopto`**. The
   base's `defaultSettings()` records `formatter_class` = the formatter's FQN into the display config.
4. `MediaRemoteSource::getFormatterClass($media)` (in the dependency) reads that `formatter_class` back from
   the **`media.<bundle>.default`** display and uses it to pick the validation regex.
5. `MediaRemoteConstraintValidator` (constraint id `media_remote`, applied to the source field via
   `MediaRemoteSource::getSourceFieldConstraints()`) validates the stored URL against
   `PanoptoFormatter::getUrlRegexPattern()` **on entity save**. A URL that is empty or does not match is a
   validation violation.
6. `MediaRemoteSource::getMetadata()` asks the formatter for the default media name via
   `deriveMediaDefaultNameFromUrl()` → `t('Panopto from @url', …)`.

Consequence for agents: the validation regex is taken from **whatever formatter the *default* display uses**.
Keep the `panopto` formatter on the `default` display of the media type (you may use other formatters on other
displays, but the `default` one drives URL validation and name derivation).

## Set it up (README pipeline)

Source: `README.txt`. Steps (UI):

1. Enable the module: `drush en panopto_media_remote -y` (pulls in `media_remote`).
2. **Structure → Media types → Add media type.** Give it a name (e.g. `Panopto`) and choose
   **"Remote Media URL"** as the media source. Save — this creates the `string` source field.
3. On the new media type's **Manage display** (the *default* view display), set the source field's format to
   **"Remote Media - Panopto"** (the `panopto` formatter). Optionally open the formatter settings gear to set
   iframe `width` / `height`.
4. Add a media (entity)-reference field to any content type and point it at this media type, so editors can
   pick or create Panopto media by URL.

Equivalent code to place the formatter on the default display:

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('media', 'panopto', 'default')
  ->setComponent($source_field_name, ['type' => 'panopto', 'settings' => ['width' => '640px', 'height' => '480px']])
  ->save();
```

## Relationship to media_remote's own Panopto formatter

`media_remote` ships its **own** `media_remote_panopto` formatter (also labelled "Remote Media - Panopto"),
which parses the URL into `domain`/`type`/`id` and renders `media_remote_panopto` theme. This module's
`panopto` formatter is a **separate** plugin id with a **more strictly start-anchored** regex (it pins the
host to `…​.panopto.<tld>` and the scheme to `https`) and renders a simpler `panopto` iframe template. They
are independent; pick one formatter per display. Nothing here overrides or alters the media_remote plugin.
