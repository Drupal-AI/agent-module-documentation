# Configuration

Entity Autocomplete Plus is configured in two places: a **global default** token
string that applies everywhere, and an optional **per-field** override on each
reference field's widget. The per-field value wins when both are set.

## Set the global default token string

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default) — the settings form is gated by that permission.
2. Go to **Configuration → Content authoring → Entity Autocomplete Plus**, or
   navigate directly to `/admin/config/content/entity_autocomplete_plus`.
3. Enter a **token string** — the text that will be appended after each suggestion's
   label. Use tokens (for example an author, date, status, or path token) so the
   suffix is filled in per matched entity. A token browser link is available to help
   you find valid tokens for the entity type.
4. Save the form.

This global string now applies to every entity-reference autocomplete on the site
that doesn't specify its own.

## Override per field

To use different context on a particular field:

1. Go to **Structure → (entity type) → (bundle) → Manage form display**.
2. Find your entity-reference field, confirm its widget is set to an
   **autocomplete** widget (or **Inline Entity Form**), and open the widget's
   settings with the gear/cog icon.
3. Enter a **token string** in the field the module adds there. This value overrides
   the global default for this field only. A token browser link is shown for the
   field's target entity type.
4. Save the widget settings, then save the form display.

The widget settings summary shows the token that will be appended for each
configured field, so you can confirm at a glance which fields have an override.

## Notes

- The suffix is purely cosmetic — it changes how suggestions are *labelled*, not
  which entities are returned. Suggestions still come from the field's selection
  handler, and that handler's access filtering is unchanged.
- Only entity-reference field types are affected.
- Uninstalling the module reverts autocomplete to Drupal's stock matcher.
