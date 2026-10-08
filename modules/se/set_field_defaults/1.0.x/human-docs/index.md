# Set Field Defaults — manual setup guide

**Set Field Defaults** (`set_field_defaults`) — despite the machine name, the project
is titled *Field Default Values* — lets administrators configure default values for
field types once, so that every new field of that type is created with those defaults
pre-filled. It hooks into Drupal's field configuration system so that when you add a
new field, the configured default value is applied automatically (and you can still
adjust it by hand during field creation).

The point is consistency and less repetitive typing. On a site where you keep
creating fields that should behave the same way, you set the defaults centrally and
stop re-entering them for every new field. It works with a range of field types —
text, number, link fields and more.

The module depends on core **Field** and **System**, and sits in the Configuration
package. Its defaults are purely admin-configured; it has no content or
access-control role. Supports Drupal 10 and 11. Note that this project is not covered
by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — define the default values per field
   type.

## Where it lives in the admin menu

After enabling, configure the defaults at **Configuration → System → Field Default
Values** (`/admin/config/field-defaults`).

## How to use it

Set your per-field-type defaults on that configuration page. From then on, whenever
you add a new field of a covered type through the field UI, its default value is
pre-filled from your configuration. You can still change that value manually while
creating the field if a particular case needs something different.
