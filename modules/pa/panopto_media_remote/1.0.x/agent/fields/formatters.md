# The `panopto` field formatter

The module's only real surface. One field formatter renders a stored Panopto URL as an embedded
`<iframe>`. Display-only — it performs **no server-side request**; the visitor's browser loads the iframe.

| Formatter id | For field type | Class | Extends |
|---|---|---|---|
| `panopto` | `string` | `PanoptoFormatter` | `media_remote\…\MediaRemoteFormatterBase` |

Declared with a PHP attribute (`src/Plugin/Field/FieldFormatter/PanoptoFormatter.php:15`):

```php
#[FieldFormatter(
  id: "panopto",
  label: new TranslatableMarkup("Remote Media - Panopto"),
  field_types: ["string"]
)]
```

Because it extends `MediaRemoteFormatterBase`, `isApplicable()` only offers it on a `string` field of a
media type whose source is `media_remote`'s **Remote Media URL** source (see
[plugins/media-source.md](../plugins/media-source.md)).

## Settings

| Setting | Default | Meaning |
|---|---|---|
| `width` | `640px` | Iframe width — px or `%` (e.g. `640px`, `100%`). Textfield, maxlength 10. |
| `height` | `480px` | Iframe height — px or `%`. Textfield, maxlength 10. |
| `formatter_class` | `PanoptoFormatter` FQN | Inherited from the base; `media_remote` reads this to know which regex to validate against. Do not hand-edit. |

`defaultSettings()` (`PanoptoFormatter.php:88`) returns `width`/`height` merged onto the base defaults;
`settingsForm()` (`:98`) adds the two textfields; `settingsSummary()` (`:122`) prints
`Iframe size: %width x %height`. There is **no config schema file** in this module, so these settings have no
`config/schema` entry of their own.

Set it from code:

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('media', 'panopto', 'default')   // the media bundle you created
  ->setComponent('field_media_remote', [             // the Remote Media URL source field
    'type' => 'panopto',
    'settings' => ['width' => '100%', 'height' => '480px'],
  ])->save();
```

## URL handling and rendering

- `getUrlRegexPattern()` (`:25`) — the accept pattern, anchored at the start:
  `/^https:\/\/(?:[a-zA-Z0-9-]+\.)+[a-zA-Z0-9-]+\.panopto\.[a-zA-Z]+\/Panopto\/Pages\/(?:Embed|Viewer)(?:\.aspx)?\?id=([a-zA-Z0-9-]+)/`.
  Requires the `https://` scheme, a `…​.panopto.<tld>` host, the `/Panopto/Pages/Embed|Viewer` path and an
  `id=` query. `media_remote` runs this against the stored URL at entity-save time (it does **not** re-run in
  `viewElements()`).
- `getValidUrlExampleStrings()` (`:32`) — `https://hosted.cloud.panopto.eu/Panopto/Pages/Embed.aspx?id=[id]`
  and the `Viewer.aspx` equivalent; shown in the validation error message.
- `deriveMediaDefaultNameFromUrl($url)` (`:42`) — if the URL matches, the auto-generated media name is
  `t('Panopto from @url', ['@url' => …])`; otherwise falls back to the base
  (`Remote media for @url`).
- `getEmbedUrl(string $url)` (`:81`) — **returns the URL unchanged** (identity). The Embed and Viewer URLs are
  already embeddable, so no rewriting is done.
- `viewElements()` (`:55`) — for each non-empty item builds:

```php
$elements[$delta] = [
  '#theme'  => 'panopto',
  '#title'  => $item->getEntity()->label() ?? $this->t('Panopto embed'),
  '#url'    => self::getEmbedUrl($item->value),
  '#width'  => Html::escape($this->getSetting('width')  ?? '640px'),
  '#height' => Html::escape($this->getSetting('height') ?? '480px'),
];
```

## Theme hook and template

`hook_theme()` (`panopto_media_remote.module`) registers the **`panopto`** theme hook with variables
`url`, `width`, `height`, `title`. `templates/panopto.html.twig` renders:

```twig
<iframe
  src="{{ url }}"
  title="{{ title }}"
  width="{{ width }}"
  height="{{ height }}"
  allow="fullscreen">
</iframe>
```

All four variables are printed through Twig's default HTML auto-escaping (attribute context). To override the
markup, provide a `panopto.html.twig` in your theme, or a `hook_theme_suggestions_panopto_alter()` /
`hook_preprocess_panopto()` in a module.
