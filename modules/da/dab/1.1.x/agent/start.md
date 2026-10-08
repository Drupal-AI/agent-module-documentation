<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Atomic Builder (dab) — agent index

In-admin workbench for **Single Directory Components (SDC)** following the Atomic Design pattern:
list, live-preview, scaffold, edit, duplicate and delete components. Developer/dev-only tool
(`package: Development`); maintainers advise against production use. Core `^10.3 || ^11`.

## Dependencies
- Drupal core module **`sdc`** (Single Directory Component) — component discovery via `plugin.manager.sdc`.
- Composer library **`league/commonmark:^2.4`** — Markdown rendering for the documentation tab.
- No config schema shipped; no Drush commands; no submodules. Ships two demo SDCs under `components/molecules/`.

## Provides
- **Permissions** (`dab.permissions.yml`, all `restrict access: true`): `access dab components`,
  `administer dab components`, `administer dab configuration`.
- **Routes** (`dab.routing.yml`) under `/admin/dab/components`: list, per-type list, component view,
  `embed`, `documentation`, `add`, `edit`, `duplicate`, `delete`, and `settings`.
- **Controllers**: `DabComponentListController` (list/filter), `DabComponentController` (view/embed/documentation).
- **Forms**: `AddComponentForm` (create/edit), `ConfirmationComponentForm` (delete/duplicate),
  `ConfigureComponentsTypesForm` (settings), `ComponentFilterForm` (AJAX filter), `CacheClearForm` (asset/Twig flush).
- **Services**: `dab.component_file_manager` (`ComponentFileManager` — scaffolds/moves/duplicates/deletes files),
  `dab.markdown_service` (`MarkdownService`), `dab.crud_component_access_check` (`CrudComponentAccessCheck`).
- **Access check**: `_crud_component_access_check` — blocks CRUD on core/contrib components (path regex).
- **Menu link deriver**: `AtomicComponentMenuLinkDeriver` — one nav/toolbar link tree per component.
- **Theme hooks** (`dab.module`): `dab_renderer`, `dab_component_list`; libraries `dab/global`, `dab/toolbar`.
- **Config object**: `dab.component_type.config` (keys `component_types`, `css_extension`) — no schema file.
- **Trait**: `DabComponentTrait` — shared component/version/provider lookup helpers.

## Solution docs
- [Component management: routes, controllers, forms, services & access](api/components.md)
- [Settings: component types & CSS extension config](config/settings.md)
