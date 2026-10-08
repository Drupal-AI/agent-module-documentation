<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up alert banners

## Install

```bash
composer require drupal/localgov_alert_banner
drush en localgov_alert_banner -y
drush cr
```

Brings core `content_moderation`, `workflows`, `options`, `link`, `views` and contrib
`condition_field` (`^2.0`). `hook_install()` runs `localgov_alert_banner_set_default_permissions()`
(and configures Scheduled Transitions if that module is already present); it is skipped during a
config sync.

## What install gives you

| Config | Purpose |
|---|---|
| `localgov_alert_banner.localgov_alert_banner_type.localgov_alert_banner` | The default banner bundle |
| `field.field.localgov_alert_banner.localgov_alert_banner.short_description` | Banner text |
| `…link` | Optional call-to-action link |
| `…type_of_alert` | Severity / priority list — **drives ordering** |
| `…visibility` | `condition_field` value: where the banner shows |
| `workflows.workflow.localgov_alert_banners` | Moderation workflow (draft / published / unpublished) |
| `user.role.emergency_publisher` | Role for the emergency comms team |
| `views.view.localgov_admin_manage_alert_banners` | Admin listing at `/admin/content/alert-banners` |
| `config/optional/block.block.localgov_alert_banner_*` | Ready-made block placements for the `olivero`, `scarfolk` and base themes |

## Create a banner

UI: *Content → Alert banners → Add*. From code:

```bash
drush php:eval '
$b = \Drupal::entityTypeManager()->getStorage("localgov_alert_banner")->create([
  "type" => "localgov_alert_banner",
  "title" => "Severe weather warning",
  "short_description" => ["value" => "Heavy snow expected. Check before travelling.", "format" => "basic_html"],
  "type_of_alert" => "major",
  "status" => 1,
]);
$b->save();
print $b->id();'
```

The `title` base field is a plain-text string capped at 50 characters (`text_processing` off).
`type_of_alert` values come from the field's allowed-values list:

```bash
drush cget field.storage.localgov_alert_banner.type_of_alert settings.allowed_values
```

## Going live / taking down

Publishing is done through the status form
(`/admin/content/alert-banner/{id}/status`, `AlertBannerEntityStatusForm`, gated by the entity
`update` access) rather than a raw status checkbox — it sets the `moderation_state` and, if the
*Unpublish all other alerts* checkbox is ticked, unpublishes every other live banner in one action.
Publishing regenerates the banner's dismiss `token` in `preSave()`.

## Place the block

```bash
drush php:eval '
\Drupal\block\Entity\Block::create([
  "id" => "alertbanner",
  "plugin" => "localgov_alert_banner_block",
  "theme" => \Drupal::config("system.theme")->get("default"),
  "region" => "header",
  "settings" => ["id" => "localgov_alert_banner_block", "label" => "Alert banner", "label_display" => 0],
])->save();'
drush cr
```

The block has a bundle filter (`include_types`) in its settings — leave it empty to show all banner
types, or select specific ones (this maps to the manager's `type` option).

## Adding banner types

```bash
drush php:eval '
\Drupal::entityTypeManager()->getStorage("localgov_alert_banner_type")
  ->create(["id" => "service_notice", "label" => "Service notice"])->save();'
```

New bundles get their own permissions automatically (see
[../permissions/permissions.md](../permissions/permissions.md)) and can have their own fields,
form/view displays and template suggestion
(`hook_theme_suggestions_localgov_alert_banner()`).

## Visibility conditions

The `visibility` field is a `condition_field`, i.e. core condition plugins (request path, content
type, user role, language …) stored on the entity. A banner with no conditions shows everywhere.

Important behaviour: the manager loads **every** published banner and only then applies the
visibility check, so that all candidates contribute cache contexts. That means a banner restricted
to one path still influences the block's cache metadata site-wide — correct, but it is why the
block is cached per those contexts. `AlertBannerEntity::getCacheContexts()` also honours condition
`negate` when merging contexts (`@see #154`).

## Moderation and scheduling

- The `localgov_alert_banners` workflow governs draft/published/unpublished states; grant the
  transitions to your emergency role.
- When **Scheduled Transitions** is installed, `hook_modules_installed()` calls
  `localgov_alert_banner_configure_scheduled_transitions()` to enable it for the entity type — so
  banners can be set to publish/unpublish at a time, and it grants the scheduling permissions to
  `emergency_publisher`. Installing it during a config sync skips the hook; re-run it manually:

  ```bash
  drush php:eval 'localgov_alert_banner_configure_scheduled_transitions();'
  ```

## Theming

`ThemeHooks::theme()` registers the banner template
(`templates/localgov-alert-banner.html.twig`) and
`ThemeHooks::themeSuggestionsLocalgovAlertBanner()` adds per-bundle and per-type suggestions, so you
can style a `major` alert differently from a routine one. `ThemeHooks::preprocessField()` adjusts
field rendering inside the banner. Default CSS ships in `css/localgov-alert-banner.css` (library
`localgov_alert_banner/alert_banner`) and can be disabled with a `libraries-override` in your theme.
