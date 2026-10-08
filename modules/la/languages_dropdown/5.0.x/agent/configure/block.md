<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the switcher block

There is **no module settings page**. Everything is configured on a single block instance placed
through Block Layout (`admin/structure/block`). The block plugin is `lang_drop_bootstrap`, exposed via
its deriver as one block per configurable language type — on a typical site that is
`lang_drop_bootstrap:language_interface` ("Language switcher (Bootstrap)"); if more than one language
type is configurable each gets its own labelled block.

## Placement

- Go to *Structure → Block layout*, click *Place block* in the desired region, and choose
  **"Language switcher (Bootstrap)"** (admin label from `LangDropBootstrapDeriver`).
- The block can be placed multiple times, in multiple regions.
- Requires at least two languages and a language negotiation that yields switch links
  (it renders nothing when `getLanguageSwitchLinks()` returns no links).

## Settings (block form)

Added by `LangDropBootstrapBlock::blockForm()` under a "Bootstrap settings" details group. Stored under
the block config key `languages_dropdown_bootstrap`.

| Key | Form field | Values | Default | Effect |
|---|---|---|---|---|
| `components` | "Dropdown display components" (select) | `all` (Icons and text) · `icons` (Only icons) | `all` | `icons` sets `#icon_only` TRUE → drops the `lang-lbl` label class, showing flag only. |
| `size` | "Icon Size" (select) | `xs` (Small) · `sm` (Medium) · `lg` (Large) | `xs` | Emitted as the `lang-<size>` flag class and the `btn-<size>` toggle class. |

Config schema: `block.settings.lang_drop_bootstrap:*:` → `languages_dropdown_bootstrap` mapping with
string `components` and string `size` (`config/schema/languages_dropdown.schema.yml`).

### Set from code / config

Block config YAML (`block.block.<id>.yml`) settings excerpt:

```yaml
settings:
  id: 'lang_drop_bootstrap:language_interface'
  languages_dropdown_bootstrap:
    components: icons   # or 'all'
    size: lg            # 'xs' | 'sm' | 'lg'
```

`defaultConfiguration()` seeds `languages_dropdown_bootstrap => ['components' => 'all', 'size' => 'xs']`
on top of the parent `LanguageBlock` defaults.

## Render mechanism (what the settings drive)

`LangDropBootstrapBlock::build()` (`src/Plugin/Block/LangDropBootstrapBlock.php`):

1. Reads the derivative id (the language type) and builds a `Url` from the current route match
   (falls back to `<front>`), then `language_manager->getLanguageSwitchLinks($type, $url)`.
2. Detects Bootstrap: `is_bootstrap` is TRUE when the active theme is named `bootstrap` or lists
   `bootstrap` among its base themes.
   - **Bootstrap theme** → `#theme => 'links__lang_drop_bootstrap_block'` with `#links`, `#icon` (=size),
     `#icon_only`.
   - **Non-bootstrap theme** → `#theme => 'lang_drop_bootstrap_block'` with `#languages` (a map of
     `langcode => Url`), `#size`, `#icon_only`, `#current_language`, `#set_active_class`.
3. Attaches library `languages_dropdown/main` and sets `#set_active_class = TRUE`.

The Twig templates (`templates/*.twig`) draw a `btn-group` with a `dropdown-toggle` button
(`data-bs-toggle="dropdown"`, `aria-label="Language selection"`) and a `dropdown-menu` `<ul>`; each item
is a flag `<span class="lang-<size> [lang-lbl]" lang="<langcode>">` linking to `url.toString`.

## Required external library + CDN fallback

- The flag glyphs come from **Bootstrap 5 Languages** (`danrod96-new/bootstrap5-languages`); extract it
  to `/libraries/bootstrap5-languages`. Library `languages_dropdown/bootstrap-lang` loads
  `/libraries/bootstrap5-languages/languages.css`; `main` depends on it.
- `hook_requirements` (`languages_dropdown.install`) shows a runtime warning on the status report
  (`admin/reports/status`) when that path is absent.
- `hook_page_attachments` (`LanguagesDropdownHooks::pageAttachments`): when the active theme is not
  `bootstrap` itself, it attaches `languages_dropdown/dependency-js` (only if a `bootstrap` base theme is
  present) and, on non-admin routes, `languages_dropdown/dependency-css` — both pull Bootstrap 5.3.5 from
  `cdn.jsdelivr.net` so the dropdown works on non-Bootstrap-5 themes. This 5.x branch is intended for
  Bootstrap 5 themes; the README directs other sites to the 3.0.x release.
