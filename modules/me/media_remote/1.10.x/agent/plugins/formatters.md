<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 20 provider formatters

All extend `MediaRemoteFormatterBase` (which implements `MediaRemoteFormatterInterface`), take
`field_types = {string}`, and are only offered when the media type's source is `media_remote`
(`MediaRemoteFormatterBase::isApplicable()`). Every one inherits a `formatter_class` setting whose
default is its own FQCN — do not change it.

Classes live in `Drupal\media_remote\Plugin\Field\FieldFormatter\`.

| Formatter id | Label | Extra settings (beyond `formatter_class`) | URL regex (anchored `^`) |
|---|---|---|---|
| `media_remote_apple_podcasts` | Remote Media - Apple Podcasts | — | `https://podcasts.apple.com/us/podcast/([a-z-]+.*)/(.+)` |
| `media_remote_arcgis` | Remote Media - ArcGIS | `width: '100%'`, `height: '400px'` | `https://([\w.+]*)arcgis.com/apps/(dashboards\|mapviewer\|Embed\|View\|webappviewer\|instant)/…` |
| `media_remote_box` | Remote Media - Box | `width: 890`, `height: 530` | `https://app.box.com/s/(.*)` |
| `media_remote_brightcove` | Remote Media - Brightcove | — | `https://players.brightcove.net/(\d+)/[a-zA-Z0-9-]+_default/index.html?videoId=(\d+)` |
| `media_remote_buzzsprout` | Remote Media - Buzzsprout | — | `https://www.buzzsprout.com/(\d+)(?:/episodes)?/(\d+)(-*.*)` |
| `media_remote_dacast` | Remote Media - Dacast | `width: 960`, `height: 600` | `https://iframe.dacast.com/vod/(-*.*)` |
| `media_remote_deezer` | Remote Media - Deezer | — | `https://www.deezer.com/us/episode/(\d+)` |
| `media_remote_documentcloud` | Remote Media - DocumentCloud | — | `https://www.documentcloud.org/documents/(\d+)(-*.*)` |
| `media_remote_dropbox` | Remote Media - Dropbox | `app_key: ''`, `width: 960`, `height: 600` | `https://www.dropbox.com/s/[^/]+/[^/]+\?dl=0$` |
| `media_remote_google` | Remote Media - Google | `width: 960`, `height: 600` | `https://docs.google.com/(document\|spreadsheets\|presentation)/d/e/` |
| `media_remote_google_map` | Remote Media - Google Map | `width: 960`, `height: 600` | `https://www.google.com/maps/d(/u/\d)?/(edit\|viewer\|embed)\?mid=(\w+)` |
| `media_remote_libsyn` | Remote Media - Libsyn | — | `https://directory.libsyn.com/episode/index/id/(\d+)` |
| `media_remote_loom` | Remote Media - Loom | `width: 960`, `height: 600` | `https://www.loom.com/share/(.*)` |
| `media_remote_matterport` | Remote Media - Matterport Model | `width: '640px'`, `height: '480px'` | `https://my.matterport.com/show/(.*)` |
| `media_remote_msforms` | Remote Media - Microsoft Forms | `width: '640px'`, `height: '480px'` | `https://forms.office.com/((r/[\w-]+)\|(Pages/ResponsePage.aspx\?id=[\w-]+))$` |
| `media_remote_npr` | Remote Media - NPR | `width: 960`, `height: 600` | `https://livesessions.npr.org/embed/v2/videos/(-*.*)` |
| `media_remote_panopto` | Remote Media - Panopto | — | `https://(.*)/Panopto/Pages/(Viewer\|Embed).aspx?id=(.+)` |
| `media_remote_planet_estream` | Remote Media - Planet eStream | `width: 960`, `height: 600` | `https://(.*).planetestream.com/Embed.aspx\?id=(.*)` |
| `media_remote_quickbase` | Remote Media - Quickbase | — | `https://([A-Za-z]+).quickbase.com/db/(.*)` |
| `media_remote_stitcher` | Remote Media - Stitcher | — | `https://www.stitcher.com/embed/(\d+)/(\d+)` |

Regexes above are shown unescaped for readability; the real ones are `/`-enclosed with escaped
slashes, e.g. Loom is `'/^https:\/\/www\.loom\.com\/share\/(.*)/'`. Read the exact pattern with
`MediaRemoteLoomFormatter::getUrlRegexPattern()`.

## Example URLs (from `getValidUrlExampleStrings()`)

These are exactly what an editor is shown when validation fails:

```
loom            https://www.loom.com/share/91ad056cbe274b3f82add5e48beba123
box             https://app.box.com/s/p7jrdm6ns7kug654fwhn1g1u5jd7zwt4
google          https://docs.google.com/document/d/e/[your-document-hash]/pub
                https://docs.google.com/spreadsheets/d/e/[your-document-hash]/pubhtml
                https://docs.google.com/presentation/d/e/[your-document-hash]/pub?start=false&loop=false&delayms=3000
google_map      https://www.google.com/maps/d/edit?mid=[your-map-hash]
dropbox         https://www.dropbox.com/s/u0bdwmkjmqld9l2/dbx-supporting-distributed-work.gif?dl=0
brightcove      https://players.brightcove.net/[account-id]/default_default/index.html?videoId=[video-id]
buzzsprout      https://www.buzzsprout.com/123/episodes/456-foo-bar
documentcloud   https://www.documentcloud.org/documents/21034688
deezer          https://www.deezer.com/us/episode/419142123
libsyn          https://directory.libsyn.com/episode/index/id/20026970
matterport      https://my.matterport.com/show/?m=Ez3YDocMaVx
msforms         https://forms.office.com/r/123456ABCD
panopto         https://[sub-domain].cloud.panopto.[top-domain]/Panopto/Pages/Viewer.aspx?id=[id]
quickbase       https://acme.quickbase.com/db/bc8fj3u7k?a=API_GenResultsTable&qid=11&jht=1
stitcher        https://www.stitcher.com/embed/123456/123456789
apple_podcasts  https://podcasts.apple.com/us/podcast/[episode-title]/[id]?i=[token]
```

## List them live

```bash
drush php:eval '$fm = \Drupal::service("plugin.manager.field.formatter");
foreach ($fm->getDefinitions() as $id => $d) {
  if (($d["provider"] ?? "") === "media_remote") { print $id . " => " . $d["label"] . "\n"; }
}'
```

## Config schema gap

`config/schema/media_remote.schema.yml` defines `field.formatter.settings.<id>` for 18 of the 20
formatters. **`media_remote_google_map` and `media_remote_matterport` have no schema entry**, even
though both expose `width`/`height`. Expect schema-validation warnings (e.g. in config inspection
or strict test runs) for media types using those two.

## Adding a provider

Subclass `MediaRemoteFormatterBase` in your own module and implement the interface:

```php
/**
 * @FieldFormatter(
 *   id = "mymodule_vimeo_pro",
 *   label = @Translation("Remote Media - Vimeo Pro"),
 *   field_types = {"string"}
 * )
 */
class MyFormatter extends MediaRemoteFormatterBase {
  public static function getUrlRegexPattern() { return '/^https:\/\/vimeo\.com\/(\d+)/'; }
  public static function getValidUrlExampleStrings(): array { return ['https://vimeo.com/123456']; }
  public function viewElements(FieldItemListInterface $items, $langcode) { /* return #theme elements */ }
}
```

`defaultSettings()` in the base class stamps `formatter_class => static::class`, so validation and
auto-naming pick your class up automatically. Add a `field.formatter.settings.mymodule_vimeo_pro`
schema entry with a `formatter_class` string (plus any extra settings) and a theme hook + template.
Override `deriveMediaDefaultNameFromUrl()` for a nicer auto-name; the base returns
`"Remote media for <url>"`.
