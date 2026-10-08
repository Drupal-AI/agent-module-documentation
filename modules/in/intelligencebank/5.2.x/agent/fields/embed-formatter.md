# Field formatter, render element, theme & libraries

## `ib_dam_embed` field formatter

`Drupal\ib_dam\Plugin\Field\FieldFormatter\IbDamEmbedFormatter` — a formatter for core **`link`**
fields, extending core `LinkFormatter`. It renders an IntelligenceBank *embed* (public CDN) asset
inline instead of a plain link.

- Plugin id `ib_dam_embed`, `field_types = {"link"}`.
- Settings: all of `LinkFormatter`'s plus **`no_link`** (bool — "Do not wrap embed content into a link").
  Schema: `field.formatter.settings.ib_dam_embed` (extends `field.formatter.settings.link`), in
  `ib_dam_media`'s schema file.
- `viewElements()` reads the IB metadata stashed on each link item at
  `options.attributes.ib_dam` (`asset_type`, `filemimetype`, `extra` display settings), rebuilds an
  `EmbedAsset` via `Asset::createFromValues()`, and formats it through `AssetFormatterManager::create()`.
  When the stored metadata is a string it is `unserialize()`d with **`['allowed_classes' => FALSE]`**
  (no PHP object injection). If metadata is missing it renders a "re-embed this media" notice.

### Embed formatters (`src/AssetFormatter/`)

`AssetFormatterManager::create($asset, $display_settings)` picks by asset type:

| Type | Formatter | Output |
|---|---|---|
| image | `EmbedImageAssetFormatter` | `#theme => image` with `#uri` = remote URL; `alt`/`title`/`width`/`height` run through `Xss::filter()`. |
| video | `EmbedVideoAssetFormatter` | `#theme => ib_dam_embed_playable_resource` as `<iframe>` (streaming) or `<video>` (direct link, `/streaming/`→`/mp4/`). |
| audio | `EmbedAudioAssetFormatter` | same theme hook, `<audio>`/iframe. |
| other | `EmbedLinkAssetFormatter` | `#type => link` via `Url::fromUri()`, `rel=nofollow`, `download`. |
| local file | `LocalAssetFormatter` | renders the saved local `File`. |

`AssetFormatterManager::matchFieldTypeByAssetType()` also maps an asset type to a core field type +
core formatter (`image`, `file_video`, `file_audio`, `file_default`, or `ib_dam_embed` for embeds),
filtered to formatters actually available on the site.

## `ib_dam_app` render element

`Drupal\ib_dam\Element\IbIframeApp` (`#[FormElement('ib_dam_app')]`) — embeds the IntelligenceBank
browser as an `<iframe>` plus a hidden `response_items` input that receives the selected asset(s) as
JSON (decoded in `valueCallback`). `preRenderElement()` publishes `drupalSettings.ib_dam.browser`
(app URL/host, `allowEmbed`, `debug`, `fileExtensions`, `messages`, `submitSelector`). Element
properties: `#file_extensions`, `#allow_embed`, `#debug_response`, `#submit_selector`, `#messages`.
The app base URL is `https://ucprod.intelligencebank.com/app/` (or `.../ucstaging...` in staging/test
mode) with query params `app`, `enable_custom_url`, `url`, `enable_browser_login` (see configure/settings.md).
Attaches library `ib_dam/browser`.

## Theme

`ib_dam_theme()` registers **`ib_dam_embed_playable_resource`** (template
`templates/ib-dam-embed-playable-resource.html.twig`), variables `resource_type`, `url`, `title`,
`mimetype`, `attributes`. Renders `<video>`/`<audio>` (with `<source>`) or an `<iframe>` wrapped for
the JS resizer.

## Libraries (`ib_dam.libraries.yml`)

- `ib_dam/browser` — iframe browser JS/CSS (depends on jQuery, drupal, core/once, pnotify).
- `ib_dam/ckeditor` — bridges the browser dialog's save callback into CKEditor 4/5.
- `ib_dam/resizer.iframe` — auto-resizes the embedded iframe.
- `ib_dam/link_type_checker`, `ib_dam/common`, `ib_dam/libraries.pnotify` (external CDN).
