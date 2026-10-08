<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email Octopus integrates the third-party EmailOctopus email-marketing API with Drupal so visitors can subscribe to your EmailOctopus lists and admins can view list contacts.

---

You configure the EmailOctopus API key on an admin form (stored in the `octopus.adminsettings` config). A "Email Octopus Subscribe Form" block (`SubscribeFormBlock`) can be placed multiple times, each bound to a chosen list, with its own title, body and thank-you message; the block renders `OctopusSubscribeForm`, which validates the email and POSTs it to `https://emailoctopus.com/api/1.5/lists/{list}/contacts` via Guzzle (TLS on, default verification), handling the "already a subscriber" case. An admin "List" form (`OctopusListForm`) fetches lists and their subscribed/unsubscribed contacts through GET requests. The three admin routes live under `/admin/config/*`.

Operational and security notes to be aware of: the admin routes require permission `administer`, which is not a defined Drupal permission — in practice this fails closed (only user 1 passes), so re-check access if the forms appear inaccessible. The API key is stored in plain configuration (no Key module integration), and the API key is passed in request bodies/query strings to EmailOctopus. The subscribe block is intended for anonymous visitors and has no CAPTCHA or rate limiting, so it can be abused to submit arbitrary emails to your list / burn API quota — pair it with a spam-protection module on public forms. No `verify => false` or other disabled-TLS was found.
---
- Add newsletter subscription to a Drupal site via EmailOctopus.
- Configure the EmailOctopus API key in module settings.
- Place a subscribe block bound to a specific EmailOctopus list.
- Place multiple subscribe blocks each targeting a different list.
- Customize a subscribe block's title, body and thank-you message.
- Let anonymous visitors subscribe with just their email.
- Validate submitted email addresses before sending to the API.
- Handle "already subscribed" responses gracefully for the user.
- View subscribed contacts of a list in the admin List form.
- View unsubscribed contacts of a list in the admin List form.
- Fetch available EmailOctopus lists into a select element.
- Submit new contacts to EmailOctopus with SUBSCRIBED status.
- Show a thank-you message after successful subscription.
- Theme the subscribe form via the `octopus_subscribe_form` template.
- Add spam protection (CAPTCHA) in front of the public subscribe block.
- Rotate the API key by updating the configuration form.
- Diagnose API errors via the `email_octopus` logger channel.
- Integrate an EmailOctopus list into a marketing landing page.
