# Configuration

Instagram Media is configured **on the block itself**. You add the "Instagram
Media" block to a region and set everything — the access token and all the display
options — in the block's settings form.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place a new **Instagram Media** block in the region where you want the feed.
3. Open its settings form to configure the options below. (Administering the block
   requires the **administer instagram media block** permission.)

## Token and account

- **Access token** — paste your Instagram **long-lived access token**. This is what
  connects the block to Instagram's Graph API and lets it retrieve your media.
- **Auto token refresh** — provide your **application ID** and **application
  secret** (from **App Settings → General** at
  <https://developers.facebook.com>) so the module can refresh the token before it
  expires and keep the feed alive.

> **Treat the token, app ID, and app secret as secrets.** Keep them out of version
> control and exported configuration; on this project's DDEV convention, prefer
> environment variables (`ddev dotenv set …`) for sensitive values.

## Media settings

- **Image style options** — choose **no styling**, an **image style**, or a
  **responsive image style** (the last requires the core Responsive Image module).
  When you pick image or responsive styles, you can configure which styles apply,
  and optionally apply different styles to individual posts.
- **Display limit** — how many images or videos to show.
- **Video settings** — hide videos, or enable autoplay for Instagram videos in the
  feed.

## Post settings

- **Post captions** — show or hide captions.
- **Insights and links** — show insights (likes, comments, etc.) and post links.
  The header display can be tuned with options such as **Only Link**, **Tag and
  Link**, or **Full Instagram Look**.

## Styling settings

- **Swiper** — enable a Swiper carousel for slide-style navigation through the
  media, with optional arrows and pagination.
- **Fancybox** — enable a Fancybox lightbox for full-size viewing of a post.
- **Grid layouts** — choose from a range of grid layouts controlling how posts are
  arranged across mobile to desktop breakpoints.
- **Custom CSS** — disable the module's own CSS if you want to style the feed
  entirely from your theme.

## Save and verify

Save the block. View a page in the region where you placed it and confirm your
recent Instagram posts render with the styling you chose. If the block is empty,
re-check the access token (and that it hasn't expired), and confirm your Graph API
access is still valid.
