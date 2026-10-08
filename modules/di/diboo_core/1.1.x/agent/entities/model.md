<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Diboo core — content model

Everything is a **node**. Four content types ship as config (`config/install/node.type.*`) and get
bundle classes via `DibooCoreHooks::entityBundleInfoAlter`. Fields are defined in **code**
(no field-config UI): storage in `DibooCoreHooks::entityFieldStorageInfo`, per-bundle definitions
in each bundle class's `bundleFieldDefinitions()`. Field classes live in `src/Entity/*Field.php`
and build `Drupal\entity\BundleFieldDefinition` objects (hence the `entity` module dependency).

## Content types & bundle classes

| Type (bundle) | Class (`src/Entity/`) | Role |
|---------------|-----------------------|------|
| `diboo_room` | `Room` | Groups chains; holds the rules. `preview_mode: 1`. |
| `diboo_chain` | `Chain` | Ordered container of chain links. |
| `diboo_phrase` | `Phrase` (extends `ChainLink`) | Chain link whose **node title is the phrase**. Ships `third_party_settings.diboo_core.diboo_function: link`. |
| `diboo_image` | `Image` (extends `ChainLink`) | Chain link carrying a **drawing** (image field). |

`Phrase` and `Image` are thin subclasses of `ChainLink`. `ChainLink::getChainLinkType()` reads
the node type's `diboo_core.chain_link_type` third-party setting (defaults to `'phrase'`).

## Fields by bundle

**Room** (`Room::bundleFieldDefinitions`):
- `diboo_allowed_first_link_types` — entity_reference to `node_type`, unlimited, required. Which
  chain-link types may **start** a chain here. Displayed with the `entity_link` formatter as
  "Start a new chain with a …" links (uses `entity_link_formatter` + token).
- `diboo_max_minutes_chain_lock`, `diboo_max_open_chains`, `diboo_max_open_chains_user`,
  `diboo_min_chain_links_between`, `diboo_min_chain_links_publish` — per-room rule fields (see
  [../config/settings.md](../config/settings.md) for defaults & meaning).

**Chain** (`Chain::bundleFieldDefinitions`):
- `diboo_chain_links` — entity_reference to `node` (`diboo_phrase`/`diboo_image`), unlimited,
  required, ordered = play order.
- `diboo_rooms` — entity_reference to the owning room node.
- `diboo_current_contributors` — entity_reference to `user` (`include_anonymous: TRUE`); non-empty
  = **chain is locked** by that user.
- `diboo_finished` — timestamp, set when the chain auto-publishes (`FinishedField`; also installed
  by `diboo_core_update_11001`).

**Image chain link** (`ChainLink::bundleFieldDefinitions`, only when bundle is `diboo_image`):
- `diboo_image` — core `image` field, cardinality 1, `public://` scheme,
  `file_directory: diboo-image/[date:custom:Y]-[date:custom:m]`, extensions `png gif jpg jpeg svg`,
  max 5MB / 3200x2000, min 400x250, alt & title fields enabled (not required).

`BundleFieldOverrides` (`hook_entity_bundle_field_info`) relabels the `title` base field to
**"Phrase"** on `diboo_phrase`.

## Chain lifecycle (state machine)

1. **Start** — `diboo_core.start_chain` creates the first chain link; `ChainLink::postSave`
   (new, no `chain` route param) creates a `diboo_chain` node and appends the link.
   `Chain::assignRoom` sets the room from the route, unpublishes the chain, gives it a placeholder
   title (label or uuid).
2. **Open / locked** — new links added via `diboo_core.add_chain_link`. Opening the add form locks
   the chain to the current user (`Chain::lockForUserId`, set in `ChainLinkFormDisplay`). Saving a
   link calls `Chain::unlock()`.
3. **Publish** — in `ChainLink::postSave`, when `count(chain_links) >= room->getMinChainLinksToPublish()`
   the chain is published, unpromoted, and `diboo_finished` is stamped.
4. **On publish** — `Chain::preSave` publishes every chain link, copies the preceding phrase into
   each image's `title` and `alt`, and builds the chain title `From "@init" to "@last"`
   (`Markup::create` used only to avoid escaping quotes inside the translated string; the stored
   title is plain text, escaped normally on output).

Chain links are created unpublished/unpromoted (`ChainLink::preSave`); a phraseless link gets its
uuid as title.
