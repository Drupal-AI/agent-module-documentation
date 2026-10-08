<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Query carry

## What it is / when to use

- Preserves (carries forward) selected URL query-string parameters as users navigate, exposing them through tokens.
- Use to keep campaign/UTM or state parameters across internal links and redirects.
- Integrates with the Token and Token Filter modules.

---

## Install & configure

- Requires `filter`, `token`, and `token_filter`.
- Configure at `admin/config/carryquery` (route `carryquery.config`, permission `administer site configuration`).
- Define which query parameters to carry and related rules.
- Use the provided tokens in text formats (via token_filter) to emit carried values.

---

## Usage & API notes

- Provides a config form (`QredirectConfig`) storing rules in the `carryquery` config/schema.
- Carried query values are made available as tokens for use in content and links.
- Relies on `token_filter` so tokens render inside filtered text formats.
- Ships a services file and JS for client behaviour.
- Includes automated tests under `tests/`.
- No anonymous mutation endpoints — only the admin settings form.
- Menu link provided via `carryquery.links.menu.yml`.
- Parameters are read from the current request's query string.
- Useful for tracking/attribution continuity across a session's navigation.
- Combine with redirects to append carried parameters to destination URLs.
- Config permission is the core `administer site configuration`.
- No external services or network calls.
- Extend by adding parameter rules in configuration.
- Token integration means values can appear anywhere tokens are supported.
- Validate that carried parameters are sanitised where output (token_filter handles filtering).
- Uninstall removes the `carryquery` config.
