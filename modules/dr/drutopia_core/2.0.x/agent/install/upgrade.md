<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, enable & update hooks

## Install & enable

```bash
composer require drupal/drutopia_core -W
drush en drutopia_core -y
```

Use `-W` (`--with-all-dependencies`): the whole point of this feature is to pull in a large stack of components. On a full Drutopia site the install profile enables `drutopia_core` **first**, before any content feature, so the shared config baseline exists.

Enabling it installs the dependencies listed in `drutopia_core.info.yml` and imports everything under `config/install/` (media types, paragraph types, fields, image styles, view/form modes, taxonomy, pathauto patterns, the Search API DB server, base roles) plus applies the five `config/actions/` role permission actions. There is **no settings form** — `configure` is null.

## Update hooks (`drutopia_core.install`)

The install file contains **no `hook_install`** and no schema. It defines only `hook_update_N` functions, each of which simply enables newly added dependencies via `\Drupal::service('module_installer')->install([...])` so that an existing Drutopia site picks up modules that later releases started depending on. Run them with `drush updatedb -y`.

| Update | Installs |
|---|---|
| `drutopia_core_update_8101` | `video_embed_field` |
| `drutopia_core_update_8102` | `faqfield` |
| `drutopia_core_update_8103` | `crop`, `focal_point` |
| `drutopia_core_update_10201` | `ckeditor5`, `image_widget_crop`, `media`, `media_library`, `media_library_media_modify`, `media_responsive_thumbnail` |

That is the entirety of the module's executable behaviour: it enables modules. It writes no secrets, sets no insecure defaults and runs nothing else.

## Dev checkout note

This checkout is a **dev checkout** — `drutopia_core.info.yml` has no `version:` line and tracks the `2.0.x` branch. `composer.json` sets `minimum-stability: dev`. Its `require` block lists a few packages that `info.yml` does not itself enable (`facets`, `image_field_to_media`, `media_contextual_crop`, `media_contextual_crop_field_formatter`); those are resolved by Composer for the wider distribution rather than enabled by `drutopia_core` directly. See data.json `composer_requirements` vs `dependent_modules`.
