<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The media source, `formatter_class`, validation and auto-naming

## `media_remote` media source

`Drupal\media_remote\Plugin\media\Source\MediaRemoteSource extends MediaSourceBase
implements MediaSourceFieldConstraintsInterface`

```
id                          media_remote
label                       Remote Media URL
description                 A non-OEmbed media source plugin for remote content.
allowed_field_types         {"string"}
default_thumbnail_filename  generic.png
forms.media_library_add     Drupal\media_remote\Form\MediaRemoteMediaForm
```

- `getMetadataAttributes()` → a single attribute, `name` ("Name").
- `getSourceFieldConstraints()` → `['media_remote' => []]`, i.e. it attaches the `media_remote`
  constraint to the source field of every media type using this source.

## `getFormatterClass()` — the linchpin

```php
$display = EntityViewDisplay::load('media.' . $media->bundle() . '.default');
$formatter_config = $display->getComponents()[$source_field_name] ?? [];
if (empty($formatter_config['settings']['formatter_class'])) {
  throw new \LogicException('The Remote Media validator needs the _default_ media display to be
    configured, and for the source field to use any of the formatters provided by the Media Remote module.');
}
return $formatter_config['settings']['formatter_class'];
```

Consequences an agent must plan for:

- It **always** reads the `default` view display, regardless of the view mode being rendered.
- It reads the `formatter_class` **setting**, not the component `type`. The two agree because
  `MediaRemoteFormatterBase::defaultSettings()` returns `['formatter_class' => static::class]`,
  but a hand-edited config can desynchronise them — and validation follows `formatter_class`.
- No Media Remote formatter on that display ⇒ `LogicException` on validate/save, not a friendly
  form error. Configure the display first.

## The `media_remote` constraint

`MediaRemoteConstraint` (id `media_remote`, type `{"string"}`) with two messages:

| Property | Default message |
|---|---|
| `emptyUrlMessage` | `The URL cannot be empty.` |
| `invalidUrlMessage` | `The given URL is not valid. Valid values are in the format: @example_urls` |

`MediaRemoteConstraintValidator::validate()`:

1. Throws `LogicException` if the media's source is not a `MediaRemoteSource`.
2. Reads the source field value and `trim($url, "/")` — note it strips **slashes**, so a trailing
   `/` is tolerated.
3. Empty ⇒ `emptyUrlMessage`.
4. Otherwise `preg_match($formatter_class::getUrlRegexPattern(), $url)`; on failure adds
   `invalidUrlMessage` with `@example_urls` built by `media_remote_oxford_join($examples, 'or')`
   — an Oxford-comma join, so three examples render as `a, b, or c`.

### Checking validation without saving

```bash
drush php:eval '$m = \Drupal\media\Entity\Media::create([
  "bundle" => "mr_loom", "name" => "probe",
  "field_media_media_remote" => "https://example.com/nope",
]);
foreach ($m->validate() as $v) { print $v->getMessage() . "\n"; }'
```

A valid URL yields zero violations. Always set `name`, otherwise you also get an unrelated
"This value should not be null." violation for the media label.

## Auto-naming

`MediaRemoteSource::getMetadata($media, 'name'|'default_name')` delegates to
`$formatter_class::deriveMediaDefaultNameFromUrl($url)`. The base implementation returns
`"Remote media for <url>"`; most providers override it, e.g.

- Apple Podcasts / Buzzsprout / DocumentCloud / Panopto: humanise the URL slug
  (`str_replace('-', ' ')` + `ucfirst`) → "My episode title".
- Loom / Box / Dropbox / ArcGIS / Matterport / NPR / Dacast / Planet eStream / Google:
  `"<Provider> … from <url>"`.
- Google Map returns the raw URL.

If the source field is empty the source falls back to `MediaSourceBase::getMetadata()`.

## Media Library integration

`MediaRemoteMediaForm extends media_library\Form\AddFormBase` (form id
`<base>_media_remote`) adds a single required `#type => url` **URL** field with an **Add** button
in the Media Library modal. `validateUrl()` builds a throwaway media entity from the pasted value
and runs `$media->validate()`, surfacing each violation on the `url` element — so editors get the
provider's example URLs inline. This is wired through the source annotation's
`forms = { "media_library_add" = … }`, which is why `media_library` is a hard dependency.

## Other module-level glue

- `media_remote_form_media_type_add_form_alter()` + `_media_remote_media_type_form_submit()`:
  after adding a media type with this source, warn and redirect to
  `entity.entity_view_display.media.default` so the formatter gets chosen.
- `media_remote_oxford_join(array $items, $conjunction = 'and')`: public helper used for the error
  message; 1 item → itself, 2 → `a and b`, 3+ → `a, b, and c`.
