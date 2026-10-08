# Remove diacritics — manual setup guide

**Remove diacritics** (`remove_diacritics`) strips accents and diacritical marks
from text, converting characters like é, ñ, ü, and ç to their plain base letters.
It's the tool you reach for when you need **ASCII-safe strings** from accented
content — clean URL slugs, normalized search input, or transliterated values.

What sets it apart from Drupal core's built-in handling is coverage. Core only
removes accents from a narrow slice of Latin letters — about 288 characters. This
module uses **Unicode decomposition rules** to handle roughly **827 characters**,
and it adds 40 more overlaid-diacritic characters that core removes but Unicode's
own rules do not. In practice that means far fewer accented characters slip through
untransformed.

It's a small text-processing utility with no content or access role of its own, and
it depends only on Drupal core, running on Drupal 9, 10, and 11. Note the project
is currently **seeking a co-maintainer** and is in maintenance-fixes-only mode, so
treat it as stable-but-quiet rather than rapidly evolving.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration UI**. The module ships a working default character
set; a small extra set of characters lives in configuration but has no admin form
(see "How to use it").

## How to use it

Once enabled, the module's diacritic-removal capability is available to Drupal and
to other modules that build slugs or normalize text — there is nothing to click.

A couple of practical notes:

- **Reindex search after installing.** If any of your search indexes rely on
  diacritic removal, rebuild them after enabling the module so existing content is
  reprocessed with the wider character coverage.
- **Advanced: extra characters.** The 40 extra characters (and any additional
  undesired characters you want stripped) live in the `remove_diacritics.settings`
  configuration object. There is currently **no UI** for editing them, but you can
  adjust them with Drupal's single configuration import/export (at
  **Configuration → Development → Configuration synchronization**) or with Drush
  (`drush config:edit remove_diacritics.settings`). Most sites never need to touch
  this.
