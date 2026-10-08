# Google AdWords Lite — manual setup guide

**Google AdWords Lite** (`google_adwords_lite`) is a small, focused module for
adding **Google Ads (formerly AdWords) conversion tracking** to your site. You
enter your conversion identifier, and the module injects the Google Ads tracking
snippet into your pages — without the weight and configuration of a full analytics
suite.

It is deliberately minimal: if all you need is to fire a Google Ads conversion tag
so you can measure campaign performance, this does that one job. It provides its
own admin settings form and its own permission for managing that form.

Because this loads Google's tracking code and can set cookies in visitors'
browsers, it carries **privacy and consent implications**. Pair it with a
cookie-consent mechanism and disclose the tracking in line with the laws that apply
to your audience. The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Google Ads conversion
   details and handle consent.

## Where it lives in the admin menu

The settings form is the module's admin settings page (route
`google_adwords_lite.admin_settings_form`), reachable by users with the module's
own administration permission. See [Configuration](configuration/index.md) for what
to enter.
