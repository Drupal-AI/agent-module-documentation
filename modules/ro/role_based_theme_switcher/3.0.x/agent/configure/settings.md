# Role Based Theme Switcher — configuration & negotiation

## Settings form
`src/Form/AdminSettingsForm.php`, route `role_based_theme_switcher.settings` at
`/admin/config/system/role_based_theme_switcher/settings`, permission **`administer site
configuration`**. Form id `role_admin_settings`.

- Renders a `#type => table` with `#tabledrag` (weight ordering). One row per role (`Role::loadMultiple()`).
- Each row: a `Select Theme` `#type => select` whose `#options` are the installed themes
  (`theme_handler->listInfo()`), plus a `weight` element (`#delta => 50`).
- `validateForm()` rejects duplicate weight values ("Use one weight … value to one role only").
- `submitForm()` sorts rows by weight, builds `roletheme[role_id] = ['id' => theme, 'weight' => n]`,
  saves to config `role_based_theme_switcher.RoleBasedThemeSwitchConfig`, then calls
  `drupal_flush_all_caches()` so anonymous/page caches reflect the change.

## Config structure
Config object: `role_based_theme_switcher.RoleBasedThemeSwitchConfig`
```yaml
roletheme:
  anonymous:      { id: '',            weight: 0 }
  authenticated:  { id: olivero,       weight: 1 }
  editor:         { id: claro,         weight: 2 }
```
No config schema ships (values are stored untyped). An empty `id` means "no override for this role".

## Weight / priority resolution
`RoleNegotiator::getPriorityRole()` intersects the user's roles with the configured roles and returns
the role with the **maximum weight** (`array_search(max($themeArr), $themeArr)`). In the tabledrag UI
that is the row dragged furthest **down**. So for a user with multiple roles, the lowest/heaviest row
wins.

## Negotiation behavior
`RoleNegotiator::applies()` (service `theme.negotiator.role_based_theme_switcher`, priority 10):
- Sets `$this->theme` from `roletheme[priorityRole]['id']` if non-empty.
- Returns FALSE (does not apply) when the route is an admin route AND the user has permission
  `view the administration theme` — so the site's configured admin theme still governs admin pages
  for such users. Otherwise returns TRUE and `determineActiveTheme()` returns the role theme.
- Because it returns TRUE for non-admin routes even when no theme matched (`$this->theme` may be
  unset/NULL), a NULL return from `determineActiveTheme()` simply lets other negotiators/default
  decide.

## Gotchas
- The hardcoded defaults in `buildForm()` reference `seven` (for `administrator`) and `bartik`, which
  are not present on Drupal 10/11. Always select an actually-installed theme in each row.
- The module reads `roletheme` twice per request (form/negotiator) directly from config; there is no
  cache tag on the theme decision beyond the full flush performed on save.
