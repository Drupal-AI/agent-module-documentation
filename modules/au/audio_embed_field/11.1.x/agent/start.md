<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Embed Field (audio_embed_field) — agent index

Field type for **third-party hosted audio**. A user pastes a URL into a text field; a **provider
plugin** matches it and renders an embedded player. The audio counterpart to `video_embed_field`,
sharing its architecture. Version **11.1.1**, core `^10.3 || ^11`, depends only on core `field`
and `image` (image is for thumbnails). Configure SoundCloud credentials at
`/admin/config/media/audio-embed-field` (`administer audio embed field` permission).

## Mechanism (verified against source)
- **Field type** `audio_embed_field` — stores one URL string (`varchar 256`, column `value`).
  Default widget `audio_embed_field_textfield`, default formatter `audio_embed_field_audio`.
  Field settings expose `allowed_providers` (checkboxes) to restrict which providers a field accepts.
- **Widget** `audio_embed_field_textfield` — a textfield. `validateFormElement` rejects any input
  that no enabled provider claims (calls `ProviderManager::filterApplicableDefinitions`).
- **ProviderManager** (`audio_embed_field.provider_manager`, extends `DefaultPluginManager`) —
  discovers `@AudioEmbedProvider` plugins in `Plugin/audio_embed_field/Provider`, alter hook
  `audio_embed_field_provider_info`. `loadProviderFromInput()` picks the first provider whose
  `isApplicable()` (i.e. `getIdFromInput()` returns non-empty) matches.
- **Providers shipped** (see `providers/soundcloud-and-customurl.md`):
  - **CustomUrl** (`custom_url`) — matches an `http(s)` URL containing `.mp3/.mp4/.m4a/.aac/.ogg/.oga/.wav`;
    renders an HTML5 `<audio><source src=URL>` element. No API calls, no thumbnail.
  - **SoundCloud** (`soundcloud`) — resolves the URL to a numeric track ID via
    `api.soundcloud.com/resolve` using an **OAuth 2.1 `client_credentials`** token
    (`SoundCloudOAuthService`, token cached in `state`, ID cached 30 days). Renders a
    `w.soundcloud.com/player` iframe; thumbnail comes from the track `artwork_url`.
- **Formatters** — `audio_embed_field_audio` (player; `width`/`height`/`responsive`/`autoplay`),
  `audio_embed_field_thumbnail` (downloads artwork to `public://audio_thumbnails/<id>.jpg`, renders
  via an image style, optional link to content/provider), `audio_embed_field_colorbox`
  (thumbnail → modal player; `isApplicable` only when contrib `colorbox` is installed).
- **Theme / render** — `audio_embed_iframe` and `audio_embed_html5` render elements + Twig
  templates (both auto-escaped). Preprocess via `hook_preprocess_audio_embed_iframe[__PROVIDER]`.
- **Permissions** — `administer audio embed field` (settings form); `never autoplay audio`
  (forces `autoplay=false` for a role regardless of the formatter setting).

## Submodule: audio_embed_media_core
Adds a **`MediaSource`** plugin (`id = audio_embed_field`) so the same URLs become core **Media**
entities. Provides `getMetadata()` (id / source / thumbnail_uri via the provider), a Media Library
add form (`AudioEmbedFieldMediaLibraryForm`, URL input), and a `hook_install` that copies an
`audio.png` icon. Depends on core `media`. Disabled by default; enable when using the media suite.

## Notes for agents
- The autoplay toggle is per-formatter but **overridable per role** by `never autoplay audio`; the
  formatter adds a `user.permissions` cache context.
- SoundCloud requires **both** a Client ID and Client Secret (OAuth 2.1); without them the resolve
  call returns nothing and the URL fails validation with a message pointing at the settings page.
- A third-party embed is a **consent** concern (SoundCloud sets cookies / reports plays) and audio
  should carry a **transcript** (WCAG); neither is provided by the module.
