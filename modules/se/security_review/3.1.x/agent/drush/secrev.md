# Drush: security review

Command class `SecurityReviewCommands` (registered via `drush.services.yml`).

- **Command:** `security:review`
- **Aliases:** `secrev`, `security-review`
- **Exit code:** non-zero (`EXIT_FAILURE`) if any run check result is `FAIL` — useful as a CI gate.
- **Output:** table (`message`, `status`); `--pipe` emits CSV.

## Options
| Option | Effect |
|---|---|
| `--store` | Write results to storage (state). Skipped checks are removed from the run when storing. |
| `--log` | Log each check to watchdog (default off). |
| `--lastrun` | Do not run; print the stored results from the last run. |
| `--check=a,b,c` | Run only these checks (comma-separated, no spaces). |
| `--skip=a,b,c` | Exclude these checks. Takes precedence over `--check`. |
| `--short` | Short messages (check titles) instead of full pass/fail description. |
| `--results` | Show the offending settings/findings for failed checks. |

## Examples
```bash
drush secrev                        # run all checks, print results
drush secrev --store                # run, store, and print
drush secrev --lastrun              # print last stored results only
drush secrev --check=error_reporting,trusted_hosts
drush secrev --skip=file_permissions
drush secrev --results              # include findings for failures
drush secrev --check=my_module:my_check   # custom check (namespace:title); module must be enabled
```

Built-in check ids: `account_creation`, `admin_permissions`, `admin_user`, `error_reporting`,
`executable_php`, `failed_logins`, `fields`, `file_permissions`, `headers`, `input_formats`,
`last_cron_run`, `name_passwords`, `private_files`, `query_errors`, `temporary_files`,
`trusted_hosts`, `upload_extensions`, `vendor_directory`, `views_access`.

A check name may be given as `id`, or as `namespace:title` for custom checks. With `--store`,
any check marked skipped on the settings page will not be run.
