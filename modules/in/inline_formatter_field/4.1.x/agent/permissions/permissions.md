# Permissions

Four permissions across the base module and the two submodules. **All are declared
`restrict access: true`** — they grant the ability to author HTML/Twig that renders on the site (or
to change how the editor loads), so they are intended for trusted roles only.

| Permission | Provided by | Gate |
|---|---|---|
| `edit inline formatter field formats` | base | Show the `formatted_field` template editor on a field's *Manage display* gear (`InlineFormatterFieldFormatter::settingsForm`); also gates the AJAX helper route `inline_formatter_field.ajax.settings`. |
| `edit inline formatter field settings` | base | Access the settings form route `inline_formatter_field.settings_form`. |
| `edit inline formatter display formats` | `inline_formatter_display` | Show the "Use Inline Formatter Display" template editor on the entity-view-display *Manage display* form. |
| `edit inline formatter views field` | `inline_formatter_views_field` | Show the template editor in the Views field's options form. |

Without the relevant `…formats`/`…views field` permission, the editor field is hidden and the user
sees a "no permission" message; the underlying stored template is unchanged. There is **no**
permission that gates *viewing* rendered output — anyone who can view the entity/View sees whatever
the stored template renders.

`inline_formatter_field_update_8004` fixed a historical typo permission name
(`edit inline formmater field …`) by re-granting the corrected names to roles that had the old ones.

Grant example:

```bash
ddev drush role:perm:add editor 'edit inline formatter field formats'
```
