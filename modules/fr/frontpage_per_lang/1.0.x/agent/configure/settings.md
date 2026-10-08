<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Frontpage Per Language — configure (frontpage_per_lang)

There is **no dedicated settings page**. The module extends core's *Basic site settings*
form (`/admin/config/system/site-information`, permission `administer site configuration`).

## What it adds
When more than one language is configured, `LanguageFrontPage::addLanguageFrontPageElement`
(hooked via `frontpage_per_lang_form_system_site_information_settings_alter`) adds one
**Default front page for <language>** textfield per non-default language, prefixed with the
base URL + language prefix. Values are validated (must start with `/`, must be a valid path)
and saved to `system.site` as `page.front_<langid>` (hyphens stripped from the langcode,
e.g. `page.front_ptbr`).

## How the front page is resolved
Two decorators do the runtime work:
- `PathProcessorAlter` (decorates `path_processor_front`, priority 10) rewrites an inbound
  `/` to the language-specific `page.front_<langid>` when the current content language is
  not the default.
- `PathMatcherAlter` (decorates `path.matcher`) makes `isFrontPage()` return TRUE for the
  language-specific front path so blocks/visibility keyed on "front page" behave correctly.

`hook_page_attachments` also adds `hreflang` alternate `<link>` tags for every language on
the front page.

## Setup
1. Enable Language and configure at least two languages with URL prefixes.
2. Go to *Configuration → System → Basic site settings*.
3. Fill the per-language front page path for each non-default language and save.
