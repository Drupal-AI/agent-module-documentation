# Acquia CMS Toolbar — manual setup guide

**Acquia CMS Toolbar** (`acquia_cms_toolbar`) brings **Acquia CMS's styling to the
administration toolbar**. It does not add new admin links or change what the
toolbar does — it layers the distribution's look and feel over the drop-down admin
menu so the admin chrome matches the rest of an Acquia CMS site.

Under the hood it is a thin wrapper around the popular **Admin Toolbar** module: it
depends on both **Admin Toolbar** (`admin_toolbar`) and its **Extra Tools**
submodule (`admin_toolbar_tools`), so enabling it gives you the fast expandable
drop-down admin menu and the one-click *Flush all caches* / *Run cron* action links
as well, wrapped in Acquia's styling.

Like the rest of the family it is **distribution configuration and glue** — exactly
right on an Acquia CMS site, and a strong set of visual assumptions on an unrelated
one. There is nothing to configure; it works the moment it is enabled. If you also
run the **Gin** admin theme, pair it with the companion
`acquia_cms_toolbar_gin` module so the toolbar sits correctly under Gin.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the Admin Toolbar modules it brings along.

## Where it lives in the admin menu

There is no settings page. Its effect is visible in the **admin toolbar** across
the top of every admin page — the drop-down menus and action links carry Acquia
CMS styling once the module is enabled.

## How to use it

Enable the module and you are done. Hover over the top-level toolbar items to see
the expandable Admin Toolbar drop-downs, and click the Drupal icon at the far left
for the Extra Tools action links (*Flush all caches*, *Run cron*, and related
shortcuts) that come from the `admin_toolbar_tools` dependency — all rendered in
the Acquia CMS style. There is nothing to configure.
