# Configuration

Blue Billywig does nothing useful until you connect it to your platform account.
This page walks through the global connection settings first, then how to build
the media type, reference field, and embed display, and finally the two optional
per‑video workflows.

## Step 1 — Connect to the platform

1. Log in as a user with the **Administer Blue Billywig** permission
   (`administer blue_billywig`).
2. Go to **Configuration → Media → Blue Billywig settings**, or navigate directly
   to `/admin/config/media/blue-billywig`.

Fill in the form field by field:

- **Publication** — your Blue Billywig publication *subdomain*. If your platform
  URL is `https://example.bbvms.com`, enter `example`. You can paste the whole URL
  if you like; on save the module strips `https://`, `http://`, and `.bbvms.com`
  for you. **Required.**
- **Client identifier** — optional. If set, it filters API and search results to a
  specific client/publication (the platform's `klantnaam`). Leave it blank unless
  Blue Billywig told you to use one.
- **Key** — your API **key ID** (the numeric id that pairs with the secret).
  **Required.**
- **Secret** — your API secret. This is a password field: once saved, leave it
  blank on future edits to keep the stored value — it's only overwritten when you
  type something new.
- **Playout** — the site‑wide default playout (player configuration). The dropdown
  is populated live from your platform account once the credentials validate, so
  you may need to save the key and secret first before the list fills in.
- **Embed type** — how videos are embedded by default: **JavaScript** (the
  default) or **iframe**. You can override this per display later.
- **Enable debug logging** — off by default. When on, the Uppy upload widget logs
  detailed upload information to the browser console. Handy when troubleshooting
  uploads; leave off in production.
- **Enable accessibility** — on by default. Shows the Scribit.Pro accessibility
  request option on Blue Billywig media (see Step 5).
- **Enable content protection** — on by default. Shows the content‑protection
  policy selector on Blue Billywig media (see Step 5).
- **Enable delete sync** — on by default. When a Drupal media entity is deleted,
  the matching clip on the platform is deleted too. The module skips this if
  another media entity still references the same clip, so you won't accidentally
  break a shared video.

When you click **Save configuration**, the module validates your key, secret, and
publication against the live platform (it performs a real API call). If the
credentials are wrong, the save is blocked and an error is shown on those fields —
so a successful save is your confirmation that the connection works.

## Step 2 — Create a Blue Billywig media type

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Set **Media source** to **Blue Billywig**.
3. Save. The source manages its own field that stores each clip's platform id, so
   you don't need to add that field yourself.

When you save, the module also adds two helper fields to the media type
automatically: one that tracks whether accessibility assets have been requested,
and one that stores an assigned content‑protection policy. Both are managed by the
per‑video forms in Step 5 rather than edited directly.

## Step 3 — Reference the video from your content

Add a **Media** reference field to whichever content type should carry videos,
pointing it at the Blue Billywig media type you just created, and choose the
**Media library** widget for it. Now, on the content edit form, clicking **Add
media** opens the Blue Billywig media library, where an editor can:

- **Search the platform** by keyword (matched against clip titles) and import an
  existing clip, or
- **Upload a new video.** If you entered an API key and secret, uploads use the
  Uppy widget and go straight from the browser to the platform's S3 storage
  (multipart, up to ~20 GB, bypassing your web server). Without credentials, it
  falls back to a normal Drupal file upload that passes through the server and is
  subject to your PHP `upload_max_filesize` / `post_max_size` limits.

## Step 4 — Display the video (embed formatter)

On the media type's **Manage display** tab, set the source field's format to
**Blue Billywig embed code**. In the formatter settings you can pick a specific
**Playout** and **Embed type**, or leave them on **"- Site defaults -"** to
inherit whatever you set on the global settings form. On the front end the module
fetches the ready‑made embed markup from the platform for that clip, playout, and
embed type (cached for an hour to keep API calls down).

## Step 5 — Optional per‑video workflows

Each of these appears on an individual media item and requires permission to edit
that media entity. They only show up if the matching toggle is on in Step 1.

- **Request accessibility** — a confirmation form that submits a Scribit.Pro
  transcription job for the clip (audio description, subtitles, and transcript).
  After you request it, the media's "accessibility requested" field is set so you
  can track which clips have been sent. Hidden when *Enable accessibility* is off.
- **Content protection** — lets you assign a content‑protection policy to the
  video, chosen from a live list of policies on your platform account. The form
  previews the policy's hide/tease behaviour and its rulesets before you apply it.
  Hidden when *Enable content protection* is off.

## Setting values without the UI

The connection settings are ordinary Drupal config, so you can script them:

```bash
ddev drush config:set blue_billywig.settings publication example -y
ddev drush config:set blue_billywig.settings embed_type iframe -y
```

You can also keep the secret out of exported config by overriding it in
`settings.php`, for example
`$config['blue_billywig.settings']['secret'] = getenv('BB_SECRET');`.

## Upgrading from an older, AWS‑credential version

Earlier releases stored raw AWS S3 credentials. This version uses the Blue
Billywig SAPI to obtain presigned upload URLs instead, so those AWS keys are no
longer needed — an update hook removes them for you. After updating the module's
code, run `drush updatedb && drush cache:rebuild`.
