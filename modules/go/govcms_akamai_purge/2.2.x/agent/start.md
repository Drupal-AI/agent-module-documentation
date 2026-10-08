<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GovCMS Akamai Purge — agent index

**Akamai CDN purge** helper integrating with **Purge** (core-tags queuer + late-runtime processor) —
invalidate Akamai cache on content change. GovCMS-oriented. Depends on `purge_queuer_coretags`,
`purge_processor_lateruntime`. Provides **Drush commands** + permissions. Version **2.2.5**. Core
`^10.3||^11`.

**Security:** store Akamai purge-API credentials as secrets, least-privilege.
