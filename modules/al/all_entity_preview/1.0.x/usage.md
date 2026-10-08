<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Preview (project all_entity_preview) extends Drupal core's node-only live preview to any content entity type and bundle you enable, adding a "Preview" button to their edit forms so an editor can render the unsaved entity in a chosen view mode before saving.

---

Core gives nodes a Preview button; most other content entity types get nothing, so an editor working on a taxonomy term, a media item, a block content entity or a custom entity has to save first to see how it renders. This module reuses core's node-preview code generically: on `/admin/config/content/preview` (permission "administer site configuration") you tick the entity types and bundles that should support preview and pick a default view mode for each. A matching Preview button then appears on those edit forms. Clicking it stashes the current, unsaved form state in a per-user private tempstore and redirects to `/preview/{uuid}/{view_mode}`, where the entity is rendered through the normal entity view builder. A small view-mode switcher at the top of the preview page lets the editor flip between view modes, and a "Back to editing" link returns them to the form (other modules can redirect that link via the `preview.back_link` event).

The module's machine name is `preview` even though the project is `all_entity_preview`, which matters when enabling it or reading its `preview.settings` config. Access to a preview is gated by the entity's own create/update access, so it shows a render of something the editor is already allowed to edit; there is no permission of its own. Integrators can reach pending previews through the `preview.storage` service (`PreviewStorageInterface`). Note the maintainer's caveat that returning from a preview does not always re-populate form values perfectly.

---

- Preview a taxonomy term before saving.
- Preview a media item before saving.
- Preview a block content entity before saving.
- Preview a custom content entity before saving.
- Add a Preview button to a non-node edit form.
- Choose which view mode a bundle previews in.
- Switch view modes on the preview page.
- See a teaser render before committing an entity.
- See a full render before publishing.
- Enable preview per entity type and bundle.
- Turn off preview for a specific bundle.
- Reduce save-and-fix editing cycles.
- Check how an entity looks before a workflow transition.
- Preview an unsaved entity's current form values.
- Configure preview defaults at /admin/config/content/preview.
- Extend core preview beyond nodes.
- Give editors non-node live preview.
- Override the "Back to editing" link from another module.
- Read a pending preview entity via the preview.storage service.
- Set enabled bundles/view modes via drush or PHP config.
- Preview a paragraph-heavy or reference-heavy entity's display.
- Verify a view mode's field layout before saving.
- Support editors who work across many entity types.
- Preview a new entity you are creating for the first time.
- Confirm the right view modes exist before enabling a bundle.
