<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pantheon Content Publisher — agent index

Integrates Drupal with the **Pantheon Content Publisher** (connect to Pantheon's content-publishing service —
e.g. author in Google Docs, publish into Drupal). Depends on `search_api` (>= 8.x-1.20); provides
permissions. Version **1.0.5**. Core `^10||^11`.

**Security:** store Pantheon credentials/tokens as **secrets**; HTTPS; treat imported content per source
trust. No access role beyond permission.
