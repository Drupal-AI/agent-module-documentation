# Configuration

Setting up Media Entity Instagram has two parts: entering your Facebook App
credentials so the module can call Instagram's oEmbed API, and creating a Media
type that uses the Instagram source.

## Step 1 — Enter your Facebook App credentials

Instagram's oEmbed endpoint requires a Facebook App ID and secret. Create a
Facebook App (with Instagram oEmbed access) in Meta's developer console, then:

1. Log in as a user with the **Administer media** permission.
2. Go to **Configuration → Media → Instagram settings**, or navigate directly to
   `/admin/config/media/instagram-settings`.
3. Fill in:
   - **Facebook App ID** (`facebook_app_id`) — the numeric App ID.
   - **Facebook App secret** (`facebook_app_secret`) — the 32-character hex
     secret.
4. Save.

These credentials authenticate the calls that fetch each post's HTML, thumbnail,
and metadata. Without valid credentials (and network access) the source can still
derive a post's shortcode locally, but the actual embed content will come back
empty.

You can also set them from the command line:

```bash
drush config:set media_entity_instagram.settings facebook_app_id 123456789012345 -y
drush config:set media_entity_instagram.settings facebook_app_secret <32-hex> -y
```

## Step 2 — Create an Instagram media type

The module provides the source and formatter plugins; the media type itself is
standard core Media configuration.

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Give it a name (for example *Instagram*).
3. Under **Media source**, choose **Instagram**.
4. Save. Core creates a **source field** to hold the post URL — by default a
   text (`string`) field named `field_media_oembed_instagram`. The Instagram
   source accepts either a **string** or a **link** field as its source field, so
   you can reuse an existing one or let core create the default. You can share one
   source field across several Instagram types, or give each type its own.

When the media type's display is prepared, the source automatically assigns the
**instagram_embed** formatter to the source field, so embeds render without extra
work.

## The embed formatter's display options

On the media type's **Manage display**, the source field uses the
**instagram_embed** formatter, which has two settings:

- **Maximum width** (`max_width`) — the maximum embed width in pixels, passed to
  the oEmbed request. `0` uses the provider's default width. Set this to fit your
  content column.
- **Hide caption** (`hidecaption`) — when enabled, hides the Instagram caption in
  the rendered embed for a cleaner, image-first look.

## Using it as an editor

With credentials set and a media type in place, editors add an Instagram post by
pasting its URL into the source field — through the **Add media** flow in the
media library, or via a media-reference field on a content type. Only genuine
Instagram post (`/p/`), reel (`/reel/`), and IGTV (`/tv/`) URLs on `instagram.com`
or `instagr.am` are accepted; other URLs are rejected. Each post is stored once as
a reusable media entity, with a local thumbnail generated for use in listings and
teasers.

## A note on offline environments

Only the post **shortcode** and its fallback **default name** are derived locally
from the URL. Everything else — author name, embed HTML, thumbnail, dimensions —
comes from Instagram's oEmbed API and therefore needs valid credentials and
network access. Setting up the media type, source field, and formatter does not
require the network; only live embedding of real posts does.
