<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Response Code Conditions

Response Code Conditions adds a **Response code** condition plugin to Drupal's condition system,
usable anywhere conditions are — most commonly for block visibility. It evaluates true when the
current request carries an exception whose HTTP status code matches one of the configured codes
(one per line). The maintainers note it is intended for **4xx** codes (e.g. 401, 403, 404).

This lets site builders place blocks that only appear on error pages, or conversely hide blocks
on them, without custom code.

---

## Installation & configuration

- Install with `drush en response_code_condition`.
- On a block's *Visibility* tab (or any condition UI), open **Response code** and enter the
  status codes to match, one per line.
- The condition reads the response code from the current request's `exception` attribute, so it
  matches on error responses (4xx) rather than normal 200 pages.
- Use the standard *Negate* option to invert the match (show everywhere except those codes).

---

## Use cases

- Show a custom "page not found" help block only on 404 pages.
- Display a support/contact block on 403 access-denied pages.
- Present a login prompt block specifically on 401 responses.
- Hide marketing blocks on error pages via negation.
- Add tailored messaging for different 4xx codes.
- Provide a search block on 404 pages to help lost visitors.
- Surface a sitemap or navigation aid on error pages.
- Show a "report a problem" block only when errors occur.
- Keep error pages clean by suppressing standard sidebars.
- Combine with other conditions for precise error-page layouts.
- Differentiate 403 vs 404 messaging with separate blocks.
- Reuse the condition wherever Drupal conditions are supported.
- Avoid custom preprocess code for error-page block logic.
- Improve UX on access-denied pages with contextual help.
- Add analytics/notice blocks scoped to error responses.
- Configure multiple codes in one condition instance.
