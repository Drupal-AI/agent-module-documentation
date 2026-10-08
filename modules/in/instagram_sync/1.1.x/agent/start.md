<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Instagram Sync — agent index

Imports **Instagram posts into the site** (fetch via the Instagram API, store as content — display a feed).
Config at `instagram_sync.settings_form`; provides permissions. Version **1.1.6**. Core `^8||^9||^10||^11`.

**Security:** store the Instagram/Meta **access token** as a **secret**; HTTPS; refresh per Meta's policy;
escape imported posts. No access role beyond permission.
