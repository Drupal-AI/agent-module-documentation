<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Metatag Webform lets you set per-webform meta tags (title, description, Open Graph, etc.) so a Webform's canonical page can carry its own SEO/social metadata, which core Metatag otherwise only supports for content entities.

---

The module bridges the Webform and Metatag modules. It adds a **Metatags** secondary tab to each webform's Settings (route `metatag_webform.settings_form` at `/admin/structure/webform/manage/{webform}/metatags`), reusing Metatag's own defaults form via a subclass (`MetatagWebformDefaultsForm extends MetatagDefaultsForm`) so you get the full tag UI (Basic, Open Graph, Twitter cards, …) minus the "type" selector. Saving stores the values as a **`metatag_defaults` config entity** whose id is `webform.<webform_id>` (label `Webform: <title>`, status controllable). At render time `hook_metatags_alter()` checks whether the current route is the webform canonical page and, if an enabled `webform.<id>` defaults entity exists, merges its `tags` into the page's metatags. It cleans up after itself: `hook_entity_delete()` removes the `webform.<id>` defaults when a webform is deleted, and `hook_uninstall()` deletes every `webform.*` metatag defaults entity. It has **no global settings page, no permissions of its own** (access is gated by Webform's `update` permission on the webform via `_entity_access: webform.update`), no Drush commands, no services, and no config schema of its own (it reuses Metatag's `metatag_defaults` schema).

---

- Give a "Contact us" webform its own SEO title and meta description.
- Add Open Graph tags so a shared webform link shows a proper title/image/description on social media.
- Set Twitter card metadata for a survey page.
- Override the canonical URL meta tag on a specific webform page.
- Provide a keyword meta description for a lead-generation form to improve search snippets.
- Localize/curate the browser tab title of a webform independently of its heading.
- Add `robots` meta directives (e.g. noindex) to an internal-only webform.
- Configure per-webform metadata without touching global Metatag defaults.
- Ensure a newsletter-signup webform has share-friendly social preview cards.
- Set structured meta for an event-registration webform.
- Manage a job-application form's SEO metadata from the webform's own Settings tab.
- Keep webform SEO config in code by exporting the `metatag.metatag_defaults.webform.<id>` config.
- Present distinct social images for different campaign webforms.
- Suppress default site metatags on a webform by overriding them at the webform level.
- Give a multi-step webform a concise meta description for search engines.
- Add author/publisher meta to a feedback form page.
- Improve click-through by customizing the search-result title of a popular webform.
- Roll metadata out per webform as part of a marketing landing-page build.
- Remove stale webform metadata automatically when the webform is deleted.
- Audit which webforms have custom metatags by listing `webform.*` metatag_defaults entities.
- Set a fixed description tag on a GDPR/consent webform.
- Differentiate meta titles between a "Contact sales" and "Contact support" webform.
- Apply Open Graph locale/type tags to a region-specific webform.
- Standardize social preview metadata across all customer-facing webforms.
