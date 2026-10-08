<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: trusted_redirect_entity_edit

Optional. Independent of the main module's redirect behaviour — it does **not** allowlist hosts.
Its purpose is a **UUID-addressable entity edit route** so the same edit URL works across synced
Drupal instances (satellite sites) where numeric entity ids differ but UUIDs match.

## Route
`trusted_redirect_entity_edit.routing.yml`:
- Path: **`/entity/{uuid}/edit`**
- Controller: `EntityEditController::resolveEntityEditUrl`
- Permission: **`use entity uuid routes`**

## How it resolves (`src/Service/EntityEditUrlResolver.php`)
`resolveEditUrlByUuid($uuid)` iterates **content** entity type definitions
(`instanceof ContentEntityType`); for each it:
1. checks a canonical edit route exists — `entity.{entity_type}.edit_form` with exactly one route
   parameter whose name equals the entity type;
2. tries `entityRepository->loadEntityByUuid($entity_type, $uuid)`.

The first entity type that both has such a route and yields an entity for that UUID wins, and the
service returns `Url::fromRoute('entity.{type}.edit_form', [{type} => $entity->id()])`. If nothing
matches it throws `NotFoundHttpException`.

## Controller (`src/Controller/EntityEditController.php`)
Builds the internal edit URL, copies the incoming query string onto it
(`parse_str($request->getQueryString(), $query)`), and returns a plain `RedirectResponse` to that
internal path. A missing/unresolvable UUID → 404.

## Keeping the redirect internal (`src/EventSubscriber/TrustedRedirectEntityEditSubscriber.php`)
A `KernelEvents::RESPONSE` subscriber at **priority 1001** (ahead of the main module's priority-1
subscriber and core's `RedirectResponseSubscriber`). When the current route is
`trusted_redirect_entity_edit.edit.controller` and the response is a `RedirectResponse`, it calls
`stopPropagation()`. This deliberately prevents the copied `?destination=` query param — or the
main module's external-redirect logic — from re-pointing this particular redirect: it must stay
within the current origin, since it is just an alternate address for the entity's own edit form.

## Access / security notes
- The redirect target is always an **internal** `entity.*.edit_form` route; the browser then hits
  that route, which enforces its **own** edit-access check. The submodule does not grant edit
  access — it only resolves a URL. A user without edit access to the target entity is still blocked
  by the edit form's access control.
- `use entity uuid routes` gates the resolver itself. Because the resolver returns 404 for unknown
  UUIDs and a redirect for known ones, a holder of that permission can use it as a UUID
  existence oracle across content entity types; UUIDs are unguessable, so impact is negligible.
