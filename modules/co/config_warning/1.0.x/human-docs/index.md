# Config Warning — manual setup guide

**Config Warning** (`config_warning`) shows a configurable warning message on admin
forms that are likely to change the site's *running configuration*, reminding editors
that their edits may be lost on the next deployment. On a project that manages
configuration in code, a change made through the UI on production is fragile: the next
config import will silently overwrite it. Config Warning nudges people at exactly the
moment they are about to make such a change, so they think twice — or follow your
team's change-management process instead.

It works by inspecting admin forms and deciding whether the current form alters
configuration. A form qualifies when it is a settings form (one that declares
`getEditableConfigNames()`), an entity form editing an existing *config* entity (a
view, a block, an image style, and so on), or core's user-permissions or block-listing
form. When a qualifying form loads and the warning is enabled, your configured message
appears as a standard Drupal warning. You can scope *where* the warning appears using
page-path conditions, and you can enable or disable the whole thing without
uninstalling — a common pattern is to keep it off in development and turn it on in
production.

This is a lightweight administration tool. It has a single settings form and no other
routes, permissions, or endpoints; the settings form is gated by the `administer site
configuration` permission, and the warning text is admin-authored and shown through
Drupal's messenger. The message is off by default, so nothing changes until you
enable it. This is the 1.0.x branch for core 10.1 or 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   enabling the warning, setting the message, and scoping it to paths.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → Config
warning** (`/admin/config/development/config-warning`), behind the `administer site
configuration` permission. The message is **disabled by default** — see
[Configuration](configuration/index.md) to switch it on.
