<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works: route override & controller flow

## Route override

`Drupal\media_alias_display\Routing\RouteSubscriber` (an `EventSubscriber`) rewrites two core routes:

- `entity.media.canonical` → `DisplayController::view`
- `entity.media.revision` → `DisplayController::viewRevision`

Both keep the core title callback. `DisplayController` extends `EntityRevisionViewController`, so
when it decides *not* to stream a file it falls back to `parent::__invoke()` — the normal media
render array.

## `DisplayController::check()` decision flow

For each media view request, in order — any "render normally" branch returns the standard media
page (with extra cache metadata):

1. **Kill switch on** (`kill_switch === true`) → render normally.
2. **Bundle not allowed** — if `media_bundles` is non-empty and this bundle isn't in it → render normally.
3. **`?edit-media`** present + user has edit access (`edit own/any <bundle> media` or
   `administer media`) → **redirect** to the media edit form.
4. **Field override** — if `media_alias_display_field_override` is installed and the media's
   `field_override_mad_module` boolean is set → render normally.
5. **Not a File source** — if `$media->getSource()` isn't a `File` media source → log + render normally.
6. **No file / missing on disk / invalid scheme** → log + render normally.
7. Otherwise → **stream the file**.

## Streaming the file

Returns a `CacheableBinaryFileResponse($uri, 200, [], $public)` where `$public` is
`$scheme !== 'private'` (private-scheme files get `Cache-Control: private`). It:

- adds the media, file and config as cacheable dependencies;
- sets `Content-Disposition: attachment` (with the real filename) when `?dl`/`?download` is present;
- adds cache contexts `media_alias_display_kill_switch_toggle`, `url.query_args:edit-media`,
  `user.permissions`, `url.query_args:dl`, `url.query_args:download`;
- sets `Content-Type` from the file's MIME type (fallback `application/octet-stream`).

`CacheableBinaryFileResponse` extends Symfony's `BinaryFileResponse` and implements
`CacheableResponseInterface` (it drops the un-serializable file handle on serialize and re-sets it
on wake-up), so file responses can be render-cached.

## Cache context

`media_alias_display_kill_switch_toggle` (`KillSwitchToggleCacheContext`) returns `active`/`inactive`
based on the kill switch, tagged with `config:media_alias_display.settings`, so toggling the switch
invalidates cached file responses.
