Bricks Default Blocks is a demo/starter submodule that installs a ready-made Bricks setup using core custom blocks: a `bricky_blocks` node type with a Bricks field, plus `image`, `layout`, and `wrapper` custom block types, wired to the inline widget and nested formatter.

---

The submodule ships only default config (`config/install/*.yml`) — no PHP. On enable it creates: a `bricky_blocks` node type carrying a `field_body_blocks` Bricks field; three `block_content` bundles — `image` (with a `field_image` image field), `layout`, and `wrapper`; and the matching form/view displays so the node's Bricks field uses the `bricks_inline` (Inline Entity Form) widget and the `bricks_nested` formatter to render nested blocks. It is intended as a working example of Bricks + core custom blocks that a developer can enable, explore, and adapt (or copy config from). It depends on `bricks`, `bricks_inline`, `block_content`, `layout_discovery`, and several core modules, plus the Bartik theme. Not meant for production as-is — it exists to demonstrate the pattern.

---

- Get a working Bricks-with-custom-blocks example without building config by hand.
- Explore how a Bricks field is wired to the inline widget and nested formatter.
- See how a `layout` block bundle integrates with the Layout API in Bricks.
- Use the `bricky_blocks` node type as a starting point for a page builder.
- Copy the shipped form/view display config into your own content type.
- Demonstrate nested image/wrapper/layout blocks to stakeholders.
- Learn the recommended field settings for a Bricks-of-blocks setup.
- Bootstrap a demo site or training environment for Bricks.
- Compare the blocks-based approach against the paragraphs-based `bricks_default_paragraphs`.
- Adapt the `image`/`wrapper`/`layout` block types for a real component library.
- See a correct `field_body_blocks` Bricks field configuration end to end.
- Understand how the `image` block bundle wires a `field_image` image field.
- Use the `wrapper` block type as a container component pattern.
- Reference the shipped entity form/view displays when building your own.
- Verify your environment renders nested bricks correctly before custom work.
- Provide QA/testing fixtures for Bricks + custom blocks.
- Teach editors the drag-and-drop tree UI with real example content types.
- Prototype a landing page from image/wrapper/layout blocks quickly.

