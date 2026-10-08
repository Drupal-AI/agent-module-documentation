<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Potx Extract Translations (PET) — agent index

**Drush command for PO translation extraction** via POTX. Version **1.1.0**. Core `^11.3 || ^12`. Requires Drush `^13` and the `potx` module.

Developer/translation tool; no content/access role, no config UI, no permissions.

- **Extract translations (Drush)** — the sole capability: `potx:extract-translations` (alias `pet`) writes `translations/<project>.<lang>.po` per project and patches each `.info.yml`. See [drush/drush_pet.md](drush/drush_pet.md).
