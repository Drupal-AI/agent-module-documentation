Layout Builder Styles lets site builders define reusable sets of CSS classes and expose them as selectable "styles" on blocks and sections in the Layout Builder UI, so editors can restyle layouts without writing code.

---

The module adds two config entities — **styles** (`layout_builder_styles.style.*`) and **style groups** (`layout_builder_styles.group.*`) — managed at `/admin/config/content/layout_builder_style`. Each style maps a human-readable label to one or more CSS classes and targets either blocks or layout sections; you can restrict a style so it only appears for specific block plugins or specific layouts. Style groups bundle related styles and control how they are presented to editors: as a single-select or multi-select, using radios/checkboxes or a dropdown, and whether a selection is required. When an editor adds or configures a block or section in Layout Builder, the module injects the relevant style selectors into the configuration form (via `hook_form_alter`); the chosen classes are then attached to the rendered output through a render-array event subscriber and a `preprocess_layout` hook, and matching theme hook suggestions are added so themers can template styled blocks. Because styles are configuration, they are exportable and deployable across environments. This is the standard way to give a design system's utility classes (spacing, background colors, alignment, component variants) a friendly UI inside Layout Builder while keeping markup control in the theme.

---

- Let editors pick a background color for a block from a dropdown of predefined styles.
- Offer spacing/padding utility classes as selectable block styles.
- Add alignment options (left/center/right) to Layout Builder sections.
- Expose a design system's component variants (e.g. "Card — bordered") as styles.
- Apply a "full width" or "boxed" class to a layout section.
- Restrict a style so it only shows on specific block types.
- Restrict a style so it only appears for a particular layout plugin.
- Group related styles (e.g. all "Color" options) under one labeled selector.
- Require editors to choose a style for certain sections before saving.
- Allow multiple styles to be applied to one block at once (multi-select).
- Present styles as radio buttons, checkboxes, or a select dropdown.
- Give non-technical editors safe, curated styling choices without custom CSS per block.
- Keep all styling classes in configuration so they deploy between environments.
- Add theme hook suggestions to template blocks based on their applied style.
- Provide reusable BEM/utility classes to Layout Builder without theme edits per node.
- Standardize component styling across many landing pages built with Layout Builder.
- Let a marketing team toggle between brand color themes on hero sections.
- Add responsive visibility or column-count helper classes to sections.
- Offer "emphasis" or "muted" text treatments as block styles.
- Enforce brand-consistent styling by limiting editors to an approved style list.
- Reduce one-off inline CSS by centralizing options as configurable styles.
- Combine several utility classes into a single named style for editor convenience.
- Order how styles appear to editors using per-style weight.
- Support decoupled/component front ends by attaching predictable classes to blocks.
