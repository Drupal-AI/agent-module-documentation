Layout Builder Component Attributes lets editors add HTML attributes (ID, class, style, and data-* attributes) to Layout Builder components (blocks), targeting the block wrapper, the block title, or the block content element.

---

When a block is placed into a Layout Builder section it becomes a Layout Builder component. This module adds a **Manage attributes** contextual link (inserted right after **Configure**) on each component, opening an off-canvas form where editors set an ID, class(es), inline style, and data-* attributes. Attributes are organized into three groups that map to distinct parts of the rendered block: **Block attributes** (the outer wrapper element), **Block title attributes** (the title element), and **Block content attributes** (the inner content element). A global settings form at `/admin/config/content/layout-builder-component-attributes` controls which of the four attribute types (id, class, style, data) are allowed per group; if a group has no allowed attributes it is hidden from the editor form, and if an attribute is disallowed later it stops rendering. Entered values are validated (IDs and classes must be valid CSS identifiers; data-* names must start with `data-`) and stored on the component's `component_attributes` setting in the layout. At render time an event subscriber copies those settings onto the block build, and a `template_preprocess_block` hook merges them into the block's `attributes`, `title_attributes`, and `content_attributes` Twig variables. Content-element attributes only render if the active theme's `block.html.twig` outputs `content_attributes`. Two permissions gate the feature: one for the global settings, one for editors managing attributes on components. The module depends only on core Layout Builder.

---

- Add a unique HTML `id` to a Layout Builder block wrapper so it can be an anchor/jump-link target.
- Apply one or more CSS classes to a specific block placed in a layout.
- Add a utility/framework class (e.g. a spacing or color class) to a single component without a template change.
- Set an inline `style` on a block wrapper for a one-off visual tweak.
- Add `data-*` attributes to a block for JavaScript behaviors to hook onto.
- Add `data-*` attributes to a block for CSS attribute-selector styling.
- Attach attributes to the block title element separately from the wrapper.
- Attach attributes to the block content (inner) element separately from the wrapper.
- Give a block title its own `id` to link directly to that heading.
- Add a class to only the title of a block (e.g. a visually-hidden heading class).
- Restrict editors to classes only (disallow id/style/data) via global settings for governance.
- Disallow inline styles site-wide to enforce a class-based styling policy.
- Allow data-* attributes on wrappers only, not on titles or content, per group settings.
- Hide an entire attribute group from the editor form by disallowing all its attributes.
- Let editors tag blocks with analytics/tracking `data-*` hooks in a layout.
- Add multiple space-separated classes to a component in one field.
- Enter several data-* attributes, one per line, with optional `name|value` pairs.
- Add a data-* attribute with no value (boolean-style attribute) to a block.
- Grant only trusted editors the ability to manage component attributes via permission.
- Keep global attribute policy in configuration so it deploys across environments.
- Target a single Layout Builder block with custom styling without writing a new block template.
- Add scroll-spy or in-page navigation IDs to section blocks laid out with Layout Builder.
- Give a hero or callout block a distinguishing class used by the theme's CSS.
- Ensure content-element attributes render by using a theme whose `block.html.twig` prints `content_attributes`.
- Progressively enhance a block with JS by attaching a `data-` config attribute editors can set.
