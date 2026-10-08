<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
String Overrides replaces any translatable interface string on the site with your own text, per language, from a single admin form — without editing code or using the full Locale/translation workflow.

---

The module registers a `string_translator` service (`StringOverridesTranslation`, priority 15) that extends core's `StaticTranslation`. Whenever Drupal translates a string through `t()` / `TranslatableMarkup`, this translator is consulted and returns your override if one matches the source string (and optional context). Overrides are edited at `/admin/config/regional/stringoverrides/{language}` (the `configure` route redirects to the default language) as a table of Enabled / Original / Replacement / Context rows, and are stored in a per-language config object `stringoverrides.string_override.<langcode>` under a `contexts` structure. Enabled overrides live in that config; disabled rows are kept separately in `stringoverrides.string_override.<langcode>_disabled` so you can toggle them without retyping. The active translations for a language are cached under the cache id `stringoverides:translation_for_<langcode>` and the cache entry is cleared on save. Matching is exact on the source string; most overrides use an empty context, but you can supply a context to disambiguate strings that Drupal translates with one. It needs the `administer string overrides` permission and works on monolingual and multilingual sites alike.

---

- Rename "Log in" to "Sign in" across the whole site without touching code or templates.
- Change the default "Add to cart" button label on a Commerce site.
- Relabel core UI text like "Save", "Submit", or "Home" to match your brand voice.
- Reword a confusing core message into clearer language for your editors.
- Localize a single string differently per language from one admin screen.
- Override a contrib module's hard-coded English string you cannot otherwise edit.
- Fix a typo in a module's interface text quickly, pending an upstream patch.
- Change "Comments" to "Reviews" (or "Discussion") site-wide.
- Adjust field or form labels that come from `t()` calls you don't control.
- Provide friendlier empty-state or error text on public-facing forms.
- Temporarily disable an override without deleting it, then re-enable it later.
- Keep a library of prepared overrides that editors can toggle on and off.
- Translate strings for a language that has no full translation import yet.
- Use a context to override one specific occurrence of an ambiguous word (e.g. "May").
- Standardize terminology (e.g. "User" → "Member") throughout the interface.
- Soften or rephrase legal/consent wording produced by other modules.
- Rebrand admin toolbar or menu text for a client handover.
- Change pager or "Read more" link text globally.
- Adjust wording in registration/login flows to match a marketing tone.
- Deploy overrides via exported config (`stringoverrides.string_override.<langcode>`) across environments.
- Replace verbose core help text with a shorter in-house phrasing.
- Quickly A/B different button wording by toggling override rows.
- Apply consistent capitalization or punctuation conventions to interface strings.
- Override strings only for the default language while leaving others untouched.
- Correct gendered or outdated terminology across the UI in one place.
