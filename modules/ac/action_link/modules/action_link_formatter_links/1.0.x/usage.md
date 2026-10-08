Action Link Formatter Links outputs action links inside a field's own formatter, for example placing decrease/increase links on either side of the field value.

---

This Action Link submodule lets action links that control an entity field be rendered within that field's formatter, configured through the formatter's third-party settings on Manage Display. A checkboxes element (added by `hook_field_formatter_third_party_settings_form()`) lists the action links that target the field; the selected links are injected into the rendered field by `hook_entity_display_build_alter()`. When an action link has exactly two directions (e.g. increment / decrement), one link is placed before the value and one after; otherwise the whole link set is placed after the value. For the AJAX link style the module swaps in its own `ajax_entity_field` style, which on a successful action returns the entire rendered field — across all relevant view modes — as AJAX replacements, so the visible field value updates along with the links. Showing action links on fields rendered in Views additionally needs a core patch (drupal.org issue #2686145).

---

- Show "− 1 January 2015 +" style decrease/increase links around a date field value.
- Put decrement and increment links on either side of a numeric field (stock, votes, quantity).
- Add forward/back cycling links around an options field value directly in its formatter.
- Keep the action link visually attached to the value it changes rather than in a separate region.
- Configure which action links appear on a field per view mode using the formatter's third-party settings.
- Have the AJAX style update the whole field value in place after the action, not just the link.
- Support fields shown in multiple view modes by replacing the value in each relevant mode on action.
- Enable the feature purely through Manage Display without writing code or editing templates.
- Combine several action links on the same field via the checkboxes selector.
- Fall back to the default field display for AJAX replacement when the field uses custom display options.
