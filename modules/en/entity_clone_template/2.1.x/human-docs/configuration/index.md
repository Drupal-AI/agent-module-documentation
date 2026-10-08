# Configuration

Entity Clone Template has **no settings page**. It is configured per content type
(turn the feature on) and per node (mark a node as a template). Both steps are gated
by the **Administer entity_clone_template** permission (core's **Administer nodes**
permission also grants access).

## 1. Enable the feature for a content type

1. Edit the content type, e.g. **Structure → Content types → Article → Edit**
   (`/admin/structure/types/manage/article`).
2. Under the **Entity Clone Content** section, tick **Enable Entity Clone Template**.
3. Save the content type.

This section is only visible to users with **Administer entity_clone_template** or
**Administer nodes**.

## 2. Mark a node as a template

Once a type is enabled, its node add/edit form gains an **Entity Clone Template**
section (visible to the same users):

1. Add or edit a node of the enabled type.
2. Tick **Allow content to be defined as a template**.
3. Optionally upload a **preview image** — the upload field appears once the checkbox
   is ticked. This image is shown in the gallery to help editors recognise the
   template.
4. Save. The node is now a template. Unticking the box (or removing the image) clears
   those values again.

## 3. Clone from the template gallery

1. Go to **Content → Clone content from template**
   (`/admin/content/clone-content-from-template`). This is a bundled View listing
   every template‑flagged node together with its preview image.
2. Select a template. The standard **Entity Clone** flow runs and creates a new node
   copied from the template.
3. Edit and save the new node as normal.

The module automatically resets the template flag and clears the preview image on the
freshly cloned node, so a copy is never itself treated as a template.

## Permission

- **Administer entity_clone_template** — controls who can enable the feature on a
  content type and who sees the template flag/image controls on the node form. Core's
  **Administer nodes** is treated as equivalent.

Note that **actually cloning** content is governed by the underlying **Entity Clone**
module's own permissions (the `clone <entity type> entity` permissions) plus normal
node create/edit access — this module only governs who may *define* templates. Grant
**Administer entity_clone_template** to editors who should curate the template library
without giving them full node administration.

> **Optional tip (from the project README):** a small core patch can make Drupal
> redirect to the cloned node's edit page after cloning, which is a nice workflow
> convenience but is not required.
