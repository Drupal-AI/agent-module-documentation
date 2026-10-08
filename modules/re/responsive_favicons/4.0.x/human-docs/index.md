# Responsive Favicons — manual setup guide

**Responsive Favicons** (`responsive_favicons`) adds a complete, cross-device
favicon set to your Drupal site — the iPhone and iPad touch icons, Android/Chrome
icons, Windows tiles, an SVG icon, the classic `favicon.ico`, and the web manifest —
based on the package produced by
[realfavicongenerator.net](https://realfavicongenerator.net/). Instead of dropping a
single low-resolution `favicon.ico` in your docroot, you get high-quality,
size-specific icons that look right on retina displays and mobile home screens.

The workflow is simple: you generate a favicon package and its HTML snippet at
realfavicongenerator.net, then on the module's settings form you paste the HTML and
either upload the `.zip` package or point to a directory of icons that already lives
in your repository. From then on, the module injects the right `<link>` and `<meta>`
tags into every page's HTML head (including the maintenance page), rewriting the icon
paths so they resolve correctly.

A key benefit is that the icons are served *through Drupal* rather than from the
docroot, so multisite installations can serve different favicons per site without
files cluttering a shared root. The module handles the well-known icon URLs
(`/apple-touch-icon.png`, `/site.webmanifest`, `/favicon.svg`, `/browserconfig.xml`,
`/favicon.ico`) itself. Options let you add a cache-busting suffix so browsers pick
up updated icons, still emit tags when some files are missing (handy for staged
rollouts), and strip Drupal's default core/theme `favicon.ico`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   plus the `.htaccess` tweak needed to serve `/favicon.ico`.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Responsive Favicons**
(`/admin/config/user-interface/responsive_favicons`), gated by the **Administer
responsive favicons** permission. The icon-delivery URLs themselves are public (no
permission needed), as favicon files must be.

## How to use it

1. Generate your favicon package and HTML snippet at realfavicongenerator.net
   (choose the "place files at the root of my site" option — the module rewrites the
   URLs for you).
2. Enable the module, open the settings form, paste the HTML snippet, and either
   upload the `.zip` or point at an in-repo icon directory.
3. Save, then check **Reports → Status report**, which shows how many favicon tags
   were found and flags any missing files or conflicting modules.

See [Configuration](configuration/index.md) for each field and the `.htaccess` note.
