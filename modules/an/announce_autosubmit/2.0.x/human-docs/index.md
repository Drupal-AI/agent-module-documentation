# A11y Announce Form Auto-Submit — manual setup guide

**A11y Announce Form Auto-Submit** (`announce_autosubmit`) is an accessibility
enhancement for forms that submit themselves automatically — the classic example being an
exposed filter that reloads results as soon as you change a selection. When such a form
auto-submits, this module shows an **ARIA-live** announcement so screen-reader users are
told what happened, and it keeps keyboard focus in place so keyboard users don't lose
their spot.

The result is that AJAX and auto-submitting forms become far friendlier to assistive
technology. The module has no content or access-control role of its own — it simply adds
the accessible announcement and focus handling. It supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## How to use it

The behaviour applies to auto-submitting forms once the module is enabled — there is no
settings screen to configure. It is especially useful on exposed-filter forms and other
AJAX-driven forms that submit without an explicit button press. After enabling, test with
a screen reader and keyboard to confirm the auto-submit announcement fires and focus is
preserved.
