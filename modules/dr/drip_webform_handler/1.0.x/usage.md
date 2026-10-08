<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Webform handler that posts each submission to Drip.com as a subscriber record.

---

Drip webform handler provides one Webform handler plugin, "Drip.com Webform Handler" (id `drip_webform_handler`), that you attach to any webform. In the handler settings an administrator enters a Drip API token and numeric account ID, optional pipe-separated tags and a GDPR consent value (granted/denied/unknown), and maps the webform's textfield and email elements onto Drip subscriber fields (email, first/last name, address, city, state, zip, country, phone, time zone, IP address). Each time the form is submitted the handler assembles a Drip `subscribers` dataset from the mapped values and POSTs it to the Drip API using the drewm/drip PHP client. It requires the Webform module and the drewm/drip Composer library, and runs on Drupal 9, 10 and 11.

---

- Capture newsletter or mailing-list signups from a webform straight into Drip.
- Turn a contact form into new Drip subscribers.
- Add event-registration submitters to Drip for follow-up campaigns.
- Feed lead-generation form submissions into Drip as CRM records.
- Sync webform textfield/email values onto standard Drip subscriber properties.
- Tag every submission from a given form (e.g. `webform|leads|2026`) for Drip segmentation.
- Record a GDPR consent state (granted/denied/unknown) on subscribers created from EU forms.
- Attach multiple Drip handlers to one webform (cardinality is unlimited) to post to different Drip accounts or with different tags.
- Send only the email address to Drip and leave the other subscriber fields unmapped.
- Map a webform "email" element to the Drip `email` property and text elements to name/address fields.
- Collect mailing-address fields (address1, address2, city, state, zip, country) into Drip.
- Populate the subscriber's phone number and time zone from the form.
- Route submissions from several forms into one Drip account by adding the handler to each.
- Use a webform's conditional handler settings so only qualifying submissions reach Drip.
- Build a signup form whose submitters become tagged Drip subscribers without custom code.
- Bridge Drupal Webform to Drip email-marketing automations and workflows.
- Keep a Drupal webform as the front end while Drip handles the marketing list.
- Create subscriber records in Drip for a webinar or download gate.
- Enrich Drip subscribers with the submitter's city/state/country for geo segmentation.
- Pass the submitter's IP address to Drip when the form collects it.
