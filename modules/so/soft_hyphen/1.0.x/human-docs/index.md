# Soft hyphen — manual setup guide

**Soft hyphen** (`soft_hyphen`) enables soft hyphens (`&shy;`) in plain-text field
output, and provides a Twig filter for adding them in templates. A soft hyphen is
an invisible break point: it lets a long word wrap gracefully at a sensible place
on a narrow screen, without showing a hyphen when the word does not need to break.
It runs on Drupal 9, 10 and 11.

The problem it solves is typographic. Long compound words — common in some
languages — and narrow columns often produce ugly overflow or awkward wrapping.
Inserting soft-hyphen markers tells the browser where a word may break if it has
to, improving readability without changing how the word looks when there is room.
Importantly, the module affects **rendering only**: your stored field value is
untouched, and it has no access-control role.

There is nothing to configure on a settings page — the module works by applying
its field formatter where you want plain-text output soft-hyphenated, or by using
its Twig filter in a template. This makes it a small, focused display helper
rather than a configurable subsystem.

This guide is written for a **human** applying the formatter and filter through
the admin UI and templates. If you want terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There are two ways to apply soft hyphenation, and neither needs a settings page:

- **On a field's display.** Go to **Structure → Content types → [your type] →
  Manage display** (or the Manage display tab of any entity type), and choose the
  module's soft-hyphen formatter for the plain-text field you want hyphenated.
  Rendered output for that field then carries soft-hyphen break points.
- **In a template.** Use the module's Twig filter on a string in your theme's
  template to insert soft hyphens where the text is output.

Either way, the underlying stored value is unchanged — the soft hyphens exist only
in the rendered markup, so long words break cleanly in narrow columns and on small
screens while looking normal when there is space.
