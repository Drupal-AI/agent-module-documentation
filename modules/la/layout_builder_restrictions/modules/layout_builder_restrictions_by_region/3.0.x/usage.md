Submodule of Layout Builder Restrictions that adds per-region granularity, letting you restrict which blocks are allowed in each individual region of each allowed layout.

---

Where the parent module restricts blocks and layouts per entity view mode, "By Region" narrows control to the region level. It provides a second restriction plugin, `entity_view_mode_restriction_by_region`, that you enable on the global Layout Builder Restrictions admin page. Once enabled, the per-view-mode configuration form gains a per-region interface (backed by `AllowedBlocksForm` and some JavaScript) where, for each region of each allowed layout, you whitelist or blacklist the blocks and block categories permitted there. This means, for example, a two-column layout can allow media blocks only in the sidebar and content fields only in the main region. Restrictions are stored as third-party settings alongside the parent module's, so they export with configuration. Enabling it after configuring the parent "Per Entity View Mode" restriction requires re-saving each entity's layout restrictions. It requires `layout_builder` and the parent `layout_builder_restrictions` module and has no permissions of its own.

---

- Allow media blocks only in a sidebar region.
- Keep content fields confined to a layout's main region.
- Permit inline blocks in one region but not another.
- Enforce a design where hero blocks only sit in a full-width region.
- Restrict which block categories appear in each region of a layout.
- Prevent editors from placing navigation blocks in a content column.
- Give different regions of the same layout different allowed block sets.
- Compose fine-grained page templates from region-scoped rules.
- Ensure ad/promo blocks only land in designated regions.
- Constrain a three-column layout so each column has a distinct purpose.
- Blacklist specific blocks from a particular region only.
- Whitelist a small block set for a delicate header region.
- Export per-region restrictions with your display configuration.
- Layer region rules on top of the parent per-view-mode restrictions.
- Build governed, reusable layout patterns for a component library.
- Stop editors from breaking responsive layouts by misplacing wide blocks.
- Reserve a footer region for approved footer blocks only.
- Provide stricter control for landing-page layouts than for articles.
- Keep sidebars limited to secondary content components.
- Combine with the parent plugin's weighted precedence for layered rules.
