<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FitCheck & FitCheckGroup plugin types

Two attribute-based plugin types drive the audit. Both are standard `DefaultPluginManager`s that
discover classes under a directory and read a PHP attribute.

## fit_check

- Manager: `FitCheckPluginManager` (`src/FitCheckPluginManager.php`) — dir `Plugin/FitCheck`,
  interface `FitCheckInterface`, attribute `Attribute\FitCheck`, alter hook `fit_check_info`,
  cache bin key `fit_check_plugins`. Service `plugin.manager.fit_check`.
- Base: `FitCheckPluginBase` (`src/FitCheckPluginBase.php`) extends `PluginBase`, implements
  `FitCheckInterface` + `ContainerFactoryPluginInterface`, uses `StringTranslationTrait`. It exposes
  the attribute metadata as getters (`label()`, `fitGroup()`, `description()`, `successMessage()`,
  `failureMessage()`, `warningMessage()`, `errorMessage()`, `infoMessage()`, `helpMessage()`).
- You must implement `execute(): ?FitResult`. Returning `NULL` skips the check silently (the collector
  also swallows thrown exceptions, so one broken check never breaks the report).

### The FitCheck attribute (`src/Attribute/FitCheck.php`)

```php
#[FitCheck(
  id: 'my_check',                       // snake_case
  fitGroup: SecurityGroup::GROUP_ID,    // must match an existing fit_check_group id
  label: new TranslatableMarkup('My check'),
  description: new TranslatableMarkup('…'),          // optional
  successMessage: new TranslatableMarkup('All good.'), // optional
  failureMessage: new TranslatableMarkup('Problem.'),  // optional
  // warningMessage / errorMessage / infoMessage / helpMessage[] / deriver also optional
)]
```

`helpMessage` (if passed in the attribute) must be an array of `TranslatableMarkup`, else the attribute
constructor throws `InvalidArgumentException`. In practice checks add help at runtime via
`FitResult::setHelpMessage()`.

### Writing a check

Build and return a `FitResult` (`src/FitResult.php`). Start with a passing `FitWeight::Ok`, then downgrade
the weight and set the relevant message when a problem is found. Inject services with `create()` like any
container plugin. Minimal shape (see `Plugin/FitCheck/CoreUpdateCheck.php`,
`HttpsEnforcementCheck.php` for full examples):

```php
public function execute(): FitResult {
  $result = FitResult::create($this->getPluginId(), $this->label(), $this->fitGroup(), FitWeight::Ok);
  if ($problem) {
    $result->setWeight(FitWeight::High)
      ->setFailureMessage($this->failureMessage())
      ->setHelpMessage($this->t('How to fix it.'));
  }
  else {
    $result->setSuccessMessage($this->successMessage());
  }
  return $result;
}
```

`FitResult` is a mutable value object: `id/name/group/weight` + optional per-severity messages and a
`helpMessage[]` (each entry is a render array or `['#markup' => …]`). `setHelpMessage()` accepts a
`TranslatableMarkup` or a full render array. `toArray()` renders every message to a string (used when the
run is serialized into a `fit_report_history` snapshot).

### Bundled checks (58 in 1.1.3)

All live in `src/Plugin/FitCheck/`. Examples by group:
- **security**: `https_enforcement`, `dangerous_permission_check`, `anonymous_authenticated_permissions`,
  `database_cred_check`, `file_permission_check`, `file_upload_extension_check`, `file_upload_scheme_check`,
  `samesite_cookie`, `referrer_policy_header`, `trusted_host_check`, `reverse_proxy_safety`,
  `user_one_check`, `update_access_check`, `username_password_match_check`, `menu_router_malicious_entry`,
  `untrusted_html_input_check`, `vendor_directory_outside_webroot_check`, `failed_login_from_ip`,
  `low_environment_email_reroute`, `spam_protection_check`, `development_modules_check`, `php_version_check`.
- **best_practices**: `core_update_check`, `contrib_update_check`, `debug_mode_check`,
  `proper_error_handling`, `config_dir`, `monolog_in_production`, `pending_db_update`, `last_cron_run`.
- **performance**: `css_aggregation_check`, `js_aggregation_check`, `cache_backend`, `cache_check`,
  `page_cache_kill_switch_check`, `views_caching_check`, `image_toolkit_check`,
  `php_opcache_configuration`, `queue_backlog`, `watchdog_table_size`, `too_many_modules_enabled`.
- **content_and_config**: `unused_fields_check`, `unused_image_styles_check`, `unused_menus_check`,
  `unused_vocabulary_check`, `unused_content_entity_type_check`, `orphaned_media_files_check`,
  `duplicate_content_title_check`, `broken_menu_links_check`, `broken_path_aliases_check`,
  `large_revision_bloat_check`, `mismatched_entity_definitions`, `unplaced_blocks_check`,
  `error_pages_redirects_check`, `folder_structure_check`.
- `drupalfit_accessibility_check` / `drupal_fit_seo` are placeholders for the external-provider groups.

## fit_check_group

- Manager: `FitCheckGroupPluginManager` (`src/FitCheckGroupPluginManager.php`) — dir
  `Plugin/FitCheckGroup`, interface `FitCheckGroupInterface`, attribute `Attribute\FitCheckGroup`,
  alter hook `fit_check_group_info`. Service `plugin.manager.fit_check_group`.
- Base: `FitCheckGroupPluginBase` → `label()`, `description()`, `weight()`.

### The FitCheckGroup attribute (`src/Attribute/FitCheckGroup.php`)

```php
#[FitCheckGroup(
  id: self::GROUP_ID,          // MUST equal the group name, or be prefixed "<group>:<x>"
  weight: -80,                 // display order (lower = shown first)
  scoreWeight: 30,             // importance in the weighted overall score (default 10)
  label: new TranslatableMarkup('Security'),
  description: new TranslatableMarkup('…'),
  externalProvider: FALSE,     // TRUE = score comes from the DrupalFit cloud API, not on-site checks
)]
```

The 6 shipped groups and their weights (`id`, display `weight`, `scoreWeight`, external?):
`security` (-80, 30), `seo` (-90, 15, external), `accessibility` (-100, 10, external),
`performance` (-70, 20), `best_practices` (-60, 15), `content_and_config` (0, 10).
Convention: define a `const GROUP_ID` on the class and reference it from both the group's `id:` and each
check's `fitGroup:` (see `Plugin/FitCheckGroup/SecurityGroup.php`).

`weight` feeds display ordering (`FitResultGrouper`); `scoreWeight` feeds the weighted overall score;
`externalProvider: TRUE` means the group's score is taken from `AuditScores` returned by the cloud API
rather than from on-site check penalties (see [../api/scoring.md](../api/scoring.md)).
