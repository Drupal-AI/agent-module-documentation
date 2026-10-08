# Social Link Field — manual setup guide

**Social Link Field** (`social_link_field`) provides a multi‑value field type for
storing links to social‑media profiles — Facebook, X/Twitter, Instagram,
LinkedIn, YouTube, and around twenty more — together with a widget for entering
them and formatters for displaying them as Font Awesome icons or as plain
network‑name text links. It is the tidy way to collect a "Follow us" set of
profiles on a content type, a user profile, or a footer block, instead of juggling
a separate URL field per network.

Each value in the field stores two things: the **platform** (a network id such as
`facebook` or `twitter`) and the **link** (the profile URL or handle). The list of
available platforms is pluggable — each network is a small plugin carrying its id,
name, Font Awesome icon codes, and the URL prefix/suffix used to build the final
link — so adding a new network like Mastodon or Bluesky is just a matter of
dropping a plugin class into a custom module.

For editors, the widget lets them pick a platform and paste in the profile, with
options to lock the network choice (so they only fill in the URL for pre‑set
networks) and to disable reordering. For display, one formatter renders Font
Awesome icons — common or square, laid out vertically or horizontally, optionally
opening in a new tab — and another renders each platform's name as a text link.
A single global setting controls whether the module loads its own Font Awesome
library.

This guide is written for a **human** setting the field up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add a Social Links field, choose the
   widget and formatter, and set the global Font Awesome option.

## Where it lives in the admin menu

You add and configure the field on each bundle's **Manage fields**, **Manage form
display**, and **Manage display** pages. The one global setting lives at
**Configuration → Web services → Social Link Field**
(`/admin/config/services/social-link-field`), gated by the **Configure social link
field** permission.

## How to use it

Add a **Social Links** field to the bundle where you want to record profiles,
choose how editors enter them and how they display, and — if your theme already
ships Font Awesome — turn off the module's bundled library to avoid loading it
twice. See [Configuration](configuration/index.md) for the walkthrough.
