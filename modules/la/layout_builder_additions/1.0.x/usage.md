Small UX-improvement module for core Layout Builder: it gives inline-block add/configure forms a meaningful title ("Configure block: <type>"), tidies the media block form, and adds a "Layout" operation link to nodes on content admin listings. It has no configuration.

---

Layout Builder Additions makes three targeted changes to the core Layout Builder experience, all in code with zero settings. (1) A route subscriber (`RouteSubscriber`) replaces the static titles of the `layout_builder.add_block` and `layout_builder.update_block` routes with title callbacks (`LayoutBuilderBlockFormTitle::addBlock` / `::updateBlock`) that resolve the block's admin label or block-content bundle label, so the form heading reads e.g. "Configure block: Accordion" instead of a generic "Configure block". (2) `hook_form_alter()` hides the redundant "Administrative label" field on add/update block forms, and for `media`-bundle inline blocks moves the label and view-mode selector to the top and relabels view mode as "Image size". (3) `hook_entity_operation()` adds a **Layout** operation link to nodes (for layout-overridable content types) on admin listings, but only when the current user passes access to the `layout_builder.overrides.node.view` route — so it respects Layout Builder's own permissions. There are no permissions, config entities, schema, services (beyond the route subscriber), or Drush commands. It pairs well with Layout Builder Modal. When uninstalled, the module simply stops applying these changes.

---

- Show a descriptive "Configure block: <Block type>" heading when adding an inline block in Layout Builder.
- Show the block type/label in the heading when editing an existing inline block.
- Hide the redundant "Administrative label" field on Layout Builder block forms.
- Reorder the media inline-block form so the label appears first.
- Relabel the media block "View mode" selector as "Image size" for editors.
- Add a quick "Layout" action link to nodes on the content admin screen.
- Save editors clicks when jumping straight to a node's layout override.
- Respect Layout Builder override permissions when showing the Layout operation (uses route access).
- Improve the inline-block authoring UX without writing any custom code.
- Provide clearer block-form headings on sites with many inline block types.
- Combine with Layout Builder Modal for add/configure-in-a-modal workflows.
- Apply consistently to all layout-enabled content types automatically.
- Reduce confusion from generic "Configure block" titles on complex layouts.
- Streamline media/image block placement in layouts.
- Use as a drop-in enhancement (enable and it just works; disable to revert).
