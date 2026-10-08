Breakpoint Field adds a Field API field type that lets editors pick one breakpoint from a site-builder-chosen breakpoint group.

---

Breakpoint Field ships a single field type (`breakpoint_field_item`) plus its default widget (`breakpoint_field_widget`) and formatter (`breakpoint_field_formatter`). A site builder attaches the field to any fieldable entity via Field UI, then in Manage form display configures the widget with one breakpoint group (any group registered through `*.breakpoints.yml` — themes, core, or the Breakpoint module — as returned by the `breakpoint.manager` service). At content-entry time the widget renders a single-select listing every breakpoint in that group, labelled with its multiplier, human label, and media query; the field stores the chosen breakpoint machine id (a tiny text column). The default formatter renders a simple `<p>The breakpoint is <id></p>` line. The module has no routes, no permissions, no settings page, and no config-install objects — all behaviour is driven by the field/widget/formatter plugins and the core breakpoint system.

---

- Add a "pick a breakpoint" field to a content type, media type, taxonomy term, or any fieldable entity.
- Let editors choose which responsive breakpoint a piece of content should target.
- Store a breakpoint machine name (e.g. `bartik.wide`) as structured field data instead of free text.
- Constrain the choices to a single, curated breakpoint group per field via the widget setting.
- Surface a theme's `*.breakpoints.yml` definitions to editors as a friendly select list.
- Expose each breakpoint's media query and multiplier in the option label so editors pick knowingly.
- Drive custom rendering logic (in a preprocess hook or Twig) off the stored breakpoint id.
- Feed a stored breakpoint into a responsive-image / picture build in a custom template.
- Tag content with the viewport size it was authored for.
- Build editorial workflows where a breakpoint selection gates layout decisions.
- Provide a reusable breakpoint picker without writing a custom field type.
- Reuse the same field across multiple bundles, each pointing at a different breakpoint group.
- Let a decoupled/JSON:API consumer read the selected breakpoint id from the field's `value`.
- Prototype responsive behaviour by capturing breakpoint choices per node.
- Replace an ad-hoc text or list field that previously held breakpoint keys as plain strings.
- Give site builders a Field-UI-native way to reference breakpoints without custom code.
- Override the default formatter in a theme to emit `<picture>`/`srcset` markup from the stored id.
- Combine with Views to filter or group content by the chosen breakpoint value.
- Keep breakpoint choices in sync with the active theme by pointing the widget at the theme's group.
- Document, per entity, which breakpoint a designer intended for a hero image or block.
