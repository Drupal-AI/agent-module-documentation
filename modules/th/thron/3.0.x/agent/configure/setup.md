<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the THRON connector

## Credentials & config route
`/admin/config/services/thron` (`THRONConfigurationForm`), permission `administer thron configuration` (`restrict access: TRUE`).

`thron.settings` config keys: `client_id`, `app_id`, `app_key`, `thron_x_client_id`, `thron_x_client_secret`, `preview_language`, `classifications`, `avoid_classifications`, `responsive_pictures_enable`, `responsive_pictures_breakpoints`, cache max-age keys.

## Steps
1. Enter THRON client ID / app ID / app key from your THRON account.
2. Save; then pick the intelligence classifications (e.g. Topic, Target) the connector will search tags on.
3. Add the **THRON** button to a CKEditor 5 text format at `/admin/config/content/formats/manage/{format}` and enable "Display embedded entities".
4. Expose the THRON Entity Browser widget (`thron_search`, `thron_upload`) in the media field / media library.

## Permissions
- `administer thron configuration` — the config form (restricted).
- `thron search media` — autocomplete + chunked upload routes.
- `thron upload media` — the upload widget.
