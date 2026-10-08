Google Fonts provider for @font-your-face (pid `google_fonts_api`, provider name "Google Fonts"). Imports the full Google Fonts catalog into `font` entities and loads enabled families from `fonts.googleapis.com`.

---

A fontyourface provider submodule. It implements `hook_fontyourface_api()` (announcing "Google Fonts", version 3) and `hook_fontyourface_import()`, which fetches the catalog from `https://www.googleapis.com/webfonts/v1/webfonts` using an API key and saves one `font` per family/variant/subset via `fontyourface_save_font()`. Because the catalog is huge, automatic import at install is disabled — you enter a Google API key on the @font-your-face settings form (`google_fonts_api.settings:google_api_key`, added via `hook_form_FORM_ID_alter`) and click Import. At render time `hook_page_attachments()` collects the enabled Google fonts, builds a single aggregated `https://fonts.googleapis.com/css?family=…&subset=…&display=swap` request and injects it as a `<link rel="stylesheet">`. Requires the fontyourface core module.

---

- Use free Google Fonts across a Drupal site through the @font-your-face UI
- Import the entire Google Fonts catalog as searchable `font` entities
- Store and validate a Google Fonts API key on the settings form
- Enable specific families/variants/subsets and apply them via Font display rules
- Load all enabled Google fonts in one aggregated request URL (fewer HTTP calls)
- Serve fonts with `display=swap` to avoid invisible text while loading
- Pull per-subset variants (latin, cyrillic, greek, etc.) as separate font entities
- Filter the font manager by the `google_fonts_api` provider
- Combine Google fonts with self-hosted or Typekit fonts on the same site
- Refresh the catalog by re-running the import after Google adds fonts
- Disable the import button automatically until a valid API key is entered
- Map Google variant strings (400, 700italic, regular) to css style/weight
- Tag imported fonts by Google category (classification) and subset (language)
- Debug connectivity issues to googleapis.com via the import error messages
- Swap a site's typography without editing theme CSS
- Provide editors a curated set of enabled Google fonts to choose from
