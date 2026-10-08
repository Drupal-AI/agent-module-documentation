<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a Drupal token that renders an embeddable Drupal Forge launch widget for a given template id.

---

Drupal Forge Token is a tiny, dependency-free module that adds a single dynamic token group, `drupalforge`, to Drupal's token system. Any numeric token under that group — for example `[drupalforge:71]` — is replaced with a `<webform-component>` custom-element tag pointed at `https://www.drupalforge.org` and the bundled JavaScript library. In the browser that element fetches the Drupal Forge "starshot-quickstart" launch webform for the requested template id and embeds it inline, so a visitor can spin up a live demo of a Drupal template directly from your page instead of first navigating to drupalforge.org. It works on Drupal 8 through 11 (`core_version_requirement: 8 - 11`), has no settings form, no permissions, and no PHP or external Composer requirements.

---

- Embed a Drupal Forge launch widget on any page by placing a `[drupalforge:<template-id>]` token.
- Add a one-click "launch a demo" widget to module or product documentation pages.
- Let visitors start a live Drupal CMS trial from a marketing / landing page.
- Show a specific Drupal Forge template's quickstart form by numeric template id (e.g. `[drupalforge:71]`).
- Turn a token-aware text field into a live launch-widget host.
- Provide try-it links for a distribution or recipe you maintain.
- Insert launch widgets into token-aware blocks, node bodies, or field values that render markup.
- Reuse the same launch widget markup across many pages via a single token.
- Offer readers a countdown-tracked provisioning experience without hand-writing embed markup.
- Surface the Drupal Forge submission/quickstart flow (username, password, captcha) inline on your own site.
- Auto-resume a visitor's in-progress Drupal Forge application via the cookie the widget sets per template.
- Keep launch markup consistent by centralizing it in a token instead of copy-pasted HTML.
- Point at different Drupal templates on different pages by varying the numeric token.
- Add launch widgets to token-supporting contrib fields (e.g. any field rendered through token replacement).
- Ship demo-launch capability with no configuration step beyond enabling the module.
- Support Drupal 8, 9, 10, and 11 sites with the same token.
- Attach the Drupal Forge web-component behavior automatically wherever the token is used.
- Provide a lightweight alternative to iframes for embedding the Drupal Forge quickstart flow.
- Let documentation authors drop in a demo launcher without touching theme code.
