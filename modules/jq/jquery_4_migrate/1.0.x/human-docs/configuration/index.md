# Configuration

The module has one small settings form with a single decision: should jQuery
Migrate load **everywhere**, or only where you wire it in by hand?

## Open the settings form

1. Log in as a user with the **Administer jQuery 4 Migrate** permission. Because
   the sitewide toggle affects every page that loads jQuery, grant this
   permission only to trusted roles.
2. Go to **Configuration → System → jQuery 4 Migrate Settings**, or navigate
   directly to `/admin/config/system/jquery-4-migrate-settings`.

## Enable jQuery 4 Migrate

- **Enable jQuery 4 Migrate** *(checkbox)* — when ticked, jQuery Migrate loads
  automatically wherever core jQuery loads, sitewide. This is the "fix everything
  at once" option: you don't have to edit any `.libraries.yml` file. It does add
  one small script to every page that uses jQuery, so it's a deliberate trade of
  a little overhead for not hunting down each broken plugin.

Leave the box **unchecked** if you'd rather be surgical: instead of loading the
shim everywhere, add `jquery_4_migrate/jquery-migrate` as a dependency to only
the specific library that needs it, in that library's `*.libraries.yml`
definition. That keeps the extra script off pages that don't need it.

## Save

Click **Save configuration**. If you enabled the sitewide toggle, reload a page
and confirm in the browser console that the old jQuery errors are gone.
