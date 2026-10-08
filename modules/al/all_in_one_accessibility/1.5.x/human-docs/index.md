# All in One Accessibility® — manual setup guide

**All in One Accessibility®** (`all_in_one_accessibility`) adds a floating
accessibility toolbar to your Drupal site — the kind of widget that lets visitors
turn on a screen reader, adjust contrast, zoom text, and pick accessibility
profiles, aimed at improving your posture toward ADA, WCAG 2.1, and Section 508.
It's a no‑code way to put a visible accessibility affordance on every page, which
teams often reach for ahead of an audit or to meet a legal requirement.

It's important to understand what this module actually is: a thin **integration**
around a hosted, third‑party widget from Skynet Technologies. The module itself
doesn't implement the accessibility features — it configures and injects a
`<script>` served from `skynettechnologies.com` onto every page. The toolbar's
capabilities (140+ languages, voice navigation, profiles, and so on) come from
that remote widget, and the full/paid feature set requires a **licence token**
from the vendor. On install, the module also registers your site's domain with the
vendor's API (an outbound call). If you'd rather not load third‑party JavaScript or
share your domain with an external service, weigh that before enabling it.

Everything you can control locally is appearance and licensing: the licence token,
the button's colour, its corner position (or a custom pixel offset), size, icon
style, and a link to your accessibility statement. All of it lives on a single
settings page and applies site‑wide — no block placement needed. The module has no
other Drupal dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.
2. [Configuration](configuration/index.md) — the settings page: licence token,
   colour, position, size, and icon options.

## Where it lives in the admin menu

Its settings form is at **Configuration → Development → All in One Accessibility**
(`/admin/config/development/all-in-one-accessibility/ada_compliance`), reachable by
users with the **All in One Accessibility settings** permission ("Add ADA
Tool/Script all over the site").

## How to use it

1. Enable the module and grant yourself the settings permission.
2. Open the settings page and, if you have one, paste your Skynet Technologies
   **licence token** to activate the paid widget (leave it blank for the free
   version).
3. Adjust the appearance — colour, corner position, size — to fit your theme and
   avoid clashing with any existing chat button.
4. Save. The accessibility toolbar then appears on every page of the site.
