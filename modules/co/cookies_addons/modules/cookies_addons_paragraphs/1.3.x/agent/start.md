<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Paragraphs (cookies_addons_paragraphs) — agent index

Submodule of **Cookies Addons**. Gates **Paragraphs entities** (by paragraph id) behind a COOKiES
consent service. Package COOKiES. Core `^9.2 || ^10 || ^11`. Depends on `cookies:cookies` and
`paragraphs:paragraphs`. License GPL-2.0-or-later. Version 1.3.3.

- **Config, route, hook and mechanism** → [config/settings.md](config/settings.md)

## What it provides

- Hook `cookies_addons_paragraphs_preprocess_paragraph()` (`cookies_addons_paragraphs.module`) —
  swaps a restricted paragraph's `#content` for a placeholder `<div>` and attaches the JS library.
  `_cookies_addons_paragraphs_get_service($id)` returns FALSE on POST else delegates to
  `_cookies_addons_paragraphs_is_restricted($id)`, which parses
  `cookies_addons_paragraphs.settings:paragraphs` (`preg_split` newlines, `explode('|')`, exact id
  match).
- Controller `CookiesAddonsParagraphsController::getParagraph($paragraph_id, $service)`
  (`src/Controller/CookiesAddonsParagraphsController.php`) — loads the `paragraph` entity, renders it
  with the `paragraph` view builder, returns an `AjaxResponse` with a `ReplaceCommand` on
  `.cookies-addons-paragraph-placeholder[data-cookies-service][data-paragraph-id]`.
- Form `SettingsForm` (`src/Form/SettingsForm.php`) — one textarea `paragraphs`, writes
  `cookies_addons_paragraphs.settings`.
- Routes: `cookies_addons_paragraphs.get_paragraph` (POST, `access content`);
  `cookies_addons_paragraphs.settings` (`administer site configuration`).
- Config schema `cookies_addons_paragraphs.settings` (`paragraphs: text`). Library
  `cookies_addons_paragraphs/cookies-addons-paragraphs`. Menu/task links under the COOKiES config
  group.
- No permissions, services, plugins, Drush.

Privacy/consent gate, not access control.
