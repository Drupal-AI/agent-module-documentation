# Global settings

Route `gsap.settings` → `/admin/config/content/gsap`, form `\Drupal\gsap\Form\Admin`
(a `ConfigFormBase`, form id `gsap_admin`), permission `administer gsap`. Edits the
`gsap.settings` config object.

## Config keys (`gsap.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `include_gsap` | boolean | `false` | Attach `gsap/gsap` on every page. Also the master switch that makes config-entity animations load (see below). |
| `include_libs` | boolean | `false` | Also attach the selected plugin libraries on every page. Disabled in the UI unless `include_gsap` is checked. |
| `libs` | sequence | `{}` | Plugin machine names to attach when `include_libs` is on. |
| `custom_libs` | sequence | `{}` | List of `{key: path}` entries turned into `gsap/<key>` libraries (not auto-attached). |

`libs` options (checkboxes on the form): `flip`, `scrolltrigger`, `observer`, `scrollto`,
`draggable`, `easel`, `motionpath`, `pixi`, `text`, `drawsvg`, `gsdevtools`, `inertia`,
`motionpathhelper`, `morphsvg`, `physics2d`, `physicsprops`, `scrambletext`, `splittext`,
`easepack`, `customease`, `custombounce`, `customwiggle`. (GSAP core itself is not an option —
it is controlled by `include_gsap`.)

## What happens at runtime (`hook_page_attachments`)

On every page the module adds cache tag `config:gsap.settings`, then:
1. If `include_gsap` is true → attaches `gsap/gsap`.
2. If `include_libs` is also true → attaches `gsap/<name>` for each entry in `libs`.
3. Still inside the `include_gsap` branch, it loads every **enabled** `gsap` config entity;
   if any exist it attaches `gsap/animations` and passes each entity to
   `drupalSettings.gsap.global` for `js/animations.js` to apply.

Important: config-entity animations only run when `include_gsap` is enabled. Turning on GSAP
globally is a prerequisite for the entity-based animations described in
[animations.md](animations.md).

## Custom libraries

Each `custom_libs` entry is `{key: path}` where `key` matches `^[a-z_]+$` (lower-case letters /
underscores, enforced by `Admin::validateLibKey`) and `path` is a URL or a docroot-absolute
path. `hook_library_info_build()` registers each as `gsap/<key>` with a dependency on
`gsap/gsap`. These are **not** attached automatically — a theme/module must depend on them.

## Setting it via drush / PHP

```bash
drush config:set gsap.settings include_gsap true
drush config:set gsap.settings include_libs true
```

```php
\Drupal::configFactory()->getEditable('gsap.settings')
  ->set('include_gsap', TRUE)
  ->set('include_libs', TRUE)
  ->set('libs', ['scrolltrigger', 'draggable'])
  ->set('custom_libs', [['my_plugin' => '/libraries/my/plugin.min.js']])
  ->save();
```

Config schema: `config/schema/gsap.schema.yml` → `gsap.settings` (`config_object`).
Install defaults: `config/install/gsap.settings.yml`.
