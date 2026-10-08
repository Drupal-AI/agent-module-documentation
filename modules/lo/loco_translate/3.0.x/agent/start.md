<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Loco Translate — agent index

Collects and syncs **interface (i18n) translations to/from Loco (localise.biz)** (translation management in
Loco, synced back to Drupal). Depends on core `locale`; Drush + permissions. Version **3.0.8**. Core
`^10.5||^11||^12`.

**Security:** store the Loco API key as a **secret** (Key/env), not exported config; HTTPS. Handles interface
strings; no access role beyond permission.
