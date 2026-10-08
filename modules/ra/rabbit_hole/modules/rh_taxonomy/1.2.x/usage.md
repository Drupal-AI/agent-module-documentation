Registers taxonomy terms with Rabbit Hole so you can control what happens when a term is viewed at its canonical `/taxonomy/term/*` page — display, access denied, page not found, or redirect — per vocabulary or per term.

---

`rh_taxonomy` is the Rabbit Hole submodule for core Taxonomy. Enabling it registers a Rabbit Hole entity plugin for the `taxonomy_term` entity type, adding the "Rabbit Hole settings" vertical tab to vocabulary edit forms and (when overrides are allowed) individual term edit forms. Term pages are a classic source of thin, duplicative content — often terms exist only to filter or tag, not to have their own page — so this submodule is widely used to 404 or redirect them. All behavior logic, redirect codes, tokens, and fallbacks come from the base `rabbit_hole` module; this submodule only wires up term support. It depends on `rabbit_hole` and core `taxonomy`.

---

- Return 404 for tag term pages that only exist to label content.
- Redirect a vocabulary's term pages to a Views listing of tagged content.
- Set a per-vocabulary default behavior, overridable per term.
- Deny access to internal/administrative vocabulary term pages.
- Redirect a term page to a curated landing page with a 301.
- Hide thin term pages from search engines to consolidate SEO.
- Redirect using a token such as `[term:field_link]`.
- Return "page not found" instead of "access denied" to hide existence.
- Override the vocabulary default on a specific popular term.
- Configure a fallback action for empty/invalid redirect targets.
- Redirect legacy term URLs to new taxonomy structure with 301s.
- Let editors bypass the action to preview the real term page.
- Grant a role permission to administer Rabbit Hole on terms only.
- Send category term pages to a Commerce catalog view.
- Redirect a term page to `<front>`.
- Keep "system" vocabularies from exposing standalone term pages.
- Use a temporary 302 redirect for a term during a site reorg.
- Prevent term pages from resolving on a headless site.
