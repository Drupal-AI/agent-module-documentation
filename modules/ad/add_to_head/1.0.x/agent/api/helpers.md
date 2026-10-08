<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: helper functions and the alter hook

Add To Head exposes two procedural helpers (in `add_to_head.module`) and one alter hook
(documented in `add_to_head.api.php`) for reading/writing profiles from code instead of the UI.

## `add_to_head_get_settings($scope = NULL)`

Returns the full profiles array (associative, keyed by profile `name`), after giving other
modules a chance to add/alter entries via `hook_add_to_head_profiles_alter()`:

```php
function add_to_head_get_settings($scope = NULL) {
  $settings = \Drupal::config('add_to_head.settings')->get('add_to_head_profiles');
  $settings = ($settings) ? $settings : [];
  \Drupal::moduleHandler()->alter('add_to_head_profiles', $settings);
  if ($scope) {
    $settings = array_filter($settings, fn($profile) => $profile['scope'] == $scope);
  }
  return $settings;
}
```

Pass `$scope` (`'head'`, `'scripts'`, or `'styles'`) to filter to only that scope's profiles —
this is exactly how the two rendering hooks (`hook_page_attachments_alter`,
`hook_page_bottom`) fetch their subset. Note: this includes profiles added purely in code via
the alter hook, which are NOT present in `add_to_head.settings` config and cannot be
edited/deleted through the admin UI.

## `add_to_head_set_settings(array $settings)`

Writes the full profiles array back to config in one call:

```php
function add_to_head_set_settings($settings) {
  \Drupal::configFactory()->getEditable('add_to_head.settings')
    ->set('add_to_head_profiles', $settings)
    ->save();
}
```

Always pass the **complete** array (keyed by name) — this replaces `add_to_head_profiles`
wholesale, it does not merge. Read-modify-write:

```php
$settings = add_to_head_get_settings();
$settings['my-profile'] = [
  'name' => 'my-profile',
  'code' => '<meta name="example" content="1">',
  'scope' => 'head',
  'paths' => ['visibility' => 'exclude', 'paths' => ''],
  'roles' => ['visibility' => 'exclude', 'list' => []],
];
add_to_head_set_settings($settings);
```

Caution: `add_to_head_get_settings()` (no `$scope`) also returns profiles injected purely via
`hook_add_to_head_profiles_alter()`. If you read-modify-write with `add_to_head_set_settings()`
you would persist those code-only profiles into config too — prefer reading/writing
`\Drupal::configFactory()->getEditable('add_to_head.settings')` directly when you only want to
touch the UI-managed set.

## `hook_add_to_head_profiles_alter(array &$profiles)`

Lets other modules add or alter profiles at read time without touching
`add_to_head.settings` config at all — useful for shipping a tracking snippet in
version-controlled code rather than as site configuration:

```php
function mymodule_add_to_head_profiles_alter(array &$profiles) {
  $profiles['my-code-profile'] = [
    'name' => 'my-code-profile',
    'scope' => 'scripts',
    'paths' => ['visibility' => 'include', 'paths' => '<front>'],
    'roles' => ['visibility' => 'exclude', 'list' => []],
    'code' => '<script>/* ... */</script>',
  ];
}
```

Profiles added this way appear in the rendering hooks (via `add_to_head_get_settings()`) but
NOT in the admin overview's editable rows, and are not persisted to config.
