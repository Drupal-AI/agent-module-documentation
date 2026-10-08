# Configuration

There is no settings page. The only configuration is a single checkbox that you
enable per field widget, and the modal behaviour is automatic from there.

## Enable the popup on a field

1. The field must already use the **Inline entity form - Complex** widget. If it
   does not, set that up first on the entity's **Manage form display** tab (for
   example **Structure → Content types → [type] → Manage form display**).
2. On that **Manage form display** page, click the gear/settings icon for the
   field using the Complex widget.
3. Check **"Enable Popup for IEF"** and apply, then **Save** the form display.

The widget's settings summary will then read *"Display the form in a popup."* to
confirm it is on.

Behind the scenes this stores a per-widget third-party setting
(`third_party_settings.ief_popup.ief_popup_enabled: true`) in that form display's
configuration. To revert to stock inline IEF, uncheck the box and save.

## What changes for editors

Once enabled, when an editor works with that field:

- **Add**, **Edit**, and **Duplicate** open the entity sub-form in a centred modal
  with a contextual title.
- **Add existing** opens the reference-selection form in a popup.
- **Remove** shows a clearer "Are you sure you want to remove …" confirmation in a
  modal.

Each dialog has a visible close ("X") control, and the primary versus cancel
buttons are styled distinctly. The behaviour also applies inside Layout Builder
block configuration forms.

## Notes

- The popup styling and behaviour come from the module's own small CSS/JS library,
  which is attached on every page so the dialogs work wherever an IEF form appears.
- This is a presentational change only — no fields, data, or IEF configuration are
  altered beyond the one checkbox.
