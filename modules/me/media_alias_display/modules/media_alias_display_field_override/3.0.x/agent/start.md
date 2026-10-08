<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Alias Display Field Override — agent index

A tiny submodule of `media_alias_display`: it adds a **per-media boolean field** so an individual
media entity can opt out of the parent's file-streaming and render as a normal media page.
No config, routes, permissions, services, or Drush — just a field + a check in the parent
controller. See the parent's
[../../../../3.0.x/agent/api/behavior.md](../../../../3.0.x/agent/api/behavior.md) (step 4 of the
decision flow).

## What it installs

`hook_install` creates:
- Field storage `field_override_mad_module` on the `media` entity type, type **boolean**.
- A field instance on **every existing media type**, label "Override Media Alias Display",
  with a `boolean_checkbox` widget on each bundle's form display.

## How it's used

When `media_alias_display`'s `DisplayController` runs, it checks:
```php
$this->moduleHandler->moduleExists('media_alias_display_field_override')
  && $media->hasField('field_override_mad_module')
  && $media->get('field_override_mad_module')->value   // truthy
```
If true → the media renders **normally** (no file streaming).

## Notes

- Media types added **after** enabling this submodule do **not** get the field automatically —
  add `field_override_mad_module` to new bundles yourself.
- Set it in code: `$media->set('field_override_mad_module', TRUE)->save();`
  Read it: `$media->get('field_override_mad_module')->value`.
