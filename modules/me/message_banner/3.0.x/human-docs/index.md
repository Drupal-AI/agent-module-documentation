# Message Banner — manual setup guide

**Message Banner** (`message_banner`) displays a single, site-wide message banner
to your visitors — an announcement bar, a cookie/GDPR notice, a maintenance-window
warning, or a promotional strip — all configured from one settings form. The banner
can be dismissible (with a close button) and will stay dismissed for a number of
minutes you choose, or you can make it non-dismissible for critical notices.

You author the banner text as rich text in a text format of your choice, pick a
color to signal severity, and decide whether it also shows on admin pages (off by
default, so editors aren't distracted). By default the banner is prepended to the
page `<body>`, but you can target a specific CSS selector instead. Re-saving the
form re-shows the banner even to visitors who previously dismissed it — handy when
you update the message.

The module has just one settings form, so this page covers both what it does and
how to configure it. There is no separate configuration page in these docs.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. **Configuring the banner** — below on this page.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Message Banner**
(`/admin/config/user-interface/message-banner`). It requires the **Manage message
banner** permission.

## Permissions

Two permissions, under **People → Permissions**:

- **Manage message banner** — access the settings form.
- **View message banner** — controls whether the banner is shown to a user. On
  install this is granted to both the **anonymous** and **authenticated** roles, so
  the banner is visible to everyone by default. Remove it from a role to hide the
  banner from that role.

## Configuring the banner

On the settings form:

- **Enable banner** — the master on/off switch. When off, nothing is attached to
  any page.
- **Enable on admin routes** — off by default, so the banner stays off admin pages.
  Turn it on to show the banner in the back end too.
- **Banner text** — the rich-text message, authored in a text format (the form
  defaults to *Basic HTML*). It is rendered through Drupal's normal text-format
  filtering.
- **Banner color** — a color class to signal severity. The built-in options are
  red, amber, green, black, gray, and white. (Developers can add their own — see
  below.)
- **Disable close button** — when ticked, the banner has no close button and cannot
  be dismissed. Use for critical, must-see notices.
- **Show again after (minutes)** — for a dismissible banner, how many minutes after
  someone closes it before it reappears. `0` means it stays dismissed.
- **Position override / override selector** — by default the banner is prepended to
  the page `<body>`. Turn on the override and provide a CSS selector (for example
  `.region-highlighted`) to have the banner prepended into that element instead.

Click **Save configuration**. The banner appears (or updates) on the next page
load. Note that re-saving the form re-shows the banner to everyone, including
visitors who had previously dismissed it — so you can push an updated message out to
all users just by saving again.

Message Banner also supports **configuration translation**, so you can localize the
banner text and settings per language.

## For developers

Add or remove banner color options with
`hook_message_banner_colors_alter(array &$colors)`, where each entry is
`machine_class => label`; the machine key is emitted as a CSS class on the banner,
so define matching CSS in your theme. See the sibling
[`agent/`](../agent/hooks/colors.md) docs.
