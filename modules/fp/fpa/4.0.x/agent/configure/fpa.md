# fpa — configure

FPA works out of the box the moment it is enabled: it takes over
`/admin/people/permissions` and adds the filter UI. There is nothing to configure to get
the enhanced page. The only configuration is turning *off* parts of that UI.

## Settings form

- Route: `fpa.settings` (the module's `configure` route)
- Path: `/admin/config/people/fpa-settings`
- Title: "Manage fast permissions administration settings"
- Access: permission `manage fast permissions administration settings`
- Menu: appears under the People admin index (`user.admin_index`).

The form has a single "Disabled sections" checkboxes element. Each checked box **disables**
that section of the enhanced permissions page.

## Config object

`fpa.settings` — one key:

| Key | Type | Meaning |
|---|---|---|
| `disabled_sections` | map of `value: value` | Which UI sections are turned off. Empty (`{}`) = everything on (default). |

Allowed section values (checkbox options):

| Value | Disables |
|---|---|
| `help` | The on-page help text (the `permission@module` instructions). |
| `modules` | The module listing / sidebar. |
| `roles` | The role filter. |
| `status` | The permission status (checked / not-checked) filter. |

The form stores only the *checked* values (core `checkboxes` + `array_filter`), so a value
present in `disabled_sections` means that section is disabled; an absent value means it is
shown. Default after install is empty — all sections visible.

Note: the config schema file (`config/schema/fpa.schema.yml`) declares a `types` sequence,
but the form and `hook_help()` actually read/write the `disabled_sections` key — that is the
key to use.

## Set it programmatically

Read current value:

```bash
drush config:get fpa.settings disabled_sections
```

Disable the module listing and role filter (mirrors what the form saves):

```bash
drush php:eval '\Drupal::configFactory()->getEditable("fpa.settings")->set("disabled_sections", ["modules" => "modules", "roles" => "roles"])->save();'
```

Re-enable everything (baseline):

```bash
drush php:eval '\Drupal::configFactory()->getEditable("fpa.settings")->set("disabled_sections", [])->save();'
```

Then `drush cr`. Changes take effect on the next load of `/admin/people/permissions`.
