# Custom Meta — manual setup guide

**Custom Meta** (`custom_meta`) builds on top of the
[Metatag](https://www.drupal.org/project/metatag) module to let you define your
**own** meta tags from the admin UI — no code required. Normally, adding a brand-new
`<meta>` tag to Metatag means writing a PHP plugin for it. Custom Meta removes that
step: you fill in a short form, and your tag shows up alongside all the built-in
Metatag fields on the Metatag defaults forms and on any entity's Metatag field.

Each tag you define picks one of the three standard meta attributes — **name**
(`<meta name="…">`), **property** (`<meta property="…">`, used by Open Graph and
similar), or **http-equiv** (`<meta http-equiv="…">`) — plus a machine name, a
human label, and a help description. You can also set an optional global prefix that
gets prepended to every custom tag's rendered name (handy for something like an
`og:` prefix). The tags then render through Metatag's normal output pipeline, and
empty values are automatically left out of the page.

Typical uses include search-engine or site verification tokens, a `theme-color` or
`referrer` policy tag, a social-network property Metatag doesn't ship, or any bespoke
organization-specific tag you want to standardize across a site or multisite via
exported configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it needs Metatag)
   and enable the module.
2. [Configuration](configuration/index.md) — create, edit, and delete custom tag
   definitions, set the global prefix, and the all-important cache-flush step.

## Where it lives in the admin menu

Custom Meta adds its own screen inside Metatag at **Configuration → Search and
Metadata → Metatag → Custom Meta Tags**
(`/admin/config/search/metatag/custom-meta`). Everything there is gated by the
single **Administer custom meta tags** permission.

## How to use it

Define your tags on the Custom Meta Tags overview, flush caches so Metatag picks
them up, and then set their values wherever you normally use Metatag — on the
site-wide Metatag defaults, on a content type's Metatag defaults, or on an
individual entity's Metatag field. The full walkthrough is in
[Configuration](configuration/index.md).
