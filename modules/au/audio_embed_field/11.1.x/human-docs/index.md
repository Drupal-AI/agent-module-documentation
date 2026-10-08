# Audio Embed Field — manual setup guide

**Audio Embed Field** (`audio_embed_field`) adds a field type for audio hosted
somewhere else. You paste a SoundCloud (or similar) URL into the field and the
module gives you a player, a thumbnail and — through its submodule — a media
source. It is the audio counterpart to the well-known `video_embed_field` module
and shares the same architecture: a provider plugin per platform, a field that
stores a URL, and formatters that render either a player or a thumbnail.

The optional **Audio Embed Media Core** submodule (`audio_embed_media_core`)
integrates those URLs with core's Media system, so the same audio becomes a media
entity you can reuse from the media library and inside a WYSIWYG editor. That
matters because audio is usually episodic — a podcast series, a lecture archive, a
set of interviews — and content that arrives in sequence needs to be
referenceable, listable and searchable rather than pasted into a body field.

Three things are worth attaching whenever you embed third-party audio. **A
third-party embed is a consent question**: the player sets cookies and reports the
play to its host, so it belongs behind your consent manager exactly as an
analytics tag does. **Audio needs a transcript** — a text alternative is a WCAG
requirement for pre-recorded audio, and it is also the only way the content
becomes searchable. And **provider plugins are fragile**: when a platform changes
its embed format or its oEmbed endpoint the plugin breaks until someone updates
it, so check the module's release date against the platform's current behaviour.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and decide whether to turn on the media submodule.

## How to use it

1. Add an **Audio Embed** field to a content type (or any fieldable entity) on its
   **Manage fields** tab.
2. On **Manage form display**, editors then paste the audio URL into that field.
3. On **Manage display**, choose the formatter — a player or a thumbnail — for the
   view mode you want.
4. If you enabled **Audio Embed Media Core**, the same URLs are available as media
   entities in the media library and the WYSIWYG.

A small admin settings form is registered under **Configuration**
(route `audio_embed_field.admin_settings_form`); you can reach it from the
module's *Configure* link on the **Extend** page. Most sites never need to change
it — the day-to-day work is done in the field and display configuration above.
