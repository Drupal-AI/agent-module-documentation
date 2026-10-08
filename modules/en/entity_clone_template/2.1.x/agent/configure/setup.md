# Setup and usage

No settings page. Configuration is per content type; template flagging is per node.

## 1. Enable for a content type
- Edit the content type (e.g. `/admin/structure/types/manage/article`). Under the **Entity Clone
  Content** section, check **Enable Entity Clone Template**.
- Stored as node type third-party setting
  `entity_clone_template.entity_clone_template_active` (`hook_form_node_type_form_alter` +
  `..._form_builder`). The section is only visible to users with `administer entity_clone_template` or
  `administer nodes`.

## 2. Mark a node as a template
- On the node add/edit form of an enabled type, an **Entity Clone Template** section appears (only for the
  same permissions). Check **Allow content to be defined as a template** and optionally upload a preview
  image (managed_file at `public://entity-clone-template`, shown only when the checkbox is ticked).
- Persisted to the node base fields `entity_clone_template_active` (boolean) and
  `entity_clone_template_image` (image). The submit handler
  `entity_clone_template_entity_form_submit()` saves the file as permanent and attaches it; unchecking /
  removing clears the fields.

## 3. Clone from the template gallery
- Visit `/admin/content/clone-content-from-template` (also linked under the Content admin menu). This is
  the bundled View `entity_clone_template`, listing template-flagged nodes with their preview image
  (image style `entity_clone_template_preview`).
- Selecting a template runs the standard **Entity Clone** flow to create a new node.
- `EntityCloneTemplateSubscriber::postEntityClone()` (on `EntityCloneEvents::POST_CLONE`) resets
  `entity_clone_template_active = 0` and clears the image on the clone, so a copy is never itself a template.

## Uninstall note
When the feature is disabled for a type, the form handlers set the two base-field values to NULL, which
lets Drupal uninstall the module despite the base fields having had data.

Tip (from README): an optional core patch can redirect to the cloned node's edit page after cloning
(workflow convenience, not required).
