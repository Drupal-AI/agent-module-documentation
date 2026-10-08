# Configuration

Tagify has two layers of settings: a small **global form** that can make it the
default widget everywhere, and the **per‑field options** that do most of the work.

## Global settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Tagify → Settings**, or navigate directly to
   `/admin/config/tagify/settings`.

The form has a single option:

- **Set as default widget** *(off by default)* — when ticked, Tagify becomes the
  default widget for every entity‑reference field type on the site, so new fields
  use the chip UI automatically. Leave it off if you would rather opt in field by
  field.

Click **Save configuration** to store the setting.

## Per‑field widget settings

This is where the interesting options live. On a field's **Manage form display**
tab (for example **Structure → Content types → (your type) → Manage form
display**), change the field's **Widget** to one of Tagify's two widgets, then
click the gear icon to reveal its settings.

### Tagify autocomplete widget

Use this for entity‑reference fields where editors type to find matches (taxonomy
terms, users, nodes, media, and so on):

- **Match operator** *(default: Contains)* — how the autocomplete matches what the
  editor types. **Contains** matches the typed text anywhere in a label;
  **Starts with** matches only from the beginning.
- **Match limit** *(default: 10)* — the maximum number of suggestions shown in the
  dropdown. Set it to `0` for unlimited.
- **Suggestions dropdown** *(default: on the first character)* — controls when the
  suggestion dropdown opens as the editor types.
- **Placeholder** *(default: empty)* — placeholder text shown in the empty field
  to prompt editors what to type.
- **Show entity ID** *(off by default)* — include the referenced entity's ID
  inside each chip. Handy for disambiguating entities with identical labels.
- **Show info label** *(off by default)* — show an extra line of information beside
  each suggestion in the dropdown.
- **Info label** *(default: empty)* — the token‑enabled string used for that info
  label, for example `[term:description]`. Only applies when *Show info label* is
  on.
- **Parent selection** *(on by default)* — whether editors may select parent terms
  in a hierarchical vocabulary. Turn it off to force selection of leaf terms only.

### Tagify select widget

Use this for fields backed by a fixed option list. It shares the **Match
operator**, **Match limit**, **Placeholder**, **Show entity ID**, and **Parent
selection** options above, plus it respects the field's **cardinality** and an
**identifier** setting.

All of these settings are exportable configuration (stored under
`field.widget.settings.tagify_*`), so they travel with your configuration
management workflow.
