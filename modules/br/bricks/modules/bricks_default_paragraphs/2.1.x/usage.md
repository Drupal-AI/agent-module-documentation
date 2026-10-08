Bricks Default Paragraphs is a demo/starter submodule that installs a ready-made Bricks setup using Paragraphs: a `bricky_paragraphs` node type with a Bricks field plus `layout` and `wrapper` paragraph types, wired to Bricks widgets and the nested formatter.

---

The submodule ships only default config (`config/install/*.yml`) — no PHP. On enable it creates a `bricky_paragraphs` node type with a `field_body_paragraphs` Bricks field, `layout` and `wrapper` paragraph types, and the form/view displays that connect them so paragraphs can be nested via the Bricks tree UI and rendered recursively (`bricks_nested`). It depends on `bricks`, `bricks_inline`, `bricks_revisions`, `paragraphs`, and `paragraphs_demo` (plus core field/language/menu_ui/node/path/user), so it also pulls in the Paragraphs demo content model. It is a working example of Bricks + Paragraphs for developers to enable, explore, and adapt — not intended as production configuration.

---

- Get a working Bricks-with-Paragraphs example without hand-building config.
- See how paragraph types (`layout`, `wrapper`) nest inside a Bricks field.
- Use `bricky_paragraphs` as a starting point for a paragraph-based page builder.
- Explore the recommended Bricks widget/formatter wiring for paragraphs.
- Demonstrate a Layout-API `layout` paragraph nesting child paragraphs.
- Compare the paragraphs approach against `bricks_default_blocks`.
- Copy the shipped displays into a real paragraph content model.
- Bootstrap a demo/training site combining Bricks and Paragraphs.
- Learn how `bricks_revisions` applies to a revisioned paragraphs setup.
- Adapt the demo paragraph types into a production component set.
- See a correct `field_body_paragraphs` Bricks field configuration end to end.
- Understand how `layout` and `wrapper` paragraph types nest in a tree.
- Reference the shipped form/view displays when building your own.
- Verify your environment renders nested paragraph bricks correctly.
- Provide QA/testing fixtures for Bricks + Paragraphs.
- Teach editors the Bricks tree UI using familiar paragraph types.
- Prototype a paragraph-based landing page quickly.
- Explore the pulled-in Paragraphs demo content model alongside Bricks.

