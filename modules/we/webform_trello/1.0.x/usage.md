<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Trello adds a Webform handler that creates a Trello card when a form is submitted.

---

**Webform Trello** provides a Webform handler plugin that pushes each submission to the Trello REST API as a card on a configured board/list. It authenticates with a Trello API key and token, supports Webform token replacement in the card name/description, and is configured under the Webform admin settings. Requires the `webform` and `token` modules; access to configuration is gated by the core `administer webform` permission.

The handler calls the Trello API over HTTPS via the Guzzle `http_client` (default TLS verification). It is an outbound integration only — it exposes no public routes and stores the API key/token in module config.

---

- Create a Trello card for every Webform submission.
- Route form submissions into a Trello board/list.
- Turn contact-form messages into Trello tickets.
- Map submission fields into card name and description.
- Use Webform tokens to build card content.
- Authenticate to Trello with an API key and token.
- Configure per-webform via a Webform handler.
- Add the handler from the Webform handlers UI.
- Send data to Trello over HTTPS via Guzzle.
- Track leads as Trello cards.
- Manage support requests as Trello cards.
- Test the Trello connection from the admin form.
- Depend on the Webform and Token modules.
- Gate configuration behind 'administer webform'.
- Push submissions without custom code.
- Integrate Drupal forms with a Trello workflow.
- Create cards on a chosen board and list.
- Store Trello credentials in module configuration.