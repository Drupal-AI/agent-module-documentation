# Configuration

Cloudflare Stream needs three things before it can do anything: your Cloudflare
credentials on the settings form, at least one place to put videos (a field or a
Media type), and the right permissions for whoever manages the credentials.

## 1. Enter your Cloudflare credentials

1. Log in as a user with the **Administer Cloudflare Stream settings** permission.
2. Go to **Configuration → Media → Cloudflare Stream → Settings**
   (`/admin/config/media/cloudflare-stream/settings`).

Fill in the four fields:

- **API token** *(required)* — a Cloudflare API token with Stream permissions,
  sent as a Bearer token on every API call. When you save, the module verifies the
  token live against Cloudflare; an invalid or inactive token blocks the form, so
  you can't accidentally save broken credentials. Treat this token as a secret —
  see the security note below.
- **Account ID** *(required)* — your Cloudflare account ID, used to build the Stream
  API URL.
- **Customer subdomain** *(required)* — the first label of your Stream customer
  subdomain (for example `customer-abc1234`). This is used to build playback URLs
  such as `https://customer-abc1234.cloudflarestream.com/<video-id>/watch`.
- **Debug messages** *(checkbox)* — when on, Cloudflare API error responses are
  shown on screen to help you diagnose upload/playback problems. When off, errors
  are only written to the `cloudflare_stream` log channel. Leave it off on
  production and turn it on temporarily while troubleshooting.

The submit handler strips whitespace from the token, account ID, and subdomain
before saving, so stray spaces from copy‑paste won't break things.

> **Keeping the token out of version control.** The token is stored in the
> `cloudflare_stream.settings` config object. If you export configuration to code,
> avoid committing the real token — a common pattern is to keep the value in an
> environment variable and override it in `settings.php`
> (`$config['cloudflare_stream.settings']['api_token'] = getenv('CLOUDFLARE_STREAM_TOKEN');`),
> so the secret lives in the environment (for example a DDEV `.env` file that is not
> committed) rather than in exported config.

## 2. Permissions

Two permissions (under **People → Permissions**) gate the module's admin area — and
only that area:

- **Access Cloudflare Stream config page** — reach the config landing page at
  `/admin/config/media/cloudflare-stream`.
- **Administer Cloudflare Stream settings** — edit the credentials form above.

Neither permission grants the right to upload or view videos. Video upload happens
through the normal field widget on whatever entity form carries a Cloudflare Video
field, and is governed by that entity's ordinary edit access — there is no separate
upload route or permission.

## 3. Add a Cloudflare Video field

To let editors upload videos on a content type:

1. Go to the content type's **Manage fields** screen and **Add field → Cloudflare
   Video**.
2. On the form display (**Manage form display**), keep the **Cloudflare Video**
   widget — it extends the standard file upload widget, so uploading feels familiar,
   but the file is pushed to Cloudflare on save.
3. On the display (**Manage display**), choose the **Cloudflare Video** formatter to
   embed the player, and set:
   - **Controls** — show the player's playback controls.
   - **Muted** — start muted.
   - **Autoplay** — begin playing automatically (browsers usually require muted for
     this to work).
   - **Loop** — replay when the video ends.
   - **Width** and **Height** — the player dimensions.

   Alternatively pick the **thumbnail** formatter to show a Cloudflare‑hosted poster
   image instead of the player.

You can add several display variants of the same video by configuring the formatter
differently in different view modes.

## 4. (Optional) Build a Cloudflare Stream Media type

If you'd rather manage videos as reusable Media entities:

1. Go to **Structure → Media types → Add media type**.
2. Choose **Cloudflare Stream** as the media source.
3. Save. The source automatically creates its source field, restricted to supported
   video extensions (`mp4`, `mkv`, `mov`, `avi`, `flv`, `webm`, `mpg`, `mpeg`, `qt`,
   and related formats), and wires the Cloudflare video formatter into the display.

A Cloudflare Stream Media type is also the prerequisite for the **Sync** submodule,
which imports videos that already live in your Cloudflare account back into Drupal
as Media items.

## What happens on upload

When an editor uploads a video, the module writes it to a local temporary file,
then starts a resumable TUS upload to Cloudflare. Once the transfer completes, the
returned Cloudflare video ID replaces the local reference (the field ends up pointing
at `cfstream://<video-id>`) and the local temp copy is deleted. Removing the file
from the field deletes the corresponding video from Cloudflare. Playback is served
from your customer subdomain URL.
