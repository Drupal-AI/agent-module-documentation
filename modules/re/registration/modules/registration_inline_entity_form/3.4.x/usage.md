<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Inline Entity Form lets editors manage a host entity's registration settings directly on the host's own edit form, using an Inline Entity Form widget instead of a separate settings page.

---

The submodule integrates with the contrib **Inline Entity Form** module by providing a field widget
`inline_entity_form_settings` (for the `registration` field type). When you set that widget on the
host bundle's registration field in *Manage form display*, the host edit form embeds the registration
settings (capacity, open/close, reminders, etc.) inline, so an editor configures registration in the
same place they edit the event. The widget settings (schema
`field.widget.settings.inline_entity_form_settings`) include `form_mode`, `override_labels`,
`label_singular`/`label_plural`, `collapsible`, `collapsed`, `revision` and the base `hide_register_tab`.
A dedicated permission, `edit registration settings`, grants editing of all registration settings for
new and existing hosts regardless of registration type (provided via a permission provider). The
submodule also wires element/widget submit handlers (`RegistrationElementSubmit`,
`RegistrationWidgetSubmit`) and an inline form handler (`RegistrationSettingsInlineForm`) so the inline
settings save together with the host. It is essentially glue between Registration and Inline Entity
Form; it adds no new entity or config object of its own beyond the widget settings.

---

- Edit an event's capacity and dates on the event node form itself.
- Avoid sending editors to a separate registration settings page.
- Embed registration open/close/reminder settings inline on the host edit form.
- Configure the inline widget's form mode for registration settings.
- Collapse the inline registration settings section by default.
- Override the inline widget labels (singular/plural) for clarity.
- Grant `edit registration settings` to let a role manage settings for any host.
- Let content authors set up registration while creating the event in one screen.
- Keep registration configuration and event content editing in a single workflow.
- Create a new revision when inline registration settings change (if enabled).
- Hide the separate Register tab while using inline settings (hide_register_tab).
- Streamline event creation for non-technical editors.
- Present registration settings as a collapsible fieldset on the host form.
- Save host content and its registration settings together in one submit.
- Use IEF's UX for the registration settings sub-form.
- Apply to any registration-enabled bundle by choosing the widget in form display.
- Reduce clicks for editors managing many events.
- Allow per-bundle inline settings configuration via the form display.
- Give a consistent editing experience across event content types.
- Manage registration settings without the standalone settings route.
