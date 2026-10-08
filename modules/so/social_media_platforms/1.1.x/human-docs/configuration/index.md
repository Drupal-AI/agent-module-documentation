# Configuration

Setting the module up is a two-part job: enter your organisation's profile URLs
on the settings form, then place the block that displays them.

## Who can configure it

The **administer social media platforms** permission controls access to the
settings form. It is not marked as a restricted permission — reasonable, since a
holder can only set outbound profile URLs — but remember those URLs appear on
every page that carries the block, so grant it to people you trust with the
site's public presence.

## Enter your profile URLs

1. Go to **Configuration → Web services → Social Media Platforms**
   (`/admin/config/services/social-media-platforms`).
2. For each platform you use, enter the URL of your organisation's profile page
   (for example your Facebook page, LinkedIn company page, YouTube channel or
   Instagram profile). Leave a platform blank to omit its icon.
3. Set the order of the icons where the form allows it, so the row matches your
   branding.
4. Save the configuration.

Keeping these URLs in configuration is the whole point: a marketer can update a
profile link without a code deploy, and the icons stay consistent across the
site.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the Social Media Platforms block in the region you want — commonly a
   footer, header or sidebar.
3. Configure its visibility if you want it on only some pages, and save.

The block renders as plain anchor links with icons and loads nothing
third-party, so it needs no cookie-consent handling. On a multilingual site the
block can appear in each language's layout as usual.
