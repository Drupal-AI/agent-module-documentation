<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Diboo core (diboo_core) — agent index

Base module for **Diboo**, a self-hostable "telephone" / "Chinese whispers" game played with
written phrases and drawings. Package `Diboo`. Core `^11.2`, PHP `^8.3`. License GPL-2.0-or-later.
Version 1.1.2. Depends on `views`, `entity`, `entity_link_formatter`, `token`, `change_labels`.
Suggests `diboo_signature_pad` (drawing tool) and `uploaded_file_filename_randomizer`.

## What it provides

- **4 node content types** (installed as config, bundle classes attached in code):
  `diboo_room` → `Room`, `diboo_chain` → `Chain`, `diboo_phrase` → `Phrase`,
  `diboo_image` → `Image` (extends `ChainLink`). Set by `DibooCoreHooks::entityBundleInfoAlter`.
- **Code-defined base fields** (via `entity` module's `BundleFieldDefinition`, registered in
  `DibooCoreHooks::entityFieldStorageInfo` + each bundle's `bundleFieldDefinitions`):
  `diboo_chain_links`, `diboo_rooms`, `diboo_current_contributors`, `diboo_finished`,
  `diboo_image`, `diboo_allowed_first_link_types`, `diboo_max_open_chains`,
  `diboo_max_open_chains_user`, `diboo_max_minutes_chain_lock`, `diboo_min_chain_links_between`,
  `diboo_min_chain_links_publish`. No config field UI; classes in `src/Entity/*Field.php`.
- **3 permissions** (`diboo_core.permissions.yml`): `administer diboo_core configuration`,
  `start new chains`, `add chain links to chains`. `hook_install` grants the latter two to
  `authenticated`.
- **4 routes** (`diboo_core.routing.yml`): `diboo_core.start_chain`, `diboo_core.add_chain_link`,
  `diboo_core.settings`, `diboo_core.diboo_front_page`.
- **1 config object + schema**: `diboo_core.settings` (default game rules).
- **1 service**: `Drupal\diboo_core\Hook\FinishedChains` (needs the views join manager arg);
  all other hook classes are autowired. **1 Views**: `diboo_finished_chains`. **1 library**:
  `diboo_core/chain-full-display` (CSS). Templates for front page, chain link, open chain.

## Solution docs

- **Content model — types, bundle classes, fields, game state** →
  [entities/model.md](entities/model.md)
- **Gameplay — routes, access, controllers, hooks, locking, cron, publishing** →
  [api/gameplay.md](api/gameplay.md)
- **Settings form & config object (default rules)** → [config/settings.md](config/settings.md)

## Install notes

Requires the `entity` contrib module (bundle field definitions), `entity_link_formatter` and
`token` (the room's "Start a new chain with a …" links), and `change_labels` (form submit/label
overrides). A drawing widget for `diboo_image` (e.g. Signature pad) is expected. `diboo_kickstart`
can prepare a basic setup. Cron must run at least as often as a room's lock timeout
(default 100 minutes) so locked chains are released.
