# Remote Audio — manual setup guide

**Remote Audio** (`media_remote_audio`) adds a "Remote audio" media source and a
ready-made media type to Drupal core's Media module, so editors can embed streaming
audio from **SoundCloud, Spotify, and iHeartRadio** simply by pasting a share URL.
It is the audio counterpart to core's "Remote video" (which handles YouTube and
Vimeo): the audio is played from the provider's own embed, while Drupal stores and
manages the metadata locally as a reusable Media entity.

The module is a thin, sensible extension of core Media's oEmbed support. Enabling it
installs a **`remote_audio`** media type with an "Audio URL" field, a form display
that uses core's "oEmbed URL" widget, and a view display that uses core's "oEmbed
content" formatter — everything you need to start adding audio right away, with no
setup form to fill in. Editors add audio at `/media/add/remote_audio` (or straight
from the Media Library, if it's enabled), the media name is auto-populated from the
provider's title, and provider thumbnails are fetched and stored. It even smooths
over a SoundCloud quirk (SoundCloud returns slightly non-standard oEmbed data) so
those embeds work reliably.

There is no settings form (`configure` is null), no permission, no Drush command, and
no plugin type of its own — it's all standard core Media behavior once the type is
installed. It depends on core **Media** (and works best with **Media Library** so the
type appears in the add menu), and ships no submodules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

- Add audio at **Content → Media → Add media → Remote audio**
  (`/media/add/remote_audio`).
- The media type itself appears under **Structure → Media types → Remote audio**
  (`/admin/structure/media`), where you can adjust its displays like any other media
  type.

## How to use it

1. Enable the module (ideally with **Media Library** on) — the `remote_audio` media
   type and its field/displays install automatically.
2. Go to **`/media/add/remote_audio`**, paste a URL from Spotify, SoundCloud, or
   iHeartRadio into the **Audio URL** field, and save. Drupal fetches the provider's
   embed and creates a reusable audio Media entity.
3. Reference that media from your content — add a media reference field, use it in a
   View, place it in Layout Builder, or insert it into a WYSIWYG via core's media
   embed button.

**What ships:** the `remote_audio` media type (source `oembed:audio`), a required
"Audio URL" string field (`field_media_oembed_audio`), form/view displays wired to
core's oEmbed widget and formatter, and a field map that sets the media name from the
provider's title.

**Allowed providers:** iHeartRadio, SoundCloud, and Spotify. A URL from any other
provider fails validation. oEmbed fetching needs outbound HTTP from your server, and
thumbnails are downloaded to `public://oembed_thumbnails`.

**Narrowing or extending providers:** to restrict a media type to fewer providers,
set its source configuration's provider list; to change the global provider list, a
developer can alter the `oembed:audio` source definition (see the sibling
[`agent/`](../agent/start.md) docs).
