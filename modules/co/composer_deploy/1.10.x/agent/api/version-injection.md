# Version injection

Single hook: `composer_deploy_system_info_alter(array &$info, Extension $file, $type)`
(implements `hook_system_info_alter()`). Runs for every module/theme as Drupal builds its
extension info.

## When it acts

Only when `empty($info['version'])`. Drupal.org tarball releases already have a `version` in
`.info.yml` (added by the packaging script), so those are skipped. Composer installs from a
`dev-` branch or a plain git checkout have **no** version line — that is what this fills.

## Where it reads

`vendor/composer/installed.json`, located via `webflo/drupal-finder`
(`DrupalFinderComposerRuntime`). Handled by the internal `ComposerDeployHandler`. Package
lookup is two-step:

1. `getPackageByPath()` — matches the extension's path against each package's `install-path`
   (prefix-independent; this is the primary, non-deprecated path).
2. `getPackage($name)` — fallback matching `"<prefix>/<extensionName>"` for each configured
   prefix (see `extend/prefixes.md`).

Packages of Composer `type: metapackage` are **skipped** (submodule metapackages have no real
version).

## Keys it writes into `$info`

| Info key | Source in the composer package |
|---|---|
| `version` | `extra.drupal.version`; else `substr(version,4)."-dev"` for `dev-*`; else literal `dev` |
| `project` | second half of `name` (`drupal/token` → `token`) |
| `datestamp` | `extra.drupal.datestamp`; else `strtotime(package.time)` |
| `composer_deploy_git_hash` | `source.reference` (the deployed commit) — **this key is unique to this module** |

## Reading the result on a live site

```bash
drush php:eval '$i=\Drupal::service("extension.list.module")->getExtensionInfo("votingapi");
  echo $i["version"]."|".$i["composer_deploy_git_hash"];'
```

`composer_deploy_git_hash` present in an extension's info is the reliable signal that this
module (not the packaging script) supplied the version.

## Update report extras

- `composer_deploy_preprocess_update_project_status()` adds a **Diff** link per available
  release, comparing your installed reference to the upstream tag on `git.drupalcode.org`.
- `composer_deploy_theme_registry_alter()` + `ComposerDeployTwigExtension` (Twig function
  `composer_deploy_append`) override core's `update-version` template to inject that link.

No API to call — the module works passively once enabled.
