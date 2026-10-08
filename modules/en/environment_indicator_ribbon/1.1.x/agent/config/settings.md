<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & operation

## Install / enable

`composer require drupal/environment_indicator_ribbon` (pulls in `drupal/environment_indicator: ^4`),
then enable both. This module ships no `config/install`, no `config/schema`, and no settings form.

## Where the values come from

This module has **no UI**. The `.info.yml` `configure` key points at the base module's route
`environment_indicator.settings` (`/admin/config/development/environment-indicator`). The ribbon's
text and colours are the `name`, `fg_color`, and `bg_color` keys of the base module's
`environment_indicator.indicator` config object — set them on that base-module form.

## Make the ribbon correct per environment

Because the ribbon is drawn from `environment_indicator.indicator`, it shows whatever that config
resolves to. If the value is shipped as identical exported config across all environments, every
environment shows the same label. To be correct per environment, override
`$config['environment_indicator.indicator']` in each environment's `settings.php`, keyed off an
environment variable or hostname (this is standard environment_indicator practice, not something this
module adds).

## Permission

`environment_indicator_ribbon.permissions.yml` defines one permission,
`access environment indicator ribbon` ("See environment indicator ribbon"). The
`hook_page_attachments()` gate emits the ribbon only to users who hold it. Grant it to the roles that
should see the marker (typically admins/developers/editors); anonymous users normally should not.

## Troubleshooting

- Nothing shows: confirm `environment_indicator.indicator` has a non-empty `name`, the user has the
  permission, and the page is not a cached response predating enablement (`drush cr`).
- The name is what makes the cue readable without colour perception, since it is printed as the
  ribbon text.
