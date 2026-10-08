# Hooks & alters

## Plugin definition alter
- `hook_security_review_check_info_alter(array &$definitions)` — the plugin manager calls
  `alterInfo('security_review_check_info')`, so you can modify/remove discovered check
  definitions.

## Alterable variables (documented in docs/API.txt)
Implement `hook_TYPE_alter(array &$variable)` to tune built-in check data:

| Alter hook | Modifies |
|---|---|
| `hook_security_review_unsafe_tags_alter` | List of HTML tags considered unsafe (input formats check). |
| `hook_security_review_unsafe_extensions_alter` | File extensions considered unsafe for upload. |
| `hook_security_review_file_ignore_alter` | Relative/absolute paths to ignore in the File permissions check. |
| `hook_security_review_temporary_files_alter` | Files inspected by the Temporary files check. |

Example:
```php
function my_module_security_review_unsafe_extensions_alter(array &$variable) {
  $variable[] = 'reg';
}
```

## Core hooks the module reacts to (not for you to implement here, just behavior)
- `hook_modules_installed` / `hook_modules_uninstalled` → cleans orphaned check storage; on
  its own install stores server data.
- `hook_cron` → refreshes stored server user/groups.
- `hook_requirements` (runtime) → Status Report entry warning on failed / never-run checks.

To add an entirely new check, define a `SecurityCheck` plugin instead — see
[../plugins/security_check.md](../plugins/security_check.md).
