<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services

All services are plain classes registered in `drupalforge_deploy.services.yml` (no tags, no plugins).

## GitRepositoryInspector (`git_repository_inspector`)

`src/Service/GitRepositoryInspector.php`, ctor args `@file_system`, `@…git_provider_detector` (nullable).

- `inspect(string $drupalRoot): array` — resolves the real path (`file_system->realpath`), walks up
  with `findGitRoot()` to the nearest `.git`, then returns a readiness payload: `is_git_repository`,
  `git_root`, `remote_name`, `remote_url`, `normalized_remote_url`, `provider`, `is_supported_remote`,
  `current_branch`, `tracked_remote_branch`, `supported_remotes`, `branches`, `remote_branches`,
  `is_detached_head`, `guidance[]`.
- `normalizeRemoteUrl(string): array` — regex-parses `git@host:path`, `ssh://git@host/path`,
  `https?://host/path`; strips `.git`; canonicalizes GitHub.com / GitLab.com to `https://host/path`;
  for other hosts asks `GitProviderDetector` and accepts them only if detected as GitLab. Returns
  `url` / `provider` / `is_supported`.
- Private helpers shell out through `runGit()`: `git -C <root> <args> 2>/dev/null` via `shell_exec`.
  **The git root and every dynamic argument (remote name, remote ref path) are wrapped in
  `escapeshellarg()`**; other argument strings (`symbolic-ref …`, `for-each-ref …`, `rev-parse …`,
  `remote`) are hardcoded literals. Remote URLs are read from `git remote get-url` (local config),
  not from the request.
- Primary remote choice (`resolvePrimaryRemoteName`): upstream-tracking remote → `origin` → first.

## GitProviderDetector (`git_provider_detector`)

`src/Service/GitProviderDetector.php`, ctor arg `@http_client` (Guzzle).

- `detectProvider(string $host): string` — for a host **derived from the local remote URL** (not the
  HTTP request), probes `https://<host>/api/v4/version`, then `/api/v4/metadata`, then `/help`, and
  returns `'gitlab'` when the version/metadata JSON has non-empty `version`+`revision` or `/help`
  markup contains "GitLab"; else `''`. Per-host result cached per request.
- `requestText()` uses Guzzle with `http_errors=false`, `allow_redirects=true`, `timeout=2.0`,
  `connect_timeout=1.0`; **TLS verification is left at Guzzle's secure default (not disabled)**; any
  throwable is swallowed to `''`.

## BackupMigrateDestinationMetadataProvider (`backup_metadata_provider`)

`src/Service/BackupMigrateDestinationMetadataProvider.php`, implements `BackupMetadataProviderInterface`
+ `ContainerInjectionInterface`. Ctor `@logger.channel.drupalforge_deploy`, `@service_container`.

- Loads `backup_migrate_destination` entities via the entity type manager; keeps only entities whose
  `type` is `awss3`. Everything is guarded with `method_exists`/try-catch so a missing Backup and
  Migrate install degrades to empty results + a logged warning.
- `getBackupMetadata()` — calls the destination plugin's `listFiles()` (via `getObject()`) and
  normalizes each item (`normalizePluginOutput`) into records with `id`, `label`, `provider_plugin`,
  and canonical `created`/`size`/`expires` ints (`coerceCanonicalMetadataFields`).
- `getDestinationPrefix()` — reads `s3_folder_prefix` from destination config (trimmed of slashes).
- `getDestinationEnvironmentVariables()` — extracts `S3_BUCKET`, `AWS_REGION`, and AWS credentials
  from destination config. Credentials (`resolveDestinationCredentials`) come from: an
  `s3_key_name` **key_aws bundle** (`key_aws.repository` → `getAccessKey`/`getSecretKey`),
  `s3_access_key_name` / `s3_secret_key_name` **Key entities** (`key.repository` → `getKeyValue`),
  or plain config keys. This is a read of the operator's already-configured Backup-and-Migrate
  credentials; the module stores no credentials of its own.
- `getLastDiscoveryContext()` — flags (`has_compatible_destination_provider`, plugin/destination ids).

## BackupCatalogService (`backup_catalog_service`)

`src/Service/BackupCatalogService.php`, ctor `@logger…`, `@backup_metadata_provider`.

- `discoverBackups(?int $now)` — pulls provider metadata + discovery context, then `listBackups()`.
- `listBackups()` — `normalizeRecord()` each into `id/label/created/size/expires/is_expired/source`,
  sorted **newest `created` first**. `is_expired` = `expires > 0 && expires <= now`.
- `summarizeReadiness()` — returns `has_compatible_destination_provider`, `has_backups`,
  `has_available_backup`, totals, and `guidance[]`.
- Also proxies `getDestinationPrefix()` / `getDestinationEnvironmentVariables()` (each try-catch → log).

## DeploymentUrlBuilder (`deployment_url_builder`)

`src/Service/DeploymentUrlBuilder.php`, no ctor args (base URL constant
`https://www.drupalforge.org/drupalpod/new#`).

- `buildLaunchUrl($repoUrl, $branch, $image, $envVars=[])` — requires all three non-empty (throws
  `InvalidArgumentException` otherwise); sets `DP_REPO_BRANCH = <repoUrl>/tree/<branch>` and
  `DP_IMAGE = <image>`, then appends sanitized env vars (`DP_*` reserved keys skipped).
- `build($parameters)` — returns `''` unless the base URL is `https://…`; otherwise
  `baseUrl . implode(',', "KEY=VALUE")` (comma-delimited fragment).
- `parseEnvironmentVariables($raw)` / `parseFragmentParameters($fragment)` — parse `KEY=VALUE` lines /
  comma- or ampersand-delimited fragments; keys must match `^[A-Za-z_][A-Za-z0-9_]*$`.
- `sanitizeEnvironmentVariables()` — drops invalid keys, casts values to string.

## PhpImageResolver (`php_image_resolver`)

`resolveImage(?string $phpVersion=null)` — first of `8.5,8.4,8.3,8.2,8.1,8.0,7.4` that
`version_compare(current, v, '>=')`, returned as `drupalforge/deployment:php-<v>`; fallback
`drupalforge/deployment:php-7.4`. Defaults to `PHP_VERSION`.

## BackupOptionFormatter (`backup_option_formatter`)

`buildOptions()` → `id => "label (date | N bytes | expired)"`; `buildSelectableOptions()` drops
expired; `buildDefaultBackupId()` → first non-expired id.

## DeployReadinessEvaluator (`deploy_readiness_evaluator`)

`isReady($gitInspection, $backupReadiness): bool` = no `getFailureReasons()`. Failure reasons:
no git repo / unsupported remote / no compatible S3 destination / no available backup.
