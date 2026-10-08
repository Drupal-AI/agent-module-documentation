# Configuration

There is no central settings form for Hide format info. You configure it **per
field**, on the **Manage form display** screen, by ticking one or both of the
checkboxes it adds to formatted‑text field widgets.

## Open the form‑display editor

1. Log in as a user who can administer the entity you want to edit (an
   administrator by default).
2. Go to the bundle's **Manage form display** tab. For a content type that's
   **Structure → Content types → *(your type)* → Manage form display**
   (`/admin/structure/types/manage/{bundle}/form-display`). The same tab exists
   for other fieldable entities — taxonomy terms, media, paragraphs, custom
   entities and so on.
3. Find a formatted‑text field — one using a `text`, `text_long`, or
   `text_with_summary` field type (for example the **Body** field). Click the
   **gear / settings** icon at the right end of that field's row to expand its
   widget settings.

## The two checkboxes

Inside the expanded widget settings you'll see two options this module adds:

- **Hide the help link *About text formats*** — hides the small *About text
  formats* link that normally sits beneath the field, while leaving the format
  `<select>` dropdown in place. Use this when you want editors to still choose a
  format but don't want the help link cluttering the form.
- **Hide text format guidelines** — hides the block of guidelines (the "Allowed
  HTML tags…" text) that describes what the selected format permits.

The two settings are independent, so you can hide just the help link, just the
guidelines, or both. When **both** are hidden *and* the field offers only a
single text format, the module also removes the surrounding format wrapper
entirely, giving you a perfectly clean text area with no format chrome at all.

Click **Update** on the widget, then **Save** at the bottom of the Manage form
display page.

## Notes

- The setting applies to the specific **form mode** you edit it in (the
  *Default* form display, or any custom form mode), so you can tidy the editor
  form without affecting other displays.
- It is **not** applied to the default‑value widget on the field settings page —
  only to the real content‑entry form.
- Your choices are stored as third‑party settings on the form display and export
  cleanly with your configuration (the module ships config schema for them), so
  they deploy across environments like any other config.
