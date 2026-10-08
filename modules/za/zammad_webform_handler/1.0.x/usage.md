<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zammad Webform Handler adds a "Zammad Ticket" Webform handler that, on each webform submission, creates a ticket in a Zammad help-desk instance via the official Zammad API client — optionally creating the customer user (simple or complex) first.

---

The problem it solves is routing contact/support webform submissions straight into Zammad. The handler (`src/Plugin/WebformHandler/ZammadWebformHandler.php`) maps webform values to a ticket (title, body, group, type) using Webform tokens, and supports up to ten additional token-driven ticket fields and ten additional user fields. On `postSave` it instantiates `ZammadAPIClient\Client` with the site-level connection settings and saves a ticket; in "complex user" mode it first searches for the customer by email and creates the Zammad user when absent. Connection settings live on a separate admin form (`/admin/config/system/zammad-webform-handler`): Zammad URL, an HTTP token secret, a request timeout, and an SSL-verification toggle.

Operational/security notes: this is an **outbound-only** integration — there is no inbound webhook/callback route, so nothing anonymous is exposed; the only route is the admin settings form, gated by the restrict-access permission `administer zammad_webform_handler configuration`. Two things to note. (1) The Zammad HTTP token is stored as a **plaintext textfield in module config** (`zammad_webform_handler.settings.http_token_secret`), not a Key entity — treat exported config as sensitive. (2) SSL/TLS verification of the outbound API call is a user-toggleable checkbox (`verify`); the client is built with `'verify' => config('verify')`, so an administrator can disable certificate verification (and if the config value is unset it is falsy) — keep it enabled for secure communication. Typical setup: install the Zammad API client via Composer, set the URL/token on the settings form (leave SSL verification on), then add the "Zammad Ticket" handler to a webform and map ticket/user fields.
---
- Create a Zammad ticket automatically from each webform submission.
- Map the ticket title and body from webform values using tokens.
- Set the Zammad group and ticket type per handler.
- Create a "simple" Zammad customer by email when one doesn't exist.
- Create a "complex" Zammad user with name/phone/web/notes fields.
- Add up to ten extra token-driven ticket fields.
- Add up to ten extra token-driven Zammad user fields.
- Configure the Zammad instance URL on the settings page.
- Store the Zammad HTTP API token for authentication.
- Set a request timeout for Zammad API calls.
- Keep SSL certificate verification enabled for the API connection.
- Restrict handler configuration to admins via the module permission.
- Route different webforms to different Zammad groups.
- Attach multiple Zammad handlers to one webform.
- Log Zammad API errors to the Drupal log on failure.
- Send support requests from a contact form into the help desk.
- Identify the ticket customer via a submitted email token.
- Use "guess:{email}" behavior to create/link the customer in one call.
- Populate ticket sender/from fields with the customer email.
- Validate that connection settings exist before saving the handler.
