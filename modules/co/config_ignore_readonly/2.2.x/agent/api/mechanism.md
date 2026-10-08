<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Config Ignore Readonly works

The whole module is one file, `config_ignore_readonly.module`, implementing one hook:

```php
function config_ignore_readonly_config_readonly_whitelist_patterns(): array {
  $ignoreConfig = ConfigIgnoreConfig::fromConfig(\Drupal::configFactory()->get('config_ignore.settings'));
  \Drupal::moduleHandler()->alter('config_ignore_ignored', $ignoreConfig);
  return $ignoreConfig->getFormated('simple');
}
```

- **`hook_config_readonly_whitelist_patterns()`** is invoked by the `config_readonly` module.
  Anything a whitelist hook returns is treated as *editable* even while the site is otherwise
  read-only. Config Readonly matches these patterns against a form's
  `getEditableConfigNames()`.
- The returned value is Config Ignore's ignore list in **simple** form:
  `getFormated('simple')` is `getList('import', 'update')` — the flat list stored at
  `config_ignore.settings` key **`ignored_config_entities`** (when Config Ignore is in
  `mode: simple`, the default).
- Before returning, it re-runs Config Ignore's own `hook_config_ignore_ignored` alter, so
  patterns other modules add dynamically are included too.

Net effect: **the set of config forms that stay editable under Config Readonly === the set of
config Config Ignore is ignoring.**

## Make a config form editable while readonly is active

Add the form's config name to Config Ignore's ignore list. Simplest via drush:

```bash
# Read current list
drush cget config_ignore.settings ignored_config_entities

# Set it (simple mode = a flat YAML list of config names / glob patterns)
drush cset config_ignore.settings ignored_config_entities.0 system.site -y
```

Or scriptably (append without clobbering existing entries):

```php
$cfg = \Drupal::configFactory()->getEditable('config_ignore.settings');
$list = $cfg->get('ignored_config_entities') ?: [];
$list[] = 'system.site';                 // e.g. the Basic site settings form
$cfg->set('ignored_config_entities', array_values(array_unique($list)))->save();
```

After a cache rebuild, the *Basic site settings* form (`/admin/config/system/site-information`,
which edits `system.site`) stays submittable even with `config_readonly` active. Glob patterns
work as in Config Ignore, e.g. `system.*` or `webform.webform.*`.

## Verify what is currently whitelisted

The patterns the module forwards to Config Readonly:

```php
$patterns = \Drupal::moduleHandler()->invoke(
  'config_ignore_readonly', 'config_readonly_whitelist_patterns'
);
// array of config names that remain editable under readonly.
```

## Limitations (from README)

- **Force-import patterns** like `~webform.webform.contact` are **not** supported.
- **Partial / sub-key patterns** like `user.mail:register_no_approval_required.body` are **not**
  supported (the whole config name must be ignored).
- A form whose `getEditableConfigNames()` returns **several** config names only becomes
  editable when **all** of those names are ignored.
- Only Config Ignore's *simple* mode list (`import`/`update`) is read; intermediate/advanced
  per-direction/per-operation nuances collapse to that single list.
