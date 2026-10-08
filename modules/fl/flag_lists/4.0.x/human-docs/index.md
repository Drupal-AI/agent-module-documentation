# Flag Lists — manual setup guide

**Flag Lists** (`flag_lists`) builds on the
[Flag](https://www.drupal.org/project/flag) module to let each user create their
own named **lists** of flagged content. It's the difference between a single,
global "Bookmarks" flag and letting a visitor keep their own "Reading list",
"Gift ideas", and "For work" — as many private, named collections as they want.

Plain Flag gives you flag types (bookmark, favourite, report), each a single
on/off relationship between a user and an entity. That answers "did this user
bookmark this?" but not "which of this user's *lists* is it on?". The multi‑list
case — wishlists, playlists, curated collections — is common enough that
Flag Lists provides it as a reusable layer instead of rebuilding it per project.

Here, a site administrator turns a flag into a **template**, and each user creates
as many lists as they like from that template and flags content into any of them.
The lists are real Drupal entities with revisions, and the module integrates with
**Views**, so you can render and list a user's collections like any other content
— useful for a "my wishlists" page, a shopping‑cart integration, or an email
digest. A submodule, **Flag Lists Actions** (`flag_lists_actions`), adds actions
around the lists.

> **Install note:** pin to release **4.0.3**. Release **4.0.4** ships a malformed
> dependency manifest that breaks Composer installation — see
> [Installation](installation/index.md) for details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (pinned to 4.0.3), enable it (with Flag and Views), and optionally add the
   actions submodule.
2. [Configuration](configuration/index.md) — the settings and list templates,
   plus the permissions that decide who can create and view lists.

## Where it lives in the admin menu

- **Settings:** **Configuration → Flag Lists** (`/admin/config/flag_lists`).
- **List templates:** **Structure → Flag Lists**
  (`/admin/structure/flag_lists/flag_for_list`), where you designate the flag(s)
  that act as templates for user‑created lists.
- **A user's lists:** each user sees their own lists on their account pages.
