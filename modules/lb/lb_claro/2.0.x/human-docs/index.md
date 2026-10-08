# Layout Builder Claro — manual setup guide

**Layout Builder Claro** (`lb_claro`) restyles Drupal's Layout Builder so it
looks at home inside the **Claro** admin theme. Layout Builder's own styling
predates Claro and sits awkwardly within it — mismatched form controls,
off-canvas panels that look like the old Seven theme, media-library dialogs with
their own conventions. This module is a targeted CSS-and-render fix that makes the
builder stop looking like a different application.

It ships four stylesheets — for the layout canvas, off-canvas dialogs, entity
forms, and the media library — and wires them into the right places with a few
hooks (attaching form styling, removing core stylesheets that would otherwise
fight the Claro-matched ones, and adjusting theme hooks). An `OffCanvasRenderer`
handles the off-canvas tray specifically, giving you a nice wide tray and a
themed Media Library. There is nothing to configure: enable it and the styling
applies site-wide; uninstall it to roll back instantly.

Two things are worth knowing. It assumes **Claro is your admin theme** — with a
different admin theme the overrides fight it rather than help. And because it
removes core Layout Builder stylesheets by path, a core release that renames or
splits one of those files can silently drop an override, so re-check the builder's
appearance after minor core upgrades. The current release is an **alpha**
(`2.0.0-alpha2`) requiring **PHP 8.1**, so expect some churn.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration page and no settings** — it works entirely by
enabling it.

## Where it lives in the admin menu

Nowhere in particular — there is no settings page (`configure` is null). Once
enabled, the restyling applies automatically wherever Layout Builder appears in
the admin UI. To see it, edit any Layout Builder–enabled entity's layout with
Claro as your admin theme.
