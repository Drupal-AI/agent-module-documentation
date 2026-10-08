<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Append File Info Filter" text-format filter

Plugin id **`append_file_info_filter`** in
`src/Plugin/Filter/AppendFileInfoFilter.php` (`extends FilterBase implements
ContainerFactoryPluginInterface`). Type `TYPE_TRANSFORM_REVERSIBLE`. One setting: `display`
(default `"both"`).

## Enable it

*Configuration → Content authoring → Text formats and editors* → edit a format (e.g. Full HTML)
→ tick **Append File Info Filter** → set *File information to append*. Or in config
(`filter.format.<id>.yml`):

```yaml
filters:
  append_file_info_filter:
    id: append_file_info_filter
    status: true
    weight: 20
    settings:
      display: both   # both | extension | filesize
```

Its `settingsForm()` renders a `radios` element with options `both` / `extension` / `filesize`.
Order it **after** filters that produce the final `<a>` markup you want to decorate.

## What `process($text, $langcode)` does

1. `Html::load($text)` parses the fragment; iterates every `<a>`.
2. `preg_match('`^' . preg_quote(base_path()) . '(.+)`', $href)` — only links under the site base
   path continue; external/absolute-off-site links are skipped.
3. `rawurldecode()` the tail, then `stripLangcode()` removes a leading language prefix (read from
   `language.negotiation` `url.prefixes`) so multilingual paths resolve.
4. `getFileFromPath($path)` resolves a `file` entity (see below); non-matches are skipped.
5. Adds cacheability: `$result->addCacheableDependency($file)`, and if the file exposes no cache
   tags, `addCacheTags(['file:' . $file->id()])`.
6. **Skips** the link if its `class` matches `no-file-info` (via `strstr`), or if it contains an
   `<img>` (`continue 2`).
7. Appends the extra text as a `\DOMText` node (so it is inserted as **text**, not markup), then
   wraps the whole `<a>` in a new `<span>` whose class is
   `file-with-file-info file file--mime-<icon> file--<icon>`
   (`IconMimeTypes::getIconClass($file->getMimeType())`).
8. `Html::serialize($dom)` → `$result->setProcessedText(...)`.

## `getFileFromPath()` — path resolution

Given the decoded, langcode-stripped path, it matches, in order:

| Pattern | Loads by |
|---|---|
| `^<PublicStream::basePath()>/(.+)$` | `loadByProperties(['uri' => 'public://' . $1])` |
| `^<PrivateStream::basePath()>/(.+)$` | `loadByProperties(['uri' => 'private://' . $1])` |
| `^file/(\d+)` | `loadMultiple([$fid])` |

All lookups go through `entity_type.manager` storage (`file`) — **no raw SQL**. The resolved file
is returned only if its stream wrapper (`stream_wrapper_manager->getViaUri(...)`) is a
`LocalStream`; otherwise `NULL` (remote files are never decorated).

Note: `media/{id}` links work only insofar as the media's file resolves to one of the paths above
(the help text advertises media/file/core links); the matcher itself keys on public/private base
paths and the `file/{fid}` route.

## Appended text — `FileInfoFormatter::getExtraLinkText()`

Shared with the theme override. Returns `''` when nothing to show, else `" (<parts>)"`:

- **extension** (`both`/`extension`): `strtoupper(array_pop(explode('.', basename(uri))))`,
  run through **`Html::escape()`**; `GZ`/`BZ2` are prefixed with the prior part to yield
  `TAR.GZ` / `TAR.BZ2`.
- **filesize** (`both`/`filesize`): `ByteSizeMarkup::create($file->getSize())` (core, localized,
  safe markup).

## Gotchas

- The `no-file-info` opt-out uses `strstr('no-file-info', $class)` (haystack/needle look
  transposed); treat the opt-out as best-effort and test it on your markup.
- The filter is reversible in type but stores no original text; it re-derives on each run.
- Only files whose managed URI matches the public/private base path or the `file/{fid}` route are
  found — a themed/aliased file URL that doesn't match won't be decorated (use the theme override
  for file fields instead).
