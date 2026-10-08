# IntelligenceBank DAM — manual setup guide

**IntelligenceBank DAM** (machine name `ib_dam`, Composer/project name
`drupal/intelligencebank`) connects your Drupal site to the
[IntelligenceBank](https://www.intelligencebank.com/) digital-asset-management (DAM)
platform. With it, editors can pull assets from your IntelligenceBank account into
Drupal — either importing the file into local media storage, or embedding a public
CDN link to it — straight from the Media Library and CKEditor. It's aimed at
organisations that keep their brand assets in IntelligenceBank and want to reuse them
across one or more Drupal sites without copying files around by hand.

The base `ib_dam` module is mostly **plumbing**: a global settings form for the
connection (debug/staging flags, an "allow embedding" toggle, and the login /
Platform-URL defaults including browser-based SSO login), an API service that talks
to IntelligenceBank using a session id, a downloader, an internal asset model, a link
formatter for embedded assets, and a pluggable **asset-validation** system. On its
own, the base module does little that's visible to editors — the actual integration
surface comes from a submodule. You almost always enable **`ib_dam_media`**, which
adds a Media source and media type plus an in-modal IntelligenceBank asset browser
inside the core Media Library. A second, **deprecated** submodule,
**`ib_dam_wysiwyg`**, is a legacy CKEditor filter that is a no-op in 5.x and removed
in 6.0 — don't enable it on new sites.

Actually talking to IntelligenceBank requires real platform credentials/SSO
configured against your IntelligenceBank account; the module authenticates with your
IB **session id**, and stores no API key of its own. It defines one permission,
*Administer intelligencebank configuration*, provides its own config and an
asset-validation plugin type, and has no hard module dependencies (you add
`ib_dam_media` for Media integration).

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and choose the submodule you need.
2. [Configuration](configuration/index.md) — the global settings form, the
   permission, and connecting to IntelligenceBank.

## Where it lives in the admin menu

- Global settings: **Configuration → Web services → IntelligenceBank DAM**
  (`/admin/config/services/ib_dam`), gated by *Administer intelligencebank
  configuration*.
- With `ib_dam_media` enabled, its media-type mapping form is at
  `/admin/config/services/ib_dam/media` (same permission).

## How to use it

1. Install the package and enable the base `ib_dam` module **plus `ib_dam_media`**
   (the Media Library integration).
2. On the settings form, enter your IntelligenceBank Platform URL and login/SSO
   defaults, and decide whether to allow CDN embedding.
3. Editors then browse and pick IntelligenceBank assets from within the core Media
   Library add flow — importing them locally or embedding a CDN link.

See [Configuration](configuration/index.md) for each setting.
