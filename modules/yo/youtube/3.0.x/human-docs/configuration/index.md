# Configuration

Using YouTube Field is three steps: **add the field**, **pick a formatter** for how it
displays, and (optionally) adjust the **site-wide settings** that act as defaults for
every player and thumbnail.

## Step 1 — Add the field

Go to **Structure → Content types → (your type) → Manage fields → Add field** and
choose field type **YouTube video**. That's it — the field stores the raw URL the
editor pastes plus the extracted video ID.

When someone edits content, the field shows a single text box. They paste a YouTube
URL in almost any form — `watch?v=…`, `youtu.be/…`, `/embed/…`, `/v/…`, `/shorts/…`,
with or without `http(s)://` or `www.` — and the module extracts the ID on save. A
non-YouTube URL is rejected with "Please provide a valid YouTube URL." On the widget's
settings (under **Manage form display**) you can set a **placeholder URL** to show a
sample in the empty box.

## Step 2 — Choose a formatter (Manage display)

On the content type's **Manage display**, pick one of three formatters for the field:

### Video — embedded player

Embeds an iframe player. Key options:

- **Size** — one of `450x315`, `480x360`, `640x480`, `960x720`, **Responsive** (scales
  to its container), or **Custom** (you enter width and height).
- **Autoplay**, **Mute**, **Loop** — behaviour toggles. (Modern browsers require a
  video to be muted for autoplay to work reliably.)
- **Hide controls** — always hide the player controls.
- **Autohide controls** — hide the controls only after playback begins.
- **Hide annotations** — suppress on-video annotations for a cleaner embed.

### Thumbnail — image

Shows the video's thumbnail instead of a player. The image is downloaded from YouTube
on first render, saved as a managed file, and rendered — which means you can apply a
Drupal **image style** to it. Options:

- **Image style** — any image style, or the original image.
- **Image link** — link the thumbnail to the host entity's page, to the video on
  YouTube, or to nothing.

If the local download fails, it falls back to the remote image (no image style can be
applied in that case).

### URL — plain link or text

Outputs the raw YouTube URL, either as plain text or a clickable link.

## Step 3 — Global settings

**Configuration → Media → YouTube Field** (`/admin/config/media/youtube`) sets
site-wide defaults for players and thumbnails. You need the **Administer YouTube**
permission. The options:

| Setting | Default | What it does |
|---------|---------|--------------|
| **Show suggested videos** | On | Show related videos when a video ends. |
| **Modest branding** | Off | Hide the YouTube logo on the control bar. |
| **Light theme** | Off | Use the light-coloured control bar. |
| **White progress bar** | Off | Use a white progress bar instead of red. |
| **Enable JS API** | Off | Enable the IFrame JS API for programmatic player control. |
| **wmode fix** | On | Legacy IE8 overlay fix. |
| **Allow parameter override** | Off | Let editors append extra player parameters (e.g. `&start=30`). |
| **Privacy-enhanced mode** | Off | Embed via `youtube-nocookie.com` so no cookies are set until the visitor plays a video. |
| **Player CSS class** | `youtube-field-player` | The CSS class/ID base applied to every iframe. |
| **Thumbnail directory** | `youtube` | The files subdirectory where downloaded thumbnails are stored. |
| **Hi-res thumbnails** | On | Save the high-resolution `maxresdefault` image when available, falling back to standard. |
| **Token image style** | *(none)* | Image style used for the thumbnail-URL token output. |

The settings form also has a **Refresh existing thumbnail image files** button, which
deletes all cached thumbnails so they're re-fetched on next render — handy after
changing the hi-res or directory settings.

## Tokens

For every YouTube field the module registers two tokens: a **video URL** token (the
canonical `watch?v=…` URL) and an **image URL** token (the local thumbnail URL,
optionally passed through the token image style set above). Use them anywhere Drupal
tokens are accepted — meta tags, mail templates, and so on.

## Privacy and consent

If your site has cookie-consent obligations, turn on **Privacy-enhanced mode**. Embeds
then use `youtube-nocookie.com`, which sets no cookies until the visitor actually
plays the video.
