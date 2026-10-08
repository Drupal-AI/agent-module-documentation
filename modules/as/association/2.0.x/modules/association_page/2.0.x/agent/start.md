<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Association Landing Page (association_page) — agent index

Submodule of **[Entity Association](../../../../2.0.x/agent/start.md)** (depends on `association`,
`toolshed`). Adds the revisionable `association_page` landing-page entity + the matching landing-page
handler plugin. Version 2.0.0-alpha9, core `^10.2 || ^11`.

## What it provides (from source)

- **Entity** `association_page` (`src/Entity/AssociationPage.php`) — content entity, fieldable,
  **revisionable** (`show_revision_ui`), translatable, publishable, owned; bundle = `association_type`.
  Shares its **ID with the parent association** (`getAssociation()` loads `association` by same id).
  Base fields: `uid`, `title` (label), `status`, `created`, `changed`, revision-translation-affected.
  `preSave` defaults owner to anon and revision user to owner; `preSaveRevision` preserves the prior
  revision log when blank.
- **Landing-page plugin** `association_page` (`src/Plugin/Association/LandingPage/AssociationPage.php`,
  `@AssociationLandingPage`, implements `RevisionablePagePluginInterface`): `onCreate()` creates the
  page (id/title/type from the association), `onPreDelete()` deletes pages, `getPageUrl()` returns the
  page canonical URL (or `<nolink>`). Config `new_revision` (bool).
- **Access** `PageAccessControlHandler` (`src/Entity/Access/`): create = forbidden (auto-provisioned);
  `view` allowed when the association is **active**, else needs `page_update`; `update` needs
  `page_update`; revision ops need `page_revisions`; `delete` forbidden (only via association delete).
  Admin key bypasses. Per-type page permissions from `AssociationPagePermissions` (extends
  `AssociationPermissions`): `page_update` ("Edit landing page for") and `page_revisions`.
- **Routes**: canonical `/association/{association_page}` (`_entity_access: association_page.view`) plus
  revision history/view/revert/delete (`AssociationPageHtmlRouteProvider` +
  `Controller/AssociationPageController`). Field-config base route
  `/admin/structure/association/{association_type}/page` (`_access: FALSE`, reached via enhancer).
  `AssociationPageConfigAccess` (`_association_page_config`) allows page-config routes only when the
  type actually uses this plugin.
- **Routing glue**: `Routing/AssociationPageEnhancer` (route_enhancer) + `AssociationPageRouteSubscriber`
  (event_subscriber); `association_page.module` moves Field UI / form / display / Layout-Builder local
  tasks onto the association type admin and wires admin_toolbar links.
- **Config schema**: `config/schema/association_page.schema.yml`
  (`association.landing_page.association_page` → `new_revision`). Optional
  `core.entity_view_mode.association_page.full`.

## Solution docs

- The page entity, its lifecycle with the association, access & revisions → [entity/landing-page.md](entity/landing-page.md)
