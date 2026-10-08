# Migrate Youtube — manual setup guide

**Migrate Youtube** (`migrate_youtube`) provides Migrate source plugins that
import YouTube videos and playlists into Drupal. Point a migration at a YouTube
playlist id and the module pulls each video's data from the YouTube Data API as
migration rows, which you can map onto any entity type — most often Media items or
content nodes representing your channel's videos.

It builds on [Migrate Plus](https://www.drupal.org/project/migrate_plus) and
supplies two source plugins: one for playlist items (the videos in a playlist) and
one for playlist migration. Every YouTube account has a main "uploads" playlist
containing all its videos, so you can use that id to import an entire channel. The
plugin is written to be economical with API calls; if you also need each video's
duration, you opt in with a `contentDetails: true` flag, since that requires an
extra call.

Because it talks to the YouTube Data API, you need a Google API key. The key is a
secret and should never be committed to your codebase — store it in an environment
variable and reference it from `settings.php` (see the installation guide). There
is nothing to configure in the admin UI; you drive imports from migration YAML and
Drush. It depends on Drupal core's **Migrate** module and on **Migrate Plus**, and
[Migrate Tools](https://www.drupal.org/project/migrate_tools) is a recommended
companion for running and managing the migrations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and store your YouTube API key securely.

There is **no configuration page** in the admin UI. The one setting the module
needs — your API key — lives in `settings.php` (described in
[Installation](installation/index.md)), and each import is configured in migration
YAML, described below.

## Where it lives in the admin menu

Migrate Youtube adds no admin page or block. Its whole surface is the two Migrate
source plugins, which you reference from migration definitions and run with Drush.

## How to use it

Use the `migrate_youtube_api_playlist_items` source plugin to import the videos in
a playlist:

```yaml
source:
  plugin: migrate_youtube_api_playlist_items
  playlist_id: youtube-account-playlist-id
```

To also import each video's duration, opt in with `contentDetails` (this makes an
extra API call per video) and map the resulting `duration` field on your
destination:

```yaml
source:
  plugin: migrate_youtube_api_playlist_items
  playlist_id: whatever-playlist-id-here
  contentDetails: true
process:
  # ...
  field_duration: duration
```

Playlist migration is also available. Run the migrations with
`drush migrate:import` (Migrate Tools is handy here), and see the module's own
`migration_examples/youtube_video_to_media.yml` and its `README.md` for the full
list of source fields and maintenance notes.
