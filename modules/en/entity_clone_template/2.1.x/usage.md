Extends the Entity Clone module so editors can mark nodes as reusable "content templates" (with a preview image) and start new content by cloning a template chosen from a Views-powered gallery page.

---

Entity Clone Template builds on top of `entity_clone`. Per content type, an admin turns the feature on via an "Enable Entity Clone Template" checkbox on the content-type form (stored as the `entity_clone_template` third-party setting `entity_clone_template_active`). Once enabled for a type, its node edit form gains an **Entity Clone Template** section where an editor can flag the node as a template and upload a preview image — backed by two base fields the module adds to all nodes: `entity_clone_template_active` (boolean) and `entity_clone_template_image` (image). A bundled View (`views.view.entity_clone_template`) lists all template-flagged nodes with their preview images at `/admin/content/clone-content-from-template` (also under the Content admin menu), using the image style `entity_clone_template_preview`. Choosing a template hands off to Entity Clone's normal clone flow to create a new node. An event subscriber on `EntityCloneEvents::POST_CLONE` resets `entity_clone_template_active`/`entity_clone_template_image` to empty on the freshly cloned copy, so clones don't themselves become templates. The template checkbox/image controls are gated behind `administer entity_clone_template` or core `administer nodes`. The module has no settings page; enabling/disabling is per content type, and disabling cleanly nulls the fields so the module can be uninstalled.

---

- Let editors start a new page from a pre-built content template.
- Maintain a gallery of reusable node templates with preview thumbnails.
- Mark specific nodes as "templates" without a separate content type.
- Give a landing-page team starter layouts to clone and edit.
- Provide branded document/article skeletons for consistent structure.
- Show a visual "pick a template" screen at `/admin/content/clone-content-from-template`.
- Enable templating only for the content types that need it.
- Attach a representative preview image to each template.
- Ensure a cloned node is not accidentally treated as a template (auto-reset on clone).
- Speed up repetitive content creation (events, products, case studies).
- Offer multiple design variants as clonable templates.
- Keep templates as normal nodes (revisionable, translatable, permission-controlled).
- Curate an editorial "template library" managed in the standard content list.
- Bootstrap microsites from a canonical template node.
- Standardize paragraph/layout structures by cloning from a template.
- Let admins toggle the feature per type from the content-type form.
- Restrict who can define templates via `administer entity_clone_template`.
- Reuse the built-in preview image style, or customize it.
- Combine with Entity Clone's cloning of references/children.
- Cleanly uninstall by disabling on all types (fields null out).
