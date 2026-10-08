<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smallads — setup & operation

## Enable
Requires contrib `shs`, `chosen` and `taxonomy_entity_index` plus core block/comment/field/image/link/search/taxonomy/token/views. `contact` is enabled automatically via `hook_install`.

## What appears on enable
- Content entity `smallad` with bundle entity `smallad_type`.
- Vocabularies: `categories` (hierarchical, the primary classifier) and `smallads_types` (add terms like offers/wants/notices — extra terms activate tabs on the listing pages).
- Three views: all offers, all wants, per-user ads. **Note:** the views only track changes to the `smallads_types` vocabulary if the views themselves have not been hand-edited.
- Nested-categories navigation block + breadcrumb builder.

## Routes
| Route | Path | Access |
|-------|------|--------|
| smallads.settings | /admin/structure/smallads/settings | administer site configuration |
| entity.smallad_type.collection | /admin/structure/smallads | administer site configuration |
| entity.smallad_type.{add,edit,delete}_form | /admin/structure/smallads/... | administer site configuration |

## Permissions
- `post smallad` — create and manage own ads (give to members).
- `view smallad` — view ads.
- `edit all smallads` — moderate / prune / manage the catalogue.

## Scope & expiry
Each ad has a visibility scope and an expiry date; past expiry the ad reverts to *private* scope (owner + `edit all smallads` only). A queue worker (`ExpiredMail`) handles expiry notifications.

## Bulk actions
`DeleteSmallad` and `UnpublishSmallad` action plugins operate on selected ads.

## Submodules
- `smallads_group` — scope ads to Group entities.
- `smallads_mcapi` — mutual-credit / Community Accounting pricing.
- `smallads_murmurations` — publish ads to the Murmurations network.
