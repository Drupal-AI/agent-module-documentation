# Configuration

MediaElement.js has a **global settings form** that controls where the player library loads
from and the default player dimensions. The per‑field player options (preload, download link,
poster image) are set separately on each field's *Manage display* tab — see
[How to use it](../index.md#how-to-use-it).

## Open the settings form

1. Log in as a user with the **Administer mediaelement** permission (grant it at *People →
   Permissions* if needed).
2. Go to **Configuration → Media → MediaElement.js configuration**, or navigate directly to
   `/admin/config/media/mediaelement/config`.

## Library source

This is the setting you must get right for players to work.

- **Local** *(default)* — loads the player from a self‑hosted copy at
  `/libraries/mediaelement/build/…`. You must place the MediaElement.js `build` folder there
  (see [Installation](../installation/index.md)).
- **CDNJS** — loads the player from the CDNJS CDN. When you pick this, a **version** select
  appears; its options are fetched live from the CDNJS API, so you can pin a specific,
  known‑good MediaElement.js version for reproducible deployments.

## Global settings

- **Attach sitewide** *(default: off)* — when on, the player library is attached on **every**
  page so that *any* plain `<audio>` or `<video>` tag in your content is upgraded to the
  MediaElement player, not just fields using the module's formatters. Leave it off if you only
  want the formatters to trigger the player.
- **Class prefix** — an optional CSS class prefix for the player elements (the placeholder
  suggests `mejs__`). Leave blank unless you have a themeing reason to change it.
- **Set dimensions** *(default: on)* — set the player size via JavaScript rather than CSS.
- **Video defaults / overrides:**
  - **Default video width / height** — used when a `<video>` tag doesn't specify a size
    (placeholders 480 × 270).
  - **Video width / height** — if set, these **override** the video dimensions everywhere.
    Leave at the default (`-1`) to not force a size.
- **Audio defaults / overrides:**
  - **Default audio width / height** — used when omitted (defaults 400 × 30).
  - **Audio width / height** — if set, **override** the audio dimensions (default `-1` = don't
    override).

## Save

Click **Save configuration**. The settings are passed to the player's JavaScript, and — if you
enabled *Attach sitewide* — the library begins loading on every page.

> **Reminder:** With the default **Local** source and no library on disk, players will not run.
> Either place the library at `/libraries/mediaelement/build` or switch the source to **CDNJS**
> here.
