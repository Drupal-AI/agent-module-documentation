Config-only submodule of Entity Reference with Layout that installs a ready-made "Section" paragraph type (`erl_section`) to use as the layout-section container in an ERL field, so you don't have to build one by hand.

---

Enabling `erl_paragraphs` imports default configuration (`config/install`): a Paragraphs type
`erl_section` (`paragraphs.paragraphs_type.erl_section`) with its default form display and view
display, plus (as optional config) a `field_title` text field on that type
(`field.storage.paragraph.field_title` + `field.field.paragraph.erl_section.field_title`). It
depends on `entity_reference_layout` and ships no PHP, routes, permissions, or services — it is
purely a starter content-model. Point your ERL field's section paragraph at `erl_section` to
get going immediately; you can add more fields to the type afterwards.

---

- Get a working "Section" paragraph type without creating one manually.
- Use `erl_section` as the layout-section container for a Paragraph-with-Layout field.
- Start building ERL pages immediately after enabling the module.
- Give sections an optional title via the bundled `field_title` field.
- Provide a consistent section type across a team/site install profile.
- Include the default ERL section in a distribution or recipe.
- Serve as a reference example of how an ERL section type should be configured.
- Extend the shipped `erl_section` type with additional fields as needed.
- Pair with `erl_layouts` for ready-made layouts + a ready-made section type.
- Avoid config drift by starting from the maintainers' default section config.
- Speed up demos/prototypes of the ERL authoring experience.
- Remove the type later if you prefer a custom section paragraph.
- Keep the section's form/view displays preconfigured out of the box.
- Standardize the section machine name (`erl_section`) across environments.
- Reduce setup steps in the ERL "field setup" checklist.
