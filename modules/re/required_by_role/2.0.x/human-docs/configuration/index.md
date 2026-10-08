# Configuration

There is no settings page. You configure Required by role per field, through the
**Required API** section that this plugin plugs into.

## Set it up

1. Make sure both **Required API** and **Required by role** are enabled.
2. Edit the field instance you want to control — for example **Structure →
   Content types → *(your type)* → Manage fields → *(your field)* → Edit** (the
   same works for any entity/bundle, such as users, taxonomy terms, paragraphs, or
   media).
3. In Required API's "required" section, choose the **Required by role** plugin.
4. A table of roles appears (the *Authenticated user* pseudo‑role is
   intentionally excluded). Tick the roles for which the field must be required.
5. Save the field. The field is now required only for users who have at least one
   of the ticked roles, and optional for everyone else.

## How the roles are stored

The selected roles are saved as Required API third‑party settings on the field
config, so they travel with your exported configuration:

```yaml
third_party_settings:
  required_api:
    required_plugin: required_by_role
    required_plugin_options:   # role machine names
      - editor
      - legal_reviewer
```

## How it decides at runtime

When a form is built, the plugin compares the current user's roles against your
ticked list. If there is **any overlap**, the field is marked required for that
user; otherwise it is optional. That's the whole rule.

## Important: this is validation, not access control

Making a field "not required" for a role does **not** hide it or stop that role
editing it — the field is still shown and writable. Required by role only decides
whether a value must be provided before the form validates. To actually restrict
who can see or edit a field, use core field access or a field‑permissions module.

## Practical uses

- Require a compliance/legal field for external contributor roles, but exempt
  administrators.
- Enforce a required byline only for the "journalist" role.
- Roll out a new mandatory field gradually by requiring it for one role at a
  time.
- Keep a migration‑only field optional for the migration role but required for
  manual editors.
