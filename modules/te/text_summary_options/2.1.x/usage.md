Text Summary Options adds three site-builder settings to any "Text (formatted, long, with summary)" field — show the summary by default, give it custom help text, and give it placeholder text — configured on the field's edit form.

---

The module targets core's `text_with_summary` field type and its "Text area with a summary"
widget. It has no settings page or configure route. On the field settings form
(`hook_form_field_config_edit_form_alter`) it injects three third-party-setting inputs, but
only for `text_with_summary` fields: **Show summary** (checkbox), **Summary help text**
(textarea), and **Summary Placeholder** (textarea). Saving stores them as third-party settings
under `text_summary_options` on the `FieldConfig` entity
(`field.field.<entity>.<bundle>.<field>` → `third_party_settings.text_summary_options`). At
edit time, `hook_field_widget_single_element_form_alter()` reads those settings from the
field's config (skipping base fields and the default-value widget): if **Show summary** is on
it removes the summary element's `#attached` (which drops core's "Hide/Edit summary" JS toggle
so the summary textarea is shown expanded by default); **Summary help text** becomes the
summary field's `#description`; **Summary Placeholder** becomes the summary textarea's
`placeholder` attribute. Config schema
`field.field.*.*.*.third_party.text_summary_options` validates the three keys. The effect is
purely on the editing widget — stored values are unchanged.

---

- Show the summary/teaser textarea expanded by default instead of hidden behind core's "Edit summary" link.
- Add custom help text under a field's summary explaining what editors should write there.
- Add placeholder text inside the summary box to prompt editors (e.g. "One-sentence teaser…").
- Encourage consistent teaser text across a content type without custom code.
- Configure the Body field's summary behaviour per bundle from its field settings form.
- Make the summary more discoverable for editors who miss the collapsed "Edit summary" toggle.
- Provide different summary help text on different content types using the same field type.
- Guide authors on summary length or tone via placeholder or help text.
- Keep the summary visible during content entry so it is less likely to be forgotten.
- Improve the editorial experience for teaser-driven listing/views layouts.
- Set summary options in exported config (`third_party_settings.text_summary_options`) for deployment.
- Turn the always-show-summary behaviour on or off per environment by overriding field config.
- Apply summary help/placeholder to any custom `text_with_summary` field, not just Body.
- Standardise summary UX across an editorial team through field configuration.
- Prompt for SEO-friendly teaser copy via placeholder text.
- Reduce editor confusion about where the teaser text goes.
- Combine with Views teaser displays that rely on the summary being populated.
- Add contextual guidance for translators on what the summary should contain.
- Show the summary by default on a landing-page content type while leaving it collapsed elsewhere.
- Avoid a custom widget just to reveal or annotate the summary field.
