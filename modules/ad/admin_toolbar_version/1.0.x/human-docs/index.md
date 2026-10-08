# Admin Toolbar Version — manual setup guide

**Admin Toolbar Version** (`admin_toolbar_version`) adds the running Drupal core
and module version information to the Admin Toolbar tools menu, so an administrator
can see at a glance which version the site is on. It is a small operator
convenience: rather than digging through the status report, the version sits in
the toolbar you already have open.

Behind the scenes a small service (`VersionInfoManager`) resolves the version
information — it reads the core and install-profile version, and where present it
can read a git `HEAD` file to report the deployed reference, which is handy for
confirming exactly which commit is live on a given environment. There is no
front-end output; the information only ever appears in the admin toolbar for
authenticated administrators.

It requires the **Extra Tools** submodule of Admin Toolbar
(`admin_toolbar_tools`), since it hangs its menu entry off that tools menu. It
targets Drupal 8.8 and up through 10.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Admin Toolbar's Extra Tools.

## Where it lives in the admin menu

The version information appears as an entry under the Admin Toolbar **tools**
menu (the drop-down under the Drupal icon). The module also has a small settings
form for its display options at
**Configuration → User interface → Admin Toolbar Version**
(`/admin/config/user-interface/admin-toolbar-version`), gated by the
**Administer site configuration** permission.

## How to use it

Enable it alongside Admin Toolbar's Extra Tools submodule and the version appears
in the toolbar automatically. If you want to adjust what is shown, open the
settings form above and save your display options. Because the version is only
shown to administrators inside the toolbar, this is an internal convenience /
deployment-fingerprint tool rather than anything visitors ever see.
