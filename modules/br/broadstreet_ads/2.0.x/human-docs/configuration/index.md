# Configuration

Setting up Broadstreet Ads is two steps: register your zones on the settings form,
then place the resulting blocks in your theme.

## 1. Register your ad zones

1. Log in as a user with the **Administer Broadstreet ads** permission
   (`administer broadstreet ads`) — grant it under **People → Permissions**.
2. Go to **Configuration → Services → Broadstreet Ads**, or navigate directly to
   `/admin/config/services/broadstreet-ads`.
3. In the zones field, enter one zone per line as `zoneid|Label`, for example:

   ```
   12345|Homepage leaderboard
   67890|Sidebar rectangle
   ```

   The number is your Broadstreet zone ID; the label is a friendly name that helps
   you identify the block when placing it. The zone ID is cast to an integer before
   it is output, so only valid numeric zones are rendered.
4. Save the form. The settings are stored in the `broadstreet_ads.settings`
   configuration object.

To add or remove ad zones later, just edit this list. Clearing the list disables
all ads — and because the loader script is only attached when at least one zone is
configured, an empty list means no Broadstreet script loads at all.

## 2. Place the ad blocks

Each configured zone becomes its own block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the Broadstreet ad block for the zone you want (identified by the label you
   gave it) and place it into a theme region.
3. Optionally use the block's **visibility conditions** to show the ad only on
   certain pages, content types, or for certain roles.

The block outputs Broadstreet's `<broadstreet-zone>` web component, and
Broadstreet's loader script (attached automatically on non‑admin pages) fills it
with the actual ad. Ads never appear on admin pages.

## Notes

- Ad loading is entirely client‑side via Broadstreet's script — Drupal makes no
  server‑side outbound ad requests.
- Only the `<broadstreet-zone>` tag and integer zone IDs are emitted, which keeps
  the markup clean and predictable.
