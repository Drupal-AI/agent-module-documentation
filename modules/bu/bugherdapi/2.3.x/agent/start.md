<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bugherd API (bugherdapi) — agent index

Embeds **BugHerd's visual feedback overlay** — reviewers click an element and comment; the tool
captures URL, browser, viewport and a screenshot.
Configure at `/admin/config/system/bugherd`. Version **2.3.0**.
Core **`^11 || ^12`** — current Drupal only. Permission: `administer bugherd`.

**Decide who sees the overlay before enabling.** Loaded for everyone it shows a floating widget to
real visitors and puts a third-party script on every page. Usual arrangement: authenticated users,
a specific role, or non-production only.

**It reads the page** — that is how screenshot capture works. The BugHerd account is inside the
site's trust boundary, and the tool sees whatever a reviewer sees, including personal data on
authenticated screens.