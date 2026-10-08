<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatter: "Link (favicon)" (`automatic_site_icon_picker_link`)

Class `AutomaticSiteIconPickerLinkFormatter` (`FormatterBase`) in
`src/Plugin/Field/FieldFormatter/AutomaticSiteIconPickerLinkFormatter.php`. Applies to core `link`
fields. Renders each link with the destination site's favicon.

## Enable
1. `drush en automatic_site_icon_picker` (or install via UI). No config to import.
2. Add/have a `link` field on any entity.
3. Manage display (`/admin/structure/types/manage/<bundle>/display` etc.) → set the link field's
   format to **Link (favicon)**.

## Formatter settings (`settingsForm()` / `defaultSettings()`)
- `social_media_link` — display mode select. Options: `icon_only` (default), `icon_and_link`
  (icon + URL text), `icon_and_title` (icon + link title). Passed to the template as `view_mode`.
- `social_media_size` — icon size select: `large`=64px, `medium`=32px (default), `small`=16px.
  Mapped to pixels via the `$sizes` array; unknown key falls back to 32.
- `social_media_target` — checkbox, `#return_value = '_blank'`. When set, the template emits
  `target="_blank" rel="noopener noreferrer"`.

There is **no config schema** shipped (no `config/schema/*`); settings are stored as third-party
formatter settings on the entity display.

## Render flow — `viewElements(FieldItemListInterface $items, $langcode)`
1. Ensure cache dir `public://social-media-icons/` exists via
   `fileSystem->prepareDirectory(CREATE_DIRECTORY | MODIFY_PERMISSIONS)`; on failure it logs and
   returns `[]` (renders nothing).
2. For each item:
   - If `$item->uri` starts with `internal:` or `entity:`, resolve with
     `Url::fromUri($uri, ['absolute' => TRUE])->toString()`; else use the raw URI. Unresolvable
     URIs are logged (warning) and skipped.
   - `$domain = parse_url($url, PHP_URL_HOST)`; empty host → warn + skip.
   - Cache filename: `str_replace('.', '-', $domain) . '-' . $size . 'px.png'` under the cache dir.
   - If that file does **not** already exist, call `apiResponse($domain, $size)`; on data, save with
     `fileSystem->saveData($data, $filepath, FileExists::Replace)`; on `null` or save error, log +
     skip that item.
   - Build render array `#theme => 'automatic_site_icon_picker'` with `#url`, `#icon_file`
     (the local path), `#elem['title']` (item title), `#view_mode`, `#target`.

## Remote favicon fetch — `apiResponse($domain, $size)`
- HTTP client from `http_client_factory->fromOptions([])` (default Guzzle options; standard TLS
  verification). GET `https://favicon.vemetric.com/{domain}?format=png&size={size}`.
- Returns the response body bytes, or `null` on any exception (logged as error). No API key/auth is
  used; the Vemetric host is fixed. The extracted host is only used as a path segment of that fixed
  URL, never fetched directly.

## Template — `templates/automatic-site-icon-picker.html.twig`
Renders `<a href="{{ url }}">` (adds `target="_blank" rel="noopener noreferrer"` when `target` set)
containing `<img src="{{ file_url(icon_file) }}" alt/title="{{ elem.title }}">`, plus a trailing
`<span>` showing the URL (`icon_and_link`) or the title (`icon_and_title`). Class hooks:
`.social-icon-link`, `.icon-and-url`, `.icon-and-title`.

## Injected services (`create()` / constructor)
`http_client_factory`, `file.repository` (unused in render path), `file_system`, `logger.factory`
(channel `automatic_site_icon_picker`), `messenger`.

## Operational notes
- First render of a given domain+size performs an outbound HTTPS request; later renders reuse the
  cached PNG (keyed by host + size only, not by full URL/path).
- Icons live in the public files directory; clearing `public://social-media-icons/` forces re-fetch.
- Requires internet egress to `favicon.vemetric.com`; on failure the item is silently omitted from
  output (errors go to the logger, not the page).
