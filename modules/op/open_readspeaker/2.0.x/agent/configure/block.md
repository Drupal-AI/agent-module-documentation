# The "Listen" webReader block

Block plugin `open_readspeaker_webreader` (`OpenReadspeakerWebreader`, admin label *Open ReadSpeaker:
Webreader*). Place it via **Structure » Block Layout**; use normal block visibility to scope it to
content types/pages. It renders the ReadSpeaker "Listen" button and boots the ReadSpeaker script on
pages where it appears.

## Block settings (`blockForm` / `defaultConfiguration`)

| Setting | Default | Meaning |
|---|---|---|
| `button_url` | `//app-[open-readspeaker:cdn].readspeaker.com/cgi-bin/rsent` | ReadSpeaker request endpoint; token-replaced (`replacePlain`). Required. |
| `button_text` | `Listen` | Visible button label. Required. |
| `button_title` | `Listen to this page using ReadSpeaker` | Button `title` attribute. |
| `reading_area` | `block-olivero-content` | HTML **id** of the region ReadSpeaker reads. Required. |
| `reading_area_class` | `''` | Comma-separated CSS classes to read (`class1,class2`). |

Stored as block config (schema `block.settings.open_readspeaker_webreader`).

## What `build()` produces

- Loads `customerid`/`lang`/`voice` from `open_readspeaker.settings`. If `customerid` is empty it
  shows a warning linking to the settings form and renders nothing.
- Builds the button link: `Url::fromUri(token.replacePlain(button_url), ['query' => …])` with query
  params `customerid`, `lang`, `voice`, `readid` (reading_area), `readclass` (reading_area_class),
  and `url` = the current absolute page URL (empty params filtered out).
- Attaches libraries `open_readspeaker/basic` (the remote ReadSpeaker script) and
  `open_readspeaker/conf`, and sets `drupalSettings.open_readspeaker.rsConf` = the configured `rsConf`.
- Cache: context `url`, tag `config:open_readspeaker.settings`.
- Theme: `open_readspeaker_webreader` (`templates/open-readspeaker-webreader.html.twig`) — an
  `<a rel="nofollow" href="{{ url }}">` with the ReadSpeaker `rsbtn` markup. `button_title` is emitted
  through a Drupal `Attribute` object (escaped); `button_text` is printed as a plain variable.

## Trust note

`button_url` and the global `webreader_url` are admin-entered and cause a third-party script/request
on every page carrying the block. They are trusted-admin config (only users with `administer open
readspeaker` / block admin can set them), so keep them pointed at the legitimate ReadSpeaker hosts.
