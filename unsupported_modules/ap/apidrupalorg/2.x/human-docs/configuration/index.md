# Configuration

This module has no general settings form. Its three pieces are configured (or run)
in different places, described below. Everything here is relevant only on an
api.drupal.org-style site built on the API module.

## The comments Import form

This is a **one-off migration tool** that copies comments from the legacy Drupal 7
api.drupal.org into the current API module's comment storage.

1. Log in as a full administrator (see the permission note below).
2. Go to **Configuration → Development → API.Drupal.org import**, or navigate
   directly to `/admin/config/development/apidrupalorg/import`.
3. Run the import from that form.

**Access is tightly restricted.** The route requires *all three* of these
permissions at once — **Administer comments**, **Administer users**, and
**Administer API reference** — so in practice only a full administrator can reach
it. This is deliberate: the import writes historical comment data, so it is not
something you want a lower-privileged role running by accident.

Run it once, when you migrate content; there is no reason to revisit it
afterwards.

## External-documentation path processor

There is nothing to configure here. Once the module is enabled, an inbound path
processor automatically rewrites URLs for the API module's external-documentation
branches so that older links keep resolving. It only rewrites request paths — it
reads nothing from the user and changes no data.

## Footer message block

The module provides a **Footer message** block plugin. Place it like any other
block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region you want (typically the footer) and click **Place block**.
3. Choose the **Footer message** block and save.

The block renders static footer markup, which lets you show a site-wide footer
message without writing a custom theme.
