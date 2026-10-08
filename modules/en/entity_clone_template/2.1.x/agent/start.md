# Entity Clone Template — agent index

Adds "content templates" on top of the `entity_clone` module: mark nodes as templates (with a preview
image) and clone new content from a Views gallery. Depends on `entity_clone`, `views`, `image`. No
settings page (`configure` null).

- **Enable per content type, mark a node as a template, the gallery View, the reset-on-clone behavior** →
  [configure/setup.md](configure/setup.md)
- **Permission (`administer entity_clone_template`) and what it gates** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Per-type toggle: node type third-party setting `entity_clone_template.entity_clone_template_active`
  (config schema `node.type.*.third_party.entity_clone_template`), set on the content-type form.
- Node base fields added for ALL nodes (`hook_entity_base_field_info`): `entity_clone_template_active`
  (boolean), `entity_clone_template_image` (image).
- Gallery: View `entity_clone_template` at `/admin/content/clone-content-from-template`; image style
  `entity_clone_template_preview` (both in `config/install`).
- `EntityCloneTemplateSubscriber` listens on `EntityCloneEvents::POST_CLONE` and zeroes the template
  flag/image on the clone.
- Node form controls appear only for `administer entity_clone_template` or `administer nodes`.
