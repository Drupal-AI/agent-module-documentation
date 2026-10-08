# Configure Coffee

![Coffee configuration form](../../../../../../../screenshots/coffee/2.0.x/settings.png)

Settings form at `/admin/config/user-interface/coffee` (route `coffee.configuration`,
permission `administer coffee`). Stored in the `coffee.configuration` config object.

## Keys (`coffee.configuration`)
- **`coffee_menus`** (sequence of strings) — which admin menus Coffee indexes/searches
  (e.g. `admin`). Determines what the search box can navigate to.
- **`max_results`** (int) — number of items shown in the result list.

## Runtime data
The overlay fetches its searchable items from the controller route
`coffee.get_data` (`/admin/coffee/get-data`, permission `access coffee`), which returns the
menu links plus anything added via `hook_coffee_commands()`.

## Deploy as config
Export `coffee.configuration.yml` with `drush config:export`; import elsewhere with
`drush config:import`.
