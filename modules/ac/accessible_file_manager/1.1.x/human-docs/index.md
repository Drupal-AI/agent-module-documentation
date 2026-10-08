# Accessible File Manager — manual setup guide

**Accessible File Manager** (`accessible_file_manager`) gives administrators an
admin screen for governing the files on a site. It lists all managed files, shows
how each one is used, and tracks how many times each file has been downloaded — so
you can audit your media library, find unused or heavily downloaded files, and act
on them in bulk.

It builds on Drupal's core file and media handling plus **Views** and **Views Bulk
Operations**, so the file overview is a View you can filter and sort, and you can
select multiple files and run bulk operations on them. Download-count tracking gives
you a usage signal that core does not surface on its own.

The module is properly access-controlled and has no unauthenticated surface. Every
screen is gated by a specific permission (see [Installation](installation/index.md)),
so only the trusted roles you grant them to can reach the file inventory, the
overview, or the download counts. It also ships a small security safeguard — a
private-directory `.htaccess` guard — that keeps the `private://` files directory's
`.htaccess` in place so private files are not directly served.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the permissions to trusted administrators.

## How to use it

After enabling the module and granting yourself the permissions, open the file
overview to see every managed file, its usage, and its download count. From there
you can select files and apply bulk operations through Views Bulk Operations. There
is no settings form to configure — the value is in the overview and its permissions.
Keep the four permissions restricted to trusted administrators.
