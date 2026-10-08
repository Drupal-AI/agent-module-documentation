# Audio Video Viewer — manual setup guide

**Audio Video Viewer** (`audio_video_viewer`) is a file-field formatter that plays
audio and video files with the browser's native HTML5 player. It uses plain
`<audio>` and `<video>` tags, so playback relies on the browser's own codec
support rather than on any bundled JavaScript player — nothing is loaded from a
third party, no secrets are involved, and it makes no outbound calls. It comes
from the San Diego Supercomputer Center (SDSC) and is handy for presenting
research media directly on a node page.

Beyond simple playback, the formatter offers a few display options: show the
file's **name** as a link to the file, show the file **size**, set a **maximum
file-size threshold** in bytes (files above it are not rendered; `0` means no
limit), and optionally **render nothing when a file's format is not recognised**
so it can be paired with the Fallback Formatter module.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The main configuration is **per display**:

1. On the entity's **Manage display** tab, find the file field holding your audio
   or video.
2. Choose **Audio Video Viewer** as its format.
3. Open the formatter settings (the gear icon) to turn on the file name link, the
   file size, the maximum-size threshold, and the "hide unrecognised formats"
   option.
4. Save.

There is also a small **global settings form** for defaults, registered under
**Configuration → User interface** at
`/admin/config/user-interface/audio_video_viewer` (requires the **Administer site
configuration** permission). Most sites can leave it at its defaults and simply
configure the formatter per field.
