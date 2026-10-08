# Configuration

Media entity Lottie has no settings form of its own. You set it up entirely
through the standard Media administration: create a media type that uses the
Lottie source, then confirm its display uses the Lottie player. This page walks
through both, then covers the player settings.

## 1. Create a Lottie media type

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Give it a name (for example "Lottie animation").
3. Set **Media source** to **Lottie file**.
4. Save.

When you save, the module automatically creates a file field for the animation,
restricted to the `json` extension. This source field is named
`field_media_lottie_file` — **keep that machine name**. The Lottie player
formatter only recognizes a field whose name contains `field_media_lottie_file`
(plain JSON files share a MIME type with other formats, so the module matches on
the field name instead). If you rename it, the player will not apply.

## 2. Confirm the display uses the Lottie player

The module already sets the source field's display to the **Lottie player**
formatter when the type is created, so usually there is nothing to change. To
review or adjust it:

1. On the media type, open **Manage display**.
2. Find the source field and confirm its **Format** is **Lottie player**.
3. Click the gear icon to open the player settings (covered below).

## 3. Map metadata to fields (optional)

The Lottie source can read several attributes out of the animation JSON and copy
them into fields on your media type. On the media type's **Field mapping**
settings, you can map any of:

| Attribute | What it is |
|-----------|------------|
| **Width** | The animation's pixel width. |
| **Height** | The animation's pixel height. |
| **Name** | The animation's internal name — handy mapped to the media label so uploads are auto‑named. |
| **Version** | The Lottie/Bodymovin version the file was exported with. |
| **Frames** | The frame rate. |

Plus the standard core File attributes. Mapping is optional — skip it if you
don't need the metadata.

## Player settings, field by field

Open the source field's format settings (**Manage display → gear icon**) to tune
how animations play. These are the settings on the **Lottie player** formatter:

- **Background** — the background color behind the animation (default white,
  `#FFFFFF`). Ignored when *Background transparent* is on.
- **Background transparent** — when ticked, the animation has no background
  color, so it blends into whatever is behind it on the page. Off by default.
- **Hover** — when ticked, the animation plays while the mouse is over it and
  pauses otherwise. Off by default.
- **Play when visible** — when ticked, the animation only starts playing once it
  scrolls into view, which reduces jank on long pages. Off by default. (This
  attaches a small extra behavior built on the LottieFiles interactivity
  library.)
- **Mode** — playback direction. **Normal** plays straight through; **Bounce**
  plays forward then reverses back and forth. Default is normal.
- **Speed** — playback speed multiplier. Default `1` (normal speed); values
  above 1 play faster.
- **Count** — how many times the animation loops. `0` (the default) means
  undefined, i.e. loop infinitely; a positive number loops that many times.

Click **Update**, then **Save** the display.

## Using it

With the media type in place, editors upload `.json` Lottie files through the
Media library like any other media. On upload the file is validated — an empty
file, invalid JSON, or a file missing the required Lottie keys is rejected with a
clear message. Reference the media from a content type, Layout Builder, or
anywhere an entity reference to media is allowed, and it renders as a playing
`<lottie-player>` animation using the settings you chose above.

## A note on the CDN

The player's JavaScript comes from the unpkg CDN. If your site has no outbound
network access, or you don't want to rely on a third‑party CDN, you can override
the module's libraries (`lottie_player`, `lottie_interactivity`) with locally
hosted copies using Drupal's standard library override mechanism.
