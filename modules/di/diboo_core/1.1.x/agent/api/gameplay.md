<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Diboo core — gameplay: routes, access, hooks

## Permissions (`diboo_core.permissions.yml`)

- `administer diboo_core configuration` (restrict access) — the settings form.
- `start new chains` — create new chains (open-chain limits still apply).
- `add chain links to chains` — participate by adding links.

`diboo_core_install()` grants `start new chains` and `add chain links to chains` to the
`authenticated` role.

## Routes (`diboo_core.routing.yml`)

- **`diboo_core.start_chain`** — `/node/{room}/diboo-start-chain/{node_type}`. `_entity_form:
  node.diboo_chain_link`. Requirements: `_permission: start new chains`,
  `_entity_access: room.new_chain`, `_custom_access:
  RoomController::startChainAccess`. Node operation route; `node_type` uses config overrides.
- **`diboo_core.add_chain_link`** — `/node/{chain}/diboo-add-chain-link/{node_type}`. `_entity_form:
  node.diboo_chain_link`. Requirements: `_permission: add chain links to chains`,
  `_entity_access: chain.add_chain_link`. (Note: `_custom_callback` names
  `ChainLinkController::addChainLinkAccess` — the real access gate is the `chain.add_chain_link`
  entity-access op below.)
- **`diboo_core.settings`** — `/admin/config/system/diboo-settings`, `_permission: administer
  diboo_core configuration`.
- **`diboo_core.diboo_front_page`** — `/diboo-frontpage`, `_permission: access content`.
  `DibooFrontPage` (`__invoke`) shows an anonymous-only intro (`#access` = anonymous) plus all
  published `diboo_room` nodes rendered via the node view builder.

## Access logic

- **`RoomController::startChainAccess($room, $node_type)`** — allowed only if `$node_type` is in
  the room's `diboo_allowed_first_link_types`.
- **`Room::access('new_chain')`** — forbidden unless the room is published and both
  `getOpenChainsCount()` < `diboo_max_open_chains` and per-user
  `getOpenChainsCount($account->id())` < `diboo_max_open_chains_user`. Open chains are counted with
  an entity query (`getOpenChainsResult`, `accessCheck(FALSE)`, filtered to the room, unpublished,
  same langcode) purely to enforce the limit.
- **`Chain::access('add_chain_link')`** — forbidden if the chain is published (closed), not a
  `diboo_chain`, locked by a **different** user (`diboo_current_contributors` non-empty and not the
  current account), or any of the last `diboo_min_chain_links_between` links was authored by the
  current user.
- **`ChainLinkController::addChainLinkAccess($chain, $node_type)`** — the type must be
  `diboo_phrase` or `diboo_image`, and the **last** link must not be the same type (enforces
  alternation phrase↔image).
- **`ChainLinkController::addChainLinkPageTitle` / `RoomController::newChainPageTitle`** — title
  callbacks ("Draw" / "Describe the picture" / "@room: start a chain with a @type").

## Locking & cron

- Locking: `ChainLinkFormDisplay::entityFormDisplayAlter` (form mode `diboo_chain_link`) hides all
  form components except the relevant widget, sets submit label/message via `change_labels`, and
  calls `$chain->lockForUserId(currentUser)` — appends the user to `diboo_current_contributors`
  only if empty (first-lock wins). Saving a link calls `Chain::unlock()` (`ChainLink::postSave`).
- **`Cron::cron()`** (`hook_cron`, autowired) loads chains that have `diboo_current_contributors`
  (`accessCheck(FALSE)`); if `now - changedTime > room.diboo_max_minutes_chain_lock * 60`, it
  records the locking user in state `diboo_core_unlocks` and unlocks the chain. Run cron at least
  as often as the smallest room lock timeout.

## Other hooks (all in `src/Hook/`, attribute `#[Hook]`, autowired)

- `DibooCoreHooks`: `theme` (front page, `node__diboo_open_chain`, `node__diboo_chain_link`),
  `entity_type_alter` (adds `diboo_chain_link` form operation + `diboo_start_chain` link template),
  `entity_field_storage_info`, `entity_bundle_info_alter` (bundle classes),
  `entity_view_display_alter` (arranges full-view components for room/chain and the
  `diboo_chain_link` view mode).
- `BundleFieldOverrides` (`entity_bundle_field_info`): relabels the phrase title to "Phrase".
- `ChainView` (`node_view`): attaches the `diboo_core/chain-full-display` CSS library to a chain's
  full view.
- `LastChainLink` (`form_node_form_alter`): when adding a link, renders the previous link
  (`diboo_chain_link` view mode) above the form so the player sees only the prior step.
- `OpenChains` (`node_view`): on a room's full view, builds an "Open chains" pseudo-field listing
  each open chain with counts, last author/type/date, current contributor, and Draw/Describe
  action links to `diboo_core.add_chain_link`. Anonymous / users without
  `add chain links to chains` get a register/log-in prompt.
- `FinishedChains` (service, `node_view` + `views_query_alter`): on a room's full view, embeds the
  `diboo_finished_chains` view (display `embed`, argument = room id) and injects a join/filter so
  the view lists only that room's finished chains.
- `ManageDisplayReplacement` (`preprocess_node`): restores `content.uid` when the optional
  `manage_display` module is absent.
- `ViewsDataBundleFields` (`views_data`): exposes the code-defined bundle fields to Views via a
  local `EntityViewsData` subclass (workaround for core #2898635).

## Templates & assets

`templates/diboo-frontpage.html.twig`, `node--diboo-chain-link.html.twig`,
`node--diboo-open-chain.html.twig`; `css/chain-full-display.css` (library
`diboo_core/chain-full-display`). No JS ships in this module; the drawing widget comes from a
suggested module such as `diboo_signature_pad`.
