# Configuration

Field Prefix has a single, simple settings form.

## Open the settings form

1. Log in as a user with the **Access administration pages** permission (an
   administrator by default).
2. Navigate to `admin/config/field_prefix/setting`
   (`/admin/config/field_prefix/setting`).

## The setting

- **Field prefix** — the text Field UI will prepend to the machine name of newly
  created fields.
  - Enter a **custom prefix** (for example `custom_`) to use your own naming
    convention.
  - **Clear the box** (leave it empty) to remove the prefix entirely, so new fields
    get machine names with no `field_` in front.

Click **Save configuration** to apply. Behind the scenes this writes the
`field_prefix` key in Field UI's `field_ui.settings` configuration.

## What it affects

- The prefix applies to **fields you create after saving** — it does not rename any
  existing fields.
- It works for any entity type that uses Field UI's add-field workflow.

## Doing the same without the UI

Because the module only edits one core setting, you can make the identical change
from the command line and skip the form — for example with Drupal Console:

```bash
drupal config:override field_ui.settings --key='field_prefix' --value='custom_'
```

Use an empty string as the value to remove the prefix. This is why the module can be
safely uninstalled after you've set the prefix you want.
