<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable / disable Twig debugging

## The settings form

- Route: `twig_debugger.settings` → path `/admin/config/development/twig-debugger`.
- Permission: `administer twig debugger configuration`.
- Form class: `Drupal\twig_debugger\Form\TwigDebugger` (a `ConfigFormBase`).
- One field: **"Enable Twig Debugging"** checkbox, bound to config
  `twig_debugger.settings:enabled` (1 = on, 0/empty = off).

The config object `twig_debugger.settings` ships **no** `config/install` default and **no**
schema, so it does not exist until the form is saved the first time. `$config->get('enabled')`
is `NULL` on a fresh install.

## What saving the form actually does

`submitForm()`:

1. Saves `enabled` to `twig_debugger.settings`.
2. **If enabled === 1** and `sites/default/services.yml` does **not** exist: copies
   `sites/default/default.services.yml` to `services.yml`, then string-replaces inside it:
   - `debug: false` → `debug: true`
   - `auto_reload: null` → `auto_reload: true`
   - `cache: true` → `cache: false`

   (these are the `parameters.twig.config` keys) and calls `drupal_flush_all_caches()`.
   Note: because it only acts when the file is **absent**, it will not rewrite an existing
   `services.yml` — on a site that already has one, tick the box but also verify the
   `twig.config` values by hand.
3. **If disabled**: if `sites/default/services.yml` exists it is **deleted**, then caches are
   flushed. (It removes the whole file, not just the twig block.)

## Reading current state

```bash
drush cget twig_debugger.settings enabled
# "Config twig_debugger.settings does not exist" == never saved == off
```

## Setting it from code / drush (config only)

To flip the stored flag without the file side effects (useful in scripts/tests):

```php
\Drupal::configFactory()->getEditable('twig_debugger.settings')
  ->set('enabled', 1)->save();
```

To fully replicate the module's on-state you would also need the `twig.config` block in
`sites/default/services.yml` set to `debug: true`, `auto_reload: true`, `cache: false` and a
cache rebuild (`drush cr`). To restore the never-configured baseline, delete the config:
`\Drupal::configFactory()->getEditable('twig_debugger.settings')->delete();`.

## What debug mode gives you

With `twig.config.debug: true`, Drupal wraps every rendered template in HTML comments listing
the theme hook, the ordered **template-suggestion** candidate file names, and the file actually
used — the canonical way to find which `*.html.twig` to override. `auto_reload: true` recompiles
changed templates automatically; `cache: false` disables the compiled-template cache. All three
are development-only settings.
