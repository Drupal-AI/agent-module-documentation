Fallback Formatter adds a single field formatter, "Fallback", that runs a configurable, ordered list of other formatters and, per field delta, uses the output of the first one that produces a result.

---

The module registers one `@FieldFormatter` plugin, `fallback` (`FallbackFormatter`), and a
`hook_field_formatter_info_alter` that makes it available only for field types that already have **two or
more** formatters. On *Manage display* you choose "Fallback" as a field's formatter, then in its settings
enable one or more of the field type's other formatters, order them with a tabledrag weight table, and
configure each enabled sub-formatter's own settings (their settings forms are embedded). At render time
`viewElements()` iterates the enabled formatters in weight order, running each through core's normal
`prepareView()`/`viewElements()`; for each field item (delta) the first formatter that returns visible
output wins, and remaining deltas keep falling through to later formatters until all items are rendered or
the list is exhausted. Settings persist in the field's display config under
`field.formatter.settings.fallback` as a `formatters` sequence (each with `status`, `weight`, `formatter`
id and nested `settings`). The Fallback formatter cannot target itself, and a
`hook_entity_embed_display_plugins_alter` also prevents it from being used as an Entity Embed display
plugin. There is no admin settings page or permission — it is purely a per-field display option.

---

- Show a computed/preferred formatter but fall back to a plain formatter when it yields nothing.
- Render an image field via one formatter and fall back to a URL/text formatter for empty deltas.
- Chain multiple date formatters and use whichever produces output first.
- Display a link field with a "link" formatter, falling back to raw text if the link is malformed.
- Provide graceful degradation for custom field types with several partial formatters.
- Order candidate formatters with a drag-and-drop weight table on Manage display.
- Configure each candidate formatter's own settings inside the fallback settings form.
- Combine a media/entity-reference rendered view with a label fallback.
- Handle mixed-content fields where different deltas need different formatters.
- Avoid empty output by guaranteeing a last-resort formatter at the bottom of the list.
- Use per-delta fallback so item 1 uses formatter A while item 2 falls through to formatter B.
- Limit the Fallback option to field types that genuinely have multiple formatters (automatic).
- Keep existing formatter modules unchanged while layering fallback behaviour on top.
- Build resilient displays for imported/migrated data with inconsistent field values.
- Provide a "rich, else simple" rendering strategy for teaser vs full view modes.
- Prevent Fallback from being (mis)used as an Entity Embed display plugin (blocked by design).
- Configure fallback separately per view mode (default, teaser, etc.).
- Show a formatted phone/number via a specialised formatter, else the plain value.
- Render a taxonomy/entity reference with a preferred formatter and a label fallback.
- Ensure accessibility by always emitting some output for non-empty field items.
