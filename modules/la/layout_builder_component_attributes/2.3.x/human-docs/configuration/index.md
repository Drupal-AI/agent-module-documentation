# Configuration

There are two sides to this module: a **global policy** set by an administrator
(which attribute types are allowed), and the **per‑block form** editors use to
actually add attributes.

## Global settings — what's allowed

Go to **Configuration → Content authoring → Layout Builder Component Attributes**
(`/admin/config/content/layout-builder-component-attributes`); you need the
*Administer layout builder component attributes* permission.

The form controls which of the four attribute types — **ID**, **Class**, **Style**
and **Data-\*** — editors may set on each of three parts of a block:

- **Block attributes** — the outer wrapper element of the block.
- **Block title attributes** — the block's title element.
- **Block content attributes** — the inner content element.

Every type in every group is allowed by default. Untick the ones you want to
forbid. This is how you enforce a styling policy — for example, allow only classes
and disallow inline styles site‑wide, or permit data attributes on wrappers but not
on titles or content.

Two behaviours are worth knowing:

- If you disallow **all** four types in a group, that whole group disappears from the
  editor's Manage attributes form.
- If an attribute was previously used and you later disallow it, the values that were
  already entered simply stop rendering (they are not deleted).

Click **Save configuration** to apply. These settings live in the
`layout_builder_component_attributes.settings` configuration object, so they export
and deploy between environments with `drush config:export` / `config:import`.

## Per‑component — the Manage attributes form

Editors with the *Manage layout builder component attributes* permission add
attributes while editing a layout:

1. Edit a layout that uses Layout Builder.
2. Open a block's contextual menu and click **Manage attributes** (it sits just after
   *Configure*). An off‑canvas form opens.
3. The form shows a section for each allowed group (Block, Block title, Block
   content), each with the fields that are allowed globally:
   - **ID** — a single HTML id; must be a valid CSS identifier.
   - **Class(es)** — one or more classes separated by spaces; each must be a valid CSS
     class name.
   - **Style** — inline CSS for a one‑off visual tweak.
   - **Data-\* attributes** — one per line, written as `name|value` (the value is
     optional). Each name must begin with `data-`. For example
     `data-test|example-value`, or just `data-flag` for a value‑less (boolean)
     attribute.
4. Save. The values are stored on the component within the layout itself (there is no
   separate config entity per block), and take effect when the layout is saved.

## A note on the content group and your theme

Wrapper (**Block**) and title (**Block title**) attributes render with the standard
block template. **Block content** attributes, however, only appear if your active
theme's `block.html.twig` outputs `content_attributes` on the inner element. Many
core themes do not print `content_attributes`, in which case content‑group
attributes are silently dropped while wrapper and title attributes still work. If
you need content attributes, make sure your theme's `block.html.twig` renders
`content_attributes` on the content element.
