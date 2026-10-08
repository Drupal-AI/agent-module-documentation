# Configuration

At a minimum, set the **Base URI** and **Additional Hosts** before you run a tidy —
these tell Link Magician which URLs belong to your site, which is what its
redirect‑detection and link‑conversion logic relies on.

> **Heads‑up:** the maintainers note that the configuration and settings here
> still need work (tracked in the project's issue queue). Treat these as the
> essential fields and test on a content copy before running against production.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → System → Link Magician**, or navigate directly to
   `/admin/config/system/link_magician`.

## Base URI

The main URL of the site. This is used in the logic that checks for redirects that
might be handled by something other than Drupal.

- On a **production** site, set this to the address visitors actually use, for
  example `https://www.example.com/`.
- On a **development sandbox or server**, set it to the address you reach that
  environment at, for example `http://example.ddev.site/`.

## Additional Hosts

Any additional hostnames that should be treated as belonging to this site — for
example both `www.example.com` and `example.com`. Add each host you want the
module to recognise as "on this site" so that links to those hosts are converted
to internal references rather than treated as external.

## Save

Click **Save configuration**. With the Base URI and Additional Hosts set, you can
run the tidy process from Drush (see the [overview](../index.md)) — starting with
`drush link_magician:tidy --help` to review the available options.
