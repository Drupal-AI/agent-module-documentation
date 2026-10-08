<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Expand link formatter

On the entity's **Manage display** tab, set a `text_long` or `text_with_summary` field's format to
**Expand link formatter**, then open the gear to configure:

| Setting | Default | Meaning |
|---------|---------|---------|
| Separator | `<hr>` | Marker in the body text where the fold happens; text after it becomes expandable. |
| Expand link label | `Read more` | Link text shown to reveal the hidden part (run through `Xss::filter`). |
| Collapse link label | `Read Less` | Link text shown to hide it again. |
| Maximum characters before trimming | `0` | If > 0 **and** no separator is found, text is auto-trimmed at a word boundary and the rest becomes expandable. `0` disables auto-trim. |

Behaviour:
- If the body contains the separator → split there.
- Else if `maxlength > 0` and text length ≥ maxlength → trim via Views `trimText`.
- Else → render the whole field as plain processed text (no expand link).

Both parts render as `#type => processed_text` with the field's text format. The expand/collapse
interaction is provided by the attached `expand_link_formatter/expand` JS library. **Views must be
enabled** for the auto-trim path (it calls `FieldPluginBase::trimText`).
