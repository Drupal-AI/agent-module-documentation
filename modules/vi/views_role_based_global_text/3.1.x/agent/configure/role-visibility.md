# Role-based Global: Text area

## Setup

Enable the module. Then in any View, add **Header**, **Footer**, or **No results behavior**
→ **Global: Text area**. The text-area settings form now has an extra **Roles** section.

## Options

Under the **Roles** fieldset on the Global: Text area config form:

- **Select Roles** (`roles_fieldset.roles`) — checkboxes of all user roles.
- **Negate** (`roles_fieldset.negate`) — checkbox.

Stored in the display's area handler options, e.g. in the exported view:

```yaml
display:
  default:
    display_options:
      header:            # or footer / empty
        area:
          plugin_id: text
          content: { value: '<p>…</p>', format: basic_html }
          roles_fieldset:
            roles:
              anonymous: anonymous     # checked roles (role id => role id), 0 if unchecked
              authenticated: '0'
            negate: false
```

## Visibility logic (`RoleBasedGlobalText::render()`)

Checked roles = `array_filter($options['roles_fieldset']['roles'])`; the current user's roles
come from `\Drupal::currentUser()->getRoles()`.

| Roles selected? | Negate | Who sees the text |
|---|---|---|
| none | — | everyone (core default) |
| some | off | only users who have **at least one** selected role |
| some | on | everyone **except** users with a selected role |

When the user should not see it, `render()` returns `[]` (nothing rendered).

## Notes

- It overrides the core `text` area plugin class globally, so every Global: Text area gains
  these controls; existing areas keep their current behaviour (empty selection = all users).
- There is no separate config schema; options ride along in the view config. There are no
  permissions and no admin settings page.
