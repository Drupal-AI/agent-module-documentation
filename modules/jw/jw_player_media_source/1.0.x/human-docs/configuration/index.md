# Configuration

Configuration has two parts: entering your JW Player credentials, then choosing how
editors embed videos (field, block, or CKEditor 5).

## Enter your JW Player credentials

1. Log in as a user with the **administer jw player media source** permission.
2. Go to **Configuration → Media → JW Platform Media Source**
   (`/admin/config/media/jw-player-media-source`).
3. Fill in:
   - **JW Player API v2 key / secret** — your JW Platform v2 API credential. This
     is sent as a Bearer token when the module queries JW's API, so treat it as a
     secret (see the note below).
   - **Site ID(s)** — the ID of the JW Player site whose library you want to
     browse. Changing this later switches which JW library editors see.
   - **Enable the source** — turn the media source on.
4. Save.

These values are stored in the `jw_player_media_source.settings` configuration
object.

> **Keep the API key out of version control.** Because the key is a sensitive
> credential, prefer supplying it from an environment variable rather than typing a
> permanent secret into exported config. With DDEV you can store it with
> `ddev dotenv set .ddev/.env --jw-api-key=<value>` and reference it from
> `settings.php` (never commit `.ddev/.env`). Anyone who can export your site
> configuration can read a key stored directly in config.

## Choose how editors embed videos

Once credentials are saved, pick one or more of these embedding paths:

### Field

Add the **JW video field** to a content type (its field type is `JwVideoItem`).
Editors set the video with the JW video **widget**, and it renders through the JW
video **formatter** as JW Player's player script embed.

### Block

Place the **JW Video** block (`JwVideoBlock`) into any region from **Structure →
Block layout** to embed a chosen video there.

### CKEditor 5

Enable the bundled JW Player plugin in a text format's toolbar
(**Configuration → Content authoring → Text formats and editors**). Editors can
then embed a JW video directly inside rich‑text content.

## Browsing and picking videos

Editors browse the remote library at **Content → JW media**
(`/admin/content/jw-media`), which requires the *administer site configuration*
permission. You can search by video **title** and page through results (10 per
page); a modal picker is also available. Selecting a video produces the JW Player
embed that the field, block, or CKEditor plugin renders. Per‑video thumbnails are
pulled from `cdn.jwplayer.com`.
