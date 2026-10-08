<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Poll Rest exposes core Poll voting/results through Drupal's REST API.

---

Poll Rest makes the core Poll module work with REST — exposing poll data and voting through Drupal's REST API so a decoupled front end or external client can display polls and submit votes. It bridges Poll to the web-services stack.

Poll voting/access still follows the Poll module's own permissions via REST; configure REST resource permissions appropriately. Depends on core `poll` and `rest`; supports Drupal 9, 10, and 11.

---

- Expose Poll via REST.
- Serve poll data through the API.
- Allow voting via REST.
- Support decoupled front ends.
- Bridge Poll to web services.
- Follow Poll's permissions.
- Configure REST resource permissions.
- Depend on core `poll` and `rest`.
- Support Drupal 9, 10, and 11.
- Display polls headlessly.
- Submit votes via API.
- Integrate polls decoupled.
- Serve poll results
- Support external clients
- Enable poll APIs.
- Handle voting.
- Expose poll resources.
- Support headless polls
