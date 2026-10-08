<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailchimp webform handler is a Webform handler plugin that, when a form is submitted, adds the submitter to a chosen Mailchimp list/audience via the Mailchimp Marketing API.

---

The module registers a single Webform handler (`@WebformHandler` id `mailchimp_webform_handler`, category *Transaction*) that you attach to any webform under its *Emails / Handlers* tab. In the handler settings you paste a Mailchimp API key and server prefix (e.g. `us19`), press *Update Mailchimp lists* to pull your audiences over the API, pick a list, then map the webform's own elements onto Mailchimp's `EMAIL` and the list's merge fields. On each submission the handler calls `lists->addListMember()` (via the official `mailchimp/marketing` PHP SDK) to add the mapped email and merge-field values to that audience with status `subscribed`. Handler cardinality is unlimited, so several handlers — each with its own API key, account and list — can be added to one form and switched on/off with Webform's conditional handler settings (for example, subscribing to a different audience per country or language). It depends only on the Webform module (`^6.2`) and the `mailchimp/marketing` Composer library (`^3.0`), ships no permissions, routes, services or config schema of its own, and forwards personal data to a third-party marketing service, so it should only be used with appropriate disclosure and consent.

---

- Add newsletter signups collected through a webform to a Mailchimp audience.
- Subscribe contact-form submitters to a mailing list automatically.
- Capture marketing leads from a landing-page form into Mailchimp.
- Map a webform email element to Mailchimp's required `EMAIL` field.
- Push extra webform fields (first name, last name, phone) into Mailchimp merge fields.
- Grow a Mailchimp list directly from a Drupal site without the full Mailchimp suite.
- Attach several handlers to one form to subscribe to different audiences at once.
- Route submissions to different Mailchimp accounts per language using per-handler API keys.
- Switch a Mailchimp subscription on or off with Webform conditional handler logic.
- Subscribe registrants of an event webform to a follow-up audience.
- Feed a "request a demo" form into a sales/marketing audience.
- Sync a "join our community" form to a members list.
- Build a country-specific audience by enabling the matching handler per selected region.
- Collect opt-ins from a footer newsletter block rendered as a webform.
- Send donation-form supporters to a supporter audience.
- Add webinar sign-ups to a nurture list in Mailchimp.
- Populate a Mailchimp list from a multi-step webform's final step.
- Keep a Drupal-side webform submission while also pushing the contact to Mailchimp.
- Test list/merge-field mapping in a staging audience before pointing at production.
- Migrate a legacy signup form to Webform while keeping Mailchimp integration.
- Support marketing teams who manage audiences in Mailchimp, not Drupal.
