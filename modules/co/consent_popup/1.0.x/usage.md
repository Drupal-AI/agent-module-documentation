<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Consent Popup provides a single configurable block that shows a full-screen consent/age-gate popup with Accept and Decline buttons, remembering the choice in a browser cookie. It is a self-contained banner, not a consent-management framework.

---

The whole module is one Block plugin (`consent_popup`), a Twig template, a stylesheet and a small jQuery behaviour; all settings live in the block instance, so there is no routes, no permissions and no dedicated settings page. When placed, the block renders a fixed full-screen overlay (the site body gets `overflow: hidden`) containing the configured message text, an Accept button, a Decline button and a hidden "keep browsing" link. Text fields are provided **per language** (popup text, declined text, accept/decline labels, decline URL and its link text), plus site-wide options for cookie name, cookie lifetime in days, overlay background colour and opacity, and a comma-separated list of CSS selectors to blur while the popup is open. Behaviour is driven client-side from `drupalSettings`: on Accept the cookie is set to `true` and the overlay closes; on Decline the module either redirects to the decline URL, or replaces the message with the "declined" text and shows the link, and (unless "Non blocking" is enabled) keeps the overlay up so the page stays blocked. A `true` cookie suppresses the popup on subsequent visits for the configured number of days. It is important to be clear about what this is **not**: it is a notice/gate, not a consent manager — it does not withhold or defer third-party tracking scripts, so on a site that runs analytics or marketing tags it does not by itself satisfy GDPR/ePrivacy consent; a manager such as Klaro or Orejime is needed there. Note the info.yml `core_version_requirement` contains a typo (`^10 | ^11`, single pipe) which still parses. The admin message text is passed through `Xss::filterAdmin()` before rendering.

---

- Put an age-gate ("Are you an adult?") in front of a site, blocking the page until the visitor accepts.
- Show a first-visit terms/policy acknowledgement that the visitor must accept.
- Present a simple essential-cookies notice on a site with no third-party tracking.
- Block access on decline and redirect the visitor to another page.
- Block access on decline but keep the visitor on the page with a "declined" message and a "keep browsing" link.
- Let the visitor dismiss and continue by enabling "Non blocking" (decline still records the choice but allows the page).
- Remember the accept/decline choice in a named cookie for a configurable number of days.
- Provide fully translated popup text and button labels per language.
- Customise the accept and decline button labels (e.g. "Yes"/"No", "I agree"/"Leave").
- Set the URL and link text shown after a decline (internal path or external URL).
- Blur specific page elements (via CSS selectors) behind the popup while it is open.
- Tint the full-screen overlay with a chosen background colour and opacity.
- Place the notice in any block region and restrict it with standard block visibility conditions.
- Export the notice and all its wording as part of block configuration.
- Announce a policy change or migration with a one-time modal on first visit.
- Add a lightweight modal banner without pulling in a JavaScript consent library.
- Theme the popup by overriding its Twig template and CSS variables.
- Show a maintenance or relocation notice that visitors must acknowledge.
- Gate downloadable/age-restricted content behind an acceptance click.
- Reset the notice for everyone by changing the cookie name.
- Provide a strictly-necessary-cookies statement to accompany a privacy policy.
