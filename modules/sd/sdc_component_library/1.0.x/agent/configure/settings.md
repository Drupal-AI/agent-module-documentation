# Configure — preview page path

Settings form `\Drupal\sdc_component_library\Form\SettingsForm` (extends `ConfigFormBase`).
Form id `sdc_component_library_settings_form`.

- Route: `sdc_component_library.settings`
- Path: `/admin/config/system/sdc-component-library`
- Permission: `administer site configuration`
- Menu link: under **Configuration › System**; a second link ("SDC Library") points to the preview route under the Appearance/themes page.

## Config object

`sdc_component_library.settings` — schema type `config_object` (`config/schema/sdc_component_library.schema.yml`).

| Key | Type | Default (`config/install`) | Notes |
|---|---|---|---|
| `path` | string | `/sdc-component-library` | URL path of the component preview page. Required; must start with `/`; must not contain whitespace (`validateForm`). |

## How the path takes effect

The preview route `sdc_component_library.component_list` is declared at
`/sdc-component-library`. On every route rebuild,
`\Drupal\sdc_component_library\Routing\RouteSubscriber::alterRoutes` reads
`sdc_component_library.settings:path` and, when non-empty, overrides the route's path
with it. The form's `submitForm` calls `router.builder`->rebuild() **only when the
path actually changed**.

## Set via drush

    drush config:set sdc_component_library.settings path /components -y
    drush cr    # rebuild routes so RouteSubscriber picks up the new path

`config:set` alone updates config but does not rebuild routes, so the page stays on
the old path until a cache/route rebuild. (Saving through the form rebuilds for you.)

## Set via PHP

    \Drupal::configFactory()
      ->getEditable('sdc_component_library.settings')
      ->set('path', '/components')
      ->save();
    \Drupal::service('router.builder')->rebuild();
