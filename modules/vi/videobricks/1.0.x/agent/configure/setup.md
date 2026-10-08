<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring 42videobricks

## API settings
`/admin/config/videobricks/settings` (`VideobricksSettingsForm`, config `videobricks.settings`):
- **Api key** — the `x-api-key` for 42videobricks.
- **Environment** — sandbox / staging / production, mapping to fixed hosts via
  `getHostByEnv()`:
  - sandbox → `https://api-sbx.42videobricks.com`
  - staging → `https://api-stg.42videobricks.com`
  - production → `https://api.42videobricks.com`
On save, `getVideos()` is called to validate the key.

## Using it
- The `videobricks` media source lets you create media entities for hosted videos.
- Editors add videos with the field widget; `VideobricksTrait::validateVideobricksElement()`
  calls `getVideoById()` to confirm the ID.
- Admin library/add/init/finalize routes drive browsing and chunked uploads.

## Notes
- All admin routes require `administer 42videobricks` (restricted permission).
- Communication uses the `Api42Vb\Client` SDK over Guzzle; hosts are fixed HTTPS
  (no user-supplied endpoint), TLS verification on.
