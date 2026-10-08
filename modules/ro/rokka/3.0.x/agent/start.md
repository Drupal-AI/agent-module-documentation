<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rokka — agent index

Integrates **Rokka.io** (image processing service + CDN) with Drupal's file system (store/serve/derive images
via Rokka). Config at `rokka.admin_settings`; provides **Drush commands** + permissions. Version **3.0.15**.
Core `^9||^10||^11`.

**Security:** store Rokka API credentials as secrets; images served from Rokka's CDN (don't route
access-restricted images through a public CDN); TLS not disabled. Media/performance; no access role.
