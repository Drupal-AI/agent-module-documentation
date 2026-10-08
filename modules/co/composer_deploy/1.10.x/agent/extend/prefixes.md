# Config: `composer_deploy.settings:prefixes`

The module's only configuration. A sequence of Composer **vendor prefixes** used by the
name-based fallback lookup (`ComposerDeployHandler::getPackage()`) when matching an extension
to a package in `installed.json`.

- Default (shipped in `config/install/composer_deploy.settings.yml`): `['drupal']`.
- `drupal` is **always** included at runtime even if you remove it — the alter hook force-adds
  it (`if (!in_array('drupal', $prefixes)) $prefixes[] = 'drupal';`).
- Schema: `config/schema/composer_deploy.schema.yml` — `prefixes` is a `sequence` of strings.
- There is **no admin form** and no `configure` route; manage it with drush/config only.

## When you need it

Only if your modules are installed under a vendor other than `drupal/` — e.g. a private fork
published as `mycompany/my_module`. Add that vendor so the name-based fallback can resolve it.
The primary path-based lookup (`getPackageByPath`) is prefix-independent and covers the normal
`drupal/*` case without any config.

## Read it

```bash
drush config:get composer_deploy.settings prefixes
```

## Change it

```bash
# add a custom vendor prefix (keeps drupal implicitly)
drush php:eval '\Drupal::configFactory()->getEditable("composer_deploy.settings")
  ->set("prefixes", ["drupal", "acme"])->save();'
drush cr
```

Or via a config import of `composer_deploy.settings.yml`:

```yaml
prefixes:
  - drupal
  - acme
```

## Reset to default

```bash
drush php:eval '\Drupal::configFactory()->getEditable("composer_deploy.settings")
  ->set("prefixes", ["drupal"])->save();'
drush cr
```

Note: the historical `vendor_dir` key was removed by update hook `composer_deploy_update_8101`;
the vendor dir is now discovered automatically via `webflo/drupal-finder`.
