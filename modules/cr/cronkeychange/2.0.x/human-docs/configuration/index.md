# Configuration

Cron Key Change has no settings form of its own — there is nothing to tune. What
it adds is a single action: regenerating the cron key. You can do that from the
admin UI or from the command line.

## Rotate the key from the admin UI

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default). This is core's own permission — the module does not
   add one.
2. Go to **Configuration → System → Cron**, or navigate directly to
   `/admin/config/system/cron`.
3. Expand the **Change cron key** fieldset. It contains:
   - **Current cron key** — a read‑only display of the site's current key, so you
     can confirm what it is (and confirm afterward that it changed).
   - **Generate new key** — a button that replaces the key.
4. Click **Generate new key**. The module writes a fresh, cryptographically strong
   random value, shows a confirmation message, and logs a notice. The read‑only
   display updates to the new key.

The moment you do this, the external cron URL becomes `/cron/<new-key>` and any
previously shared `/cron/<old-key>` URL stops working. Remember to update
whatever external scheduler or monitoring service triggers your cron.

## Rotate the key from the command line

The module also registers a Drush command that does exactly the same thing —
useful in deploy scripts, CI/CD, or scheduled rotation across a fleet of sites:

```bash
drush cronkeychange
```

It takes no arguments or options, regenerates the key, and prints
`New cron key generated.` To read the new value afterward:

```bash
drush cronkeychange && drush state:get system.cron_key
```

## Good to know

The cron key lives in Drupal's **state**, not in exported configuration. That
means it is not included in `drush config:export`, it differs per environment, and
copying a database from production to staging carries the production key with it —
a good moment to rotate. Typical reasons to rotate include a suspected leak, an
offboarded contractor who had the cron URL, or simply routine security hygiene.
