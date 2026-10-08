# Configuration

Twig Debugger has exactly one setting: a checkbox that toggles Twig debug mode.

## Open the settings form

1. Log in as a user with the **Administer twig debugger configuration**
   permission.
2. Go to **Configuration → Development → Twig Debugger**, or navigate directly to
   `/admin/config/development/twig-debugger`.

## Enable Twig Debugging

Tick **Enable Twig Debugging** and click **Save configuration**. Untick it and
save to turn debugging back off.

## What saving actually does

When you save with the box **ticked**, and `sites/default/services.yml` does
**not** already exist, the module:

1. Copies `sites/default/default.services.yml` to `sites/default/services.yml`.
2. Sets the `twig.config` values in it: `debug: true`, `auto_reload: true`, and
   `cache: false`.
3. Flushes all caches.

When you save with the box **unticked**, the module deletes the generated
`sites/default/services.yml` (the whole file, not just the twig block) and flushes
caches.

## Important caveat: existing services.yml files

The module only writes `services.yml` **when that file is absent**. If your site
already has a `sites/default/services.yml` (many do), ticking the box saves the
setting but will **not** rewrite the file. In that case, set the values yourself in
the `parameters.twig.config` section:

```yaml
parameters:
  twig.config:
    debug: true
    auto_reload: true
    cache: false
```

Then run `drush cr` to rebuild caches.

## What debug mode gives you

With `twig.config.debug: true`, Drupal wraps every rendered template in HTML
comments that show:

- the **theme hook** being rendered,
- the ordered list of **template‑suggestion** candidate file names, and
- the template file that was **actually used**.

That is the canonical way to find which `*.html.twig` you need to override.
`auto_reload: true` recompiles changed templates automatically, and `cache: false`
disables the compiled‑template cache — both convenient while iterating on a theme,
and both development‑only.

## Checking the current state

```bash
drush cget twig_debugger.settings enabled
```

If the response is that the config does not exist, the form has never been saved,
which means debugging is off.
