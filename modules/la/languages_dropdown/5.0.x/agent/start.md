<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Languages Dropdown (Bootstrap) (languages_dropdown) — agent index

Provides a **language-switcher block rendered as a Bootstrap 5 dropdown** with country flags and/or
language labels, instead of core's flat list of links. The block plugin `lang_drop_bootstrap` extends
core's `LanguageBlock` and uses a deriver (`LangDropBootstrapDeriver`) to expose one block per
configurable language type (e.g. `lang_drop_bootstrap:language_interface`). Its `build()` fetches the
switch links with `language_manager->getLanguageSwitchLinks()`, detects whether the active theme is or
extends `bootstrap`, and renders through one of two theme hooks — `links__lang_drop_bootstrap_block`
(bootstrap themes) or `lang_drop_bootstrap_block` (non-bootstrap) — each a Twig template that draws a
`btn-group` toggle plus a `dropdown-menu`, using `lang-<size>` flag CSS classes.

The flags come from the **external Bootstrap 5 Languages library** (`danrod96-new/bootstrap5-languages`),
which must be extracted to `/libraries/bootstrap5-languages` (its `languages.css` is loaded by the
`languages_dropdown/bootstrap-lang` library); `hook_requirements` warns on the status report if it is
missing. On non-Bootstrap themes the module also pulls Bootstrap's own JS/CSS from a jsDelivr CDN
(`dependency-js` / `dependency-css`) via `hook_page_attachments` so the dropdown toggle works. All
per-instance options live in the **block's own settings form** (there is no module settings page):
`components` (icons+text vs icons only) and `size` (flag size). This 5.x release is Bootstrap-5-only —
sites on a non-Bootstrap-5 theme are told to use the 3.0.x branch instead.

- Depends on: `drupal:language` (core Language). External library: `danrod96-new/bootstrap5-languages`.
- Core: `^10.3 || ^11.1`. Package: `Multilingual`.
- No dedicated settings page / `configure` route. **Configuration is per block instance** (block-layout
  form). Provides config schema. No permissions of its own (placement gated by core `administer blocks`),
  no routes, no drush, no plugin types.
- Service `languages_dropdown.hooks` implements the module's hooks via `#[Hook]` attributes
  (`help`, `theme`, `page_attachments`, `preprocess_links__lang_drop_bootstrap_block`); the `.module`
  file keeps deprecated `#[LegacyHook]` shims that forward to it.

## What you'd do → where

- **Place the switcher block and set flag display / size** → [configure/block.md](configure/block.md)
- **Install the flag library / understand the Bootstrap CDN fallback** → [configure/block.md](configure/block.md)

## Key facts (real machine names)

- Block plugin: `lang_drop_bootstrap` (`src/Plugin/Block/LangDropBootstrapBlock.php`, extends
  `Drupal\language\Plugin\Block\LanguageBlock`), deriver `LangDropBootstrapDeriver`
  (`src/Plugin/Derivative/LangDropBootstrapDeriver.php`) → one derivative per configurable language type,
  id `lang_drop_bootstrap:<language_type>` (e.g. `lang_drop_bootstrap:language_interface`).
- Block config keys: `languages_dropdown_bootstrap.components` (`all` | `icons`),
  `languages_dropdown_bootstrap.size` (`xs` | `sm` | `lg`). Defaults: `components=all`, `size=xs`.
- Config schema: `block.settings.lang_drop_bootstrap:*:` (`config/schema/languages_dropdown.schema.yml`).
- Service: `languages_dropdown.hooks` → `Drupal\languages_dropdown\Hook\LanguagesDropdownHooks`
  (args: `extension.list.module`, `theme.manager`, `router.admin_context`, `language_manager`).
- Theme hooks: `links__lang_drop_bootstrap_block` (base hook `links`) and `lang_drop_bootstrap_block`
  (variables: `languages`, `size`, `icon_only`, `current_language`, `set_active_class`).
- Templates: `templates/links--lang-drop-bootstrap-block.html.twig`,
  `templates/lang-drop-bootstrap-block.html.twig`.
- Libraries (`languages_dropdown.libraries.yml`): `main` (own `css/languages-dropdown.css`, depends
  `bootstrap-lang`), `bootstrap-lang` (`/libraries/bootstrap5-languages/languages.css`),
  `dependency-js` and `dependency-css` (external Bootstrap 5.3.5 from `cdn.jsdelivr.net`).
- `hook_requirements` (`languages_dropdown.install`): runtime check that
  `/libraries/bootstrap5-languages` is present.
