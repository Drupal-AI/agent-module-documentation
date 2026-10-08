# X-Frame-Options Configuration — manual setup guide

**X-Frame-Options Configuration** (`x_frame_options_configuration`) adds an
`X-Frame-Options` HTTP response header to every page on your site, giving you a
simple, UI-driven way to control whether the site may be embedded in a frame or
iframe. Setting this header is a standard defense against **clickjacking**, where
an attacker wraps your pages (a login or checkout screen, say) in a hidden iframe
on their own site to trick users into clicking something they didn't mean to. With
this module you set the framing policy from an admin form instead of hand-editing
`.htaccess` or your nginx config.

You choose one of four directives: **DENY** (the site can never be framed
anywhere), **SAMEORIGIN** (only pages on your own domain may frame it),
**ALLOW-FROM** (permit one specific partner URI to frame it), or **ALLOW-ALL**
(which actually *removes* the header entirely, useful when another layer sets it).
The policy is stored as exportable Drupal configuration, so you can deploy it and
even vary it per environment. Under the hood a response subscriber applies the
header to every response — cached and dynamic alike.

Two things are worth knowing. First, the **module's machine name is
`x_frame_options_configuration`** even though the Composer package and project are
named `x_frame_options` — enable it by the machine name. Second, the module ships
no default configuration, so until you save the settings form once, the header
falls back to a meaningless `X-Frame-Options: 0`; **save the form once** to
establish a real policy. Also note that the `ALLOW-FROM` directive is obsolete and
ignored by modern Chromium and Safari — for those browsers, use a
Content-Security-Policy `frame-ancestors` directive instead (via another module or
your server). This module works on Drupal 10 and 11, has no dependencies, and
defines no permissions of its own (the form uses the core *Administer site
configuration* permission).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — pick the directive and (for
   ALLOW-FROM) the allowed URI.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → X-frame-options
Configuration**
(`/admin/config/system/x_frame_options_configuration/settings`), gated by the core
*Administer site configuration* permission.

## How to use it

Enable the module, open the settings form, pick a directive (most sites want
**SAMEORIGIN**), and save. The header is applied to every page from then on. See
[Configuration](configuration/index.md).
