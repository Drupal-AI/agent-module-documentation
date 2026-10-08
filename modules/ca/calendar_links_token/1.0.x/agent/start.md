<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calendar Links Tokens (calendar_links_token) — agent index

A **token-only** module: it exposes one dynamic token that renders an "add to calendar" HTML block
(Google, Yahoo, Outlook.com links + a generated `.ics` file download) for an event. No routes, no
forms, no permissions, no config, no admin UI, no plugins. Core `^10.2 || ^11 || ^12`. License
GPL-2.0-or-later. Version 1.0.0.

- **The token, its parameter grammar, field-vs-literal resolution, and the generated output** →
  [api/tokens.md](api/tokens.md)

## What it actually is

- Two hooks in `calendar_links_token.module`:
  - `calendar_links_token_token_info()` — declares token **type** `calendar_links` and one
    **dynamic** token `calendar_links:parameters` (the arguments after `parameters:` are appended
    to the token).
  - `calendar_links_token_tokens()` — for `$type == 'calendar_links'`, strips the `parameters:`
    prefix from each token name and calls the helper `_calendar_links_token_generate_links()`,
    wrapping the returned HTML in `Markup::create()`.
- Helper `_calendar_links_token_generate_links($parameters)` does all the work (see the solution doc).
- Composer dependency: **`spatie/calendar-links: ^1.4`** (`Spatie\CalendarLinks\Link`). No Drupal
  module dependencies, no `libraries[]`, no config schema, no `.install`, no `src/`.

## Token grammar

`[calendar_links:parameters:nid|start|end|title|description|location]` — exactly **6**
pipe-separated arguments (first is the node id; the other five are each interpreted as a **field
name on that node**, or, if the node lacks that field, as a **literal string**). Full details,
datetime handling, and the emitted markup in [api/tokens.md](api/tokens.md).

## Requirements / operation

- Enable with `drush en calendar_links_token`. Requires the `spatie/calendar-links` library, pulled
  in via Composer when the module is required with Composer.
- Nothing to configure. Place the token anywhere token replacement runs — the documented sweet spot
  is a webform event-registration confirmation/notification email.
