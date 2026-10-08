<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Diboo core is the base module for Diboo, a self-hostable "telephone"/"Chinese whispers" game where players take turns writing a phrase and drawing it, each seeing only the step immediately before theirs, until a chain reaches a set length and is published for everyone to see.

---

The module implements the game on top of Drupal nodes. It ships four content types — **Room** (`diboo_room`), **Chain** (`diboo_chain`), **Phrase** (`diboo_phrase`) and **Image** (`diboo_image`) — each backed by a bundle class (`Room`, `Chain`, `Phrase`, `Image` extending `ChainLink`) set via `hook_entity_bundle_info_alter`, and adds all the game's fields in code (`entity_field_storage_info` + `bundleFieldDefinitions`, using `entity`'s `BundleFieldDefinition`): `diboo_chain_links`, `diboo_rooms`, `diboo_current_contributors`, `diboo_finished`, `diboo_image`, `diboo_allowed_first_link_types`, `diboo_max_open_chains`, `diboo_max_open_chains_user`, `diboo_max_minutes_chain_lock`, `diboo_min_chain_links_between` and `diboo_min_chain_links_publish`. A **Room** groups chains and holds the rules for them; a **Chain** is an ordered set of chain links; a **Phrase** is a chain link whose node title is the phrase, and an **Image** is a chain link carrying a drawing (a code-defined single-value image field). Two custom routes drive play: `diboo_core.start_chain` (`/node/{room}/diboo-start-chain/{node_type}`) creates a new chain link that opens a chain in a room, and `diboo_core.add_chain_link` (`/node/{chain}/diboo-add-chain-link/{node_type}`) appends a link to an existing chain; both are node operation routes with `RoomController`/`ChainLinkController` title and access callbacks. Access rules enforce the game: a room only allows a new chain when it is published and under its open-chain and per-user limits; a chain only accepts a new link when it is unpublished, not locked by a different user, and the last N links were not by the same contributor. Adding a link **locks** the chain to the current user (`diboo_current_contributors`); `hook_cron` (`Cron`) unlocks chains left locked longer than the room's `diboo_max_minutes_chain_lock`. When a chain's link count reaches the room's `diboo_min_chain_links_publish`, `ChainLink::postSave` publishes the chain, and `Chain::preSave` publishes every link, fills image titles/alt from the preceding phrase, and builds a chain title of the form `From "…" to "…"`. A settings form at `/admin/config/system/diboo-settings` stores the default rules in `diboo_core.settings`. The Room full view shows open chains (with per-chain "Draw"/"Describe" action links) and a `diboo_finished_chains` view of published chains; an anonymous front page lives at `/diboo-frontpage`. `hook_install` grants the `authenticated` role the `start new chains` and `add chain links to chains` permissions. The module depends on `views`, `entity`, `entity_link_formatter`, `token` and `change_labels`, and suggests a drawing tool (Signature pad) plus a filename randomizer.

---

- Run a self-hosted, free-software "Chinese whispers" / telephone drawing game on a Drupal site.
- Let logged-in users start new chains from a phrase and take turns drawing and describing.
- Group related chains into a Room with its own rules and a public page listing open and finished chains.
- Cap how many chains can be open at once in a room, and how many one user may have open.
- Force variety by requiring N other contributors before the same user can add to a chain again.
- Auto-publish a chain once it reaches a configured number of links, then reveal all links in order.
- Prevent two players editing the same chain at once via per-chain locking on the current contributor.
- Automatically release chains left locked too long by running cron on a schedule.
- Give published chains an automatic title like `From "a cat having tea" to "…"` from first and last phrases.
- Set image chain links' alt text and title from the phrase that preceded the drawing.
- Offer an anonymous landing page (`/diboo-frontpage`) explaining the game with a "Play" call to action.
- Configure site-wide default game rules (open-chain limits, links-between, links-to-publish, lock minutes) at `/admin/config/system/diboo-settings`.
- Restrict which chain-link types may start a chain per room via `diboo_allowed_first_link_types`.
- Build the game entirely from nodes so existing node access, moderation and theming apply.
- Add code-defined fields to node bundles without site builders creating them in the UI.
- Present per-room "Start a new chain with a …" links using the `entity_link_formatter` and token integration.
- Embed a Views listing of a room's finished chains directly on the room page.
- Swap in a drawing widget such as `diboo_signature_pad` for the image chain-link type.
- Use `diboo_kickstart` to bootstrap a working room + chain + two chain-link types quickly.
- Extend the game with additional chain-link types by adding node types (image/phrase logic is the built-in pair).
- Track how often each user is auto-unlocked by cron (stored in state `diboo_core_unlocks`).
- Give authenticated users the ability to participate immediately after install without manual permission setup.
