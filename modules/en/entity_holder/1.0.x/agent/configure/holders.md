<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# entity_holder — configuring holders

Manage at `/admin/structure/entity-holder` (permission: `administer entity holders`).

## A holder stores
- `path` — the persistent path/route the holder exposes.
- `title` — shown as fallback title when no held entity.
- `fallback_content` — formatted text shown when nothing is held.
- `held_entity_type` / `held_entity_bundle` — the target content type + bundle.
- `held_entity_uuid` — UUID of the bound content entity (the cross-environment key).

## Binding content
- **Create:** visit `/admin/structure/entity-holder/{holder}/create-entity/{uuid}` — builds the held entity's create form pre-filled with the holder title; on save the entity carries that UUID. If already held, redirects to its edit form.
- **Hold existing:** `/admin/structure/entity-holder/{holder}/hold-entity/{uuid}` loads the entity by UUID and binds it (`holdEntity()` enforces matching type + bundle).

## Rendering & access
`entityHolderView()` — if a held entity exists it renders that entity via an internal sub-request to its canonical URL (cache metadata merged from the held entity). Otherwise it shows `fallback_content`, offers a "create this content" link when the user can create it, or throws 404.
`EntityHolderAccess::checkAccess()` — view denied for disabled holders; otherwise delegates to the held entity's `access()`, or `access content` when nothing is held.

## Deployment pattern
Export holders with config sync; author the matching content per environment; the UUID keeps the holder's route resolving everywhere.
