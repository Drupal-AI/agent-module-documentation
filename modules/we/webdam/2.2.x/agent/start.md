<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webdam — agent index

Integrates **Webdam (Acquia DAM) digital-asset management** with Drupal media (browse/use assets via Entity
Browser; `webdam_sns` submodule for AWS SNS asset-update notifications). Depends on core `media`,
`entity_browser`. Provides permissions. Version **2.2.0**. Core `^10.1||^11`.

Media/DAM — authenticates with **Webdam API credentials** (store as secrets, HTTPS); `webdam_sns` receives
**AWS SNS** notifications (validate the SNS signature so it can't be spoofed). Permission gates asset use.
