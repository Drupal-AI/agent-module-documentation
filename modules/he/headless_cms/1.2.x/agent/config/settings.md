<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Headless CMS — install, settings page & consumer integration

## Install / enable

`drupal/headless_cms` requires `drupal/consumers ^1.19` (`composer.json`). Enable the base module
plus whichever submodules you need — each is independent:

```
composer require drupal/headless_cms
drush en headless_cms headless_cms_preview headless_cms_notify headless_cms_notify_webhook -y
```

The base module has **no configuration of its own**. It only registers a permission and a landing
page; the submodules add the actual settings and the per-consumer fields.

## Permission

`headless_cms.permissions.yml` defines a single permission, used by every submodule route and the
`headless_notify_transport` config entity's `admin_permission`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer headless_cms settings` | true | The settings landing page and all preview/notify/transport admin routes |

## Settings landing page

Route `headless_cms.settings` → **`/admin/config/headless-cms`** (`headless_cms.routing.yml`) uses
core's `SystemController::systemAdminMenuBlockPage`, so it is just a menu block that lists the
child admin pages contributed by enabled submodules (Preview settings, Notify settings, Notify
Transports). Menu link `headless_cms.settings` places it under *Configuration* (`system.admin_config`).

![Headless CMS settings landing page](../../../../../../../screenshots/headless_cms/1.2.x/settings-landing.png)

## Consumer-form integration (`HeadlessCmsUtility`)

All per-feature configuration is stored **on the `consumer` entity**, not in this module's config.
`HeadlessCmsUtility::alterConsumerForm(array &$form)` (`src/HeadlessCmsUtility.php`) is the shared
entry point the submodules call from their `hook_form_consumer_form_alter()` implementations. It:

- attaches the `headless_cms/form` library (`headless_cms.libraries.yml` → `css/form.css`) once;
- creates an `additional_settings` vertical-tabs group (weight 7) if no other module already did;
- creates a `headless_cms_settings` details element (`#open = TRUE`) inside that group.

The **Preview** and **Notify** submodules then add their own `preview_settings` / `notify_settings`
details sections and move their consumer base fields into that group (see each submodule's docs).
So the operator configures Headless CMS by editing each **Consumer** at
`/admin/config/services/consumer`, not on a central form.

## Submodule configuration entry points (once enabled)

| Submodule | Admin route / path |
|---|---|
| Preview | `headless_cms_preview.settings` → `/admin/config/headless-cms/preview` |
| Notify (settings) | `headless_cms_notify.settings` → `/admin/config/headless-cms/notify/settings` |
| Notify transports | `entity.headless_notify_transport.collection` → `/admin/config/headless-cms/notify/transports` |
| Preview - NATS | adds a *NATS Settings* section to the Preview settings form |
| Notify - Webhook / NATS | add transport plugins selectable when creating a transport |

See the submodule solution docs for the fields, config objects and schema each one provides.
