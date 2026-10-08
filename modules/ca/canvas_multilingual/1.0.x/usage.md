<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Canvas Multilingual makes Drupal Canvas work on a translated site — language-prefixed URLs, autosave that respects translation, preview title fallbacks, translation guards and a language switcher in the editor.

---

Its description is unusually informative, and reading it as a list of bugs is the right way to understand what the module is: language-prefixed URLs, an *autosave translation fix*, a preview title *fallback*, translation *guards*. Each of those names something that does not work correctly when a page builder meets translations, which is the recurring story of visual editors in Drupal — layout is stored per entity, translations are separate entities, and every editor has to decide what a layout means across languages.

That makes this the module to install if Canvas is going onto a multilingual site, and the thing to read if a Canvas page is behaving oddly in a second language.

The `lifecycle: experimental` marker and a beta release are both worth stating plainly: this is active work on a hard problem, not a settled integration. On a multilingual project, verify the specific behaviours you depend on — whether a layout is shared or per-language, what an autosave in one language does to another, and what a translator sees in preview — rather than assuming any of them.

**Documented from source: `canvas` could not be kept enabled on this install.** Its
`SingleDirectoryComponentDiscovery` runs `ComponentMetadataRequirementsChecker` over **every** SDC
component on the site, and where a component's prop example maps to a field-type property expression
that does not resolve, `assert($property !== NULL)` fails. With `zend.assertions` on — the default
in DDEV and most development images — that is an uncaught `AssertionError` during container build,
so site and Drush both stop.

That was first characterised in wave 85 against `flowdrop_ui_components` and `lms`; it recurred here
against an entirely different module set, which confirms it is a property of Canvas meeting **any**
third-party SDC components rather than of one wave's particular modules. Production PHP compiles
assertions out, so it is a development-environment failure — but that is where the work happens.

---

- Run Canvas on a multilingual site.
- Get language-prefixed URLs in the editor.
- Fix autosave behaviour across translations.
- Provide a preview title fallback.
- Guard against cross-translation edits.
- Add a language switcher to the editor.
- Decide whether layout is shared or per-language.
- Check what autosave in one language does to another.
- See what a translator sees in preview.
- Verify behaviours rather than assuming them.
- Evaluate an experimental beta.
- Diagnose a Canvas page misbehaving in a second language.
- Check zend.assertions before installing canvas locally.
- Plan a multilingual page-building strategy.
- Document the module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
