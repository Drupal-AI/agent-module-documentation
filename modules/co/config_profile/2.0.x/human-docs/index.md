# Config Profile — manual setup guide

**Config Profile** (`config_profile`) helps people who build **installation profiles** and
**distributions** keep the configuration their profile ships in sync with a working site. It
solves a specific maintainer's problem: the config bundled inside a profile steadily drifts
from the config you have tuned on your development site, and re‑copying it by hand is tedious
and error‑prone. With Config Profile enabled, every time you run a configuration export it
*also* writes your changed configuration back into the install profile, in the right places.

The clever part is that it works recursively and puts each config object where it belongs.
If your profile contains its own modules, `drush config:export` updates those modules'
configuration entities inside the profile too — for example
`profiles/my_profile/config/install`, `profiles/my_profile/config/optional`, and
`profiles/my_profile/modules/my_module/config/install`. It exports only what has *changed*
relative to your site's main configuration store, and it strips UUIDs from the profile copies
so that the configuration can be imported into any site.

It depends only on core's **Configuration Manager** (`config`) and works on Drupal
`^10.3 || ^11`. This is a **maintainer's tool** — most useful while actively building a
distribution or reusable profile, and best left disabled on ordinary sites where you do not
want export to touch a profile. The current release is a **beta (2.0.0‑beta3)**.

> **Use with caution.** Because export writes config files into your profile, always review
> *where* each config entity landed before you commit. A config entity placed in the wrong
> directory (`config/install` vs `config/optional`, etc.) can break your installation
> profile.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — choose the target profile and any config to
   exclude.

## Where it lives in the admin menu

Config Profile adds a **Profile** tab to the configuration synchronization area:
**Administration → Configuration → Development → Synchronize → Profile**. That is where you
tell it which install profile to export into. After that, the actual work happens as a *side
effect* of your normal `drush config:export`.
