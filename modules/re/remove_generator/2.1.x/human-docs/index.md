# Remove Generator — manual setup guide

**Remove Generator** (`remove_generator`) does exactly one small hardening job:
it strips the `<meta name="Generator" content="Drupal …">` tag that Drupal core
adds to the `<head>` of every page. By default, a stock Drupal site publicly
announces "Drupal 11 (https://www.drupal.org)" in its HTML source. That's a minor
fingerprinting and version‑disclosure signal, and some site owners — or their
penetration testers — prefer not to advertise which CMS (and which version) the
site runs. Enable this module and the tag disappears site‑wide; uninstall it and
core puts the tag back.

There is genuinely **nothing to configure**: no settings form, no permissions, no
configuration schema, and no dependencies. The entire module is a single hook
that removes the one meta tag. That also makes it a handy A/B check — disable it
and reload to confirm the tag is core‑added.

One thing to be clear about: this removes only the **HTML meta tag**. It does not
change the `X-Generator` HTTP response header or other Drupal fingerprints, so
treat it as one small part of a broader hardening effort (pair it with server‑side
header hardening if disclosure via headers also matters to you).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — Remove Generator has no admin page and no settings. It works purely by
being enabled.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. That's it. View any page's source and the `<meta name="Generator">` tag is
   gone. To bring it back, simply uninstall the module.
