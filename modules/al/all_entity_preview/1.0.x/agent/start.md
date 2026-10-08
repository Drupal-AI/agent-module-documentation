<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preview (all_entity_preview) — agent index

Adds core's node-style **Preview** button to any content entity type/bundle you enable, so an editor
can render the *unsaved* entity in a chosen view mode before saving and switch view modes on the
preview page. The pending edit is held in a private tempstore and rendered by a dedicated route.
Module + PHP namespace machine name is **`preview`**; the drupal.org project is `all_entity_preview`.

- Core `^10.1 || ^11 || ^12`, no module dependencies.
- Settings page: `/admin/config/content/preview` — route `preview.settings`, permission *administer site configuration*.
- No permissions of its own, no Drush commands, no plugin types. Ships config schema.

- **Enable preview per entity type/bundle, pick the default view mode, config structure, set via drush/PHP** → [configure/settings.md](configure/settings.md)
- **The preview route/controller, the `preview.storage` service, the param converter + access check, and the form_alter/page_top runtime flow** → [api/preview.md](api/preview.md)
- **Override the "Back to editing" link from another module** → [events/back-link.md](events/back-link.md)

Key facts:
- Config object `preview.settings`, single key `enabled` shaped `enabled[entity_type_id][bundle_id] = view_mode_id`. `node` is excluded (core already previews it). Default install: empty (`enabled: {}`).
- Preview route `preview.entity_preview` → `/preview/{entity_preview}/{view_mode_id}`, `_controller: \Drupal\preview\Controller\PreviewController::view`, guarded by access check `_entity_preview_access`.
- Services: `preview.storage` (`Drupal\preview\PreviewStorageInterface`), `access_check.entity.preview` (`Drupal\preview\Access\EntityPreviewAccessCheck`), `entity_preview` (paramconverter `Drupal\preview\ParamConverter\PreviewConverter`), and hook service `Drupal\preview\Hook\PreviewHooks`.
- Pending previews live in the **private** tempstore collection `entity_preview` (`PreviewStorageInterface::TEMPSTORE_NAME`), keyed by the entity UUID, storing the whole `FormStateInterface`.
- Event `preview.back_link` (`PreviewEvents::PREVIEW_BACK_LINK`) dispatches `Drupal\preview\Event\PreviewBackLink`.
- Implements `hook_form_alter` (adds the Preview button to enabled entity forms), `hook_page_top` (view-mode switcher + back link on the preview page), `hook_help`. Update hook `preview_update_10001` migrates old config into the `enabled` mapping.
