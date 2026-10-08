<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Override — the three override sources

There is **no admin UI, no route, no permission, no settings form**. You configure this module
by placing files or setting environment variables. All three sources are core
`ConfigFactoryOverrideInterface` services registered on the config factory (tag
`config.factory.override`), so their values become what the site *uses at runtime* while
`drush cex` still exports the stored (un-overridden) value.

File naming rule (site + module sources): each YAML file is named after the config object it
overrides — `system.site.yml`, `system.mail.yml` — and its contents are merged (deep) into that
config object. `readMultiple`/`listAll` load every `*.yml` in the folder.

## 1. Site-wide override folder — `SiteConfigOverrides`

Drop YAML files into `sites/default/config/override/` (path is **hardcoded** in
`src/SiteConfigOverrides.php` — the README's "specify 'override' in settings.php" is outdated;
just creating the folder is enough). Not multisite-aware (always `sites/default/…`).

```yaml
# sites/default/config/override/system.site.yml
name: 'Staging site'
slogan: 'Not production'
```

Cached under cache bin `data`, key `config_overrides.site`, no cache tags — clear caches
(`drush cr`) after editing.

## 2. Module-provided overrides — `ModuleConfigOverrides`

Any enabled module may ship a `config/override/` folder; the module iterates every enabled
module's path and deep-merges all such files. Use this to package environment/opinionated
defaults that apply as soon as the module is enabled.

```yaml
# mymodule/config/override/system.performance.yml
css:
  preprocess: true
```

Cached key `config_overrides.modules`, cache tag `config:core.extension` (invalidates when the
module list changes). `drush cr` to pick up file edits.

## 3. Environment variables — `EnvironmentConfigOverride`

Requires `symfony/dotenv` (a composer dep of this module). Registered only if the Dotenv class
exists. `src/ConfigOverrideServiceProvider.php` parses, at container-build time,
`sites/default/.env` and `sites/default/.environment`.

Encoding (this is the part the README garbles — the working rule is in the service provider):

- `CONFIG___` prefix marks an override line.
- **Three underscores `___`** separate the three parts: `CONFIG___{config_name}___{config_key}`.
- **Two underscores `__`** inside a part become a **dot** (`.`).
- A **single underscore `_`** stays a literal underscore.

```dotenv
# sites/default/.env
# → overrides config "system.site", key "name"
CONFIG___system__site___name=Env-driven name
# → overrides config "system.site", key "slogan"
CONFIG___system__site___slogan=From the environment
```

Extra behaviour in `src/EnvironmentConfigOverride.php::loadOverrides()`:
- The value is also re-read live with `getenv()` (both the lowercase and UPPERCASE index), so a
  variable exported dynamically by the host or in `settings.php` overrides the `.env` value.
  The `.env` entry must still exist for the key to be picked up (it seeds the list of names).
- If the value is **valid JSON**, it is decoded — so a JSON object value overrides an **entire
  subtree** of a config key, not just a scalar.

Cache suffix `config_override__env`, cache tag `env`.

## Verify an override is applied

```bash
drush cget system.site name            # shows the effective (overridden) value
drush cget system.site name --include-overridden
drush php:eval "var_dump(\Drupal::config('system.site')->get('name'));"
# stored vs runtime: an overridden object reports ->hasOverrides() true
```

## Notes / gotchas

- Overridden keys are **not editable in admin forms** (core shows/saves the stored value) — by
  design, surprising to site builders.
- `drush cex` never exports overrides — that keeps exports environment-neutral.
- Not the same as `config_ignore` / `config_split` (which decide what is *exported*).
- Secrets are better held in a [Key](https://www.drupal.org/project/key) entity than an override,
  since overrides are readable by anything that can read config.
