# Contact Map — manual setup guide

**Contact Map** (`contactmap`) places a small, **draggable floating contact
widget** on the front end of your site. Visitors see a circular map "pin" object;
clicking it opens a Google map with your address and a click‑to‑call phone number.
Because it floats on every page and can be dragged wherever the visitor likes, it's
aimed at **lead‑generation sites** that want a persistent, always‑reachable way for
people to get in touch. It has no module dependencies beyond core.

Everything is driven from a single admin settings form: you enter a Google Maps
JavaScript API key, a phone number, a postal address, and the map's latitude and
longitude. When the active theme matches the theme you configured, the module
attaches its JavaScript library on every page and passes those settings to the
browser, which draws the map/pin and makes the widget draggable. Switching the
active theme is effectively how you turn the widget on or off.

The module needs a **Google Maps JavaScript API key** to render the map — the key
is a client‑side key exposed to the browser, which is normal for embedded Google
maps. The phone number is validated on save (it must be the right length and match a
numeric/`+` pattern). The project is covered by Drupal's security advisory policy,
and the only route it adds is the permission‑gated settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, field by field
   (API key, phone, address, coordinates, theme).

## Where it lives in the admin menu

Contact Map's settings form is at **Configuration → User interface → Contact Map**
(`/admin/config/user-interface/contact-map`), behind the **Administer site
configuration** permission. The widget itself appears on front‑end pages once the
form is filled in and the active theme matches the configured theme.
