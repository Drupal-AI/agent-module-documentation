# Configure — declaring overrides, permission, report

Known Overrides has **no settings form**. You configure it entirely by editing a settings file
(`settings.php`, `settings.local.php`, or `settings.local.includes.php`): declare a
`$settings['knownOverrides']` array listing the config names you override, then grant the report
permission. The module reads it with `Settings::get('knownOverrides', [])`; nothing is stored in
Drupal config.

## 1. Declare the array

After the `<?php` line, ensure the array exists, then register each overridden config name next to the
actual override:

```php
if (!isset($settings['knownOverrides'])) {
  $settings['knownOverrides'] = [];
}

// The actual override:
$config['mail_safety.settings']['enabled'] = TRUE;
// Register it so Known Overrides tracks it:
$settings['knownOverrides'][] = 'mail_safety.settings';
```

## 2. Accepted entry shapes

`KnownOverridesController::__invoke()` and `known_overrides_form_alter()` accept three shapes; each
resolves to a tracked **config name**:

| Shape | Example | Tracked config name is |
|---|---|---|
| Plain string (numeric key) | `$settings['knownOverrides'][] = 'system.site';` | the string value |
| Config-name key ⇒ array value | `$settings['knownOverrides']['system.site'] = ['path' => '/admin/config/system/site-information'];` | the array key |
| Array with `config` (numeric key) | `$settings['knownOverrides'][] = ['config' => 'system.site', 'path' => '/admin/...'];` | `value['config']` |

An entry whose array value carries a `path` (a string, or an array of paths) is **page-scoped**: on
those paths Known Overrides emits an admin warning even when the page is not the config's own form.
See [../hooks/highlighting.md](../hooks/highlighting.md) for exactly when the highlighting versus the
path warning fires.

## 3. Grant the permission

Route `known_overrides.report` requires `known overrides report`, declared `restrict access: true`.
Grant it only to trusted roles — the report reveals how this environment differs from the codebase.

```bash
ddev drush role:perm:add administrator 'known overrides report'
```

## 4. Read the report

Visit `/admin/reports/known-overrides` (also linked under Administration ▸ Reports). For every tracked
config name it renders a two-column diff — **Editable** (the stored config) vs **Overridden** (the
live/in-memory config) — listing only the keys that differ. The route is `no_cache: TRUE`, so it
always reflects current state. If no differences exist the report shows "No overrides found".
