<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Post API provides a framework for sending POST requests to external endpoints with a queue UI.

---

Post API provides developer tools to support POST requests to external endpoints for any data query — a structured way to send data from Drupal to third-party APIs, with a queue for reliable/asynchronous delivery and a UI to inspect it. Other modules/custom code build integrations on it.

External endpoint credentials should be stored securely (env-backed). Permissions cover settings (`administer post api settings`) and the queue UI (`access post api queue ui`). Supports Drupal 10.1+ and 11.

---

- Send POST requests to external endpoints.
- Support any data query.
- Queue requests for reliable delivery.
- Provide a queue UI.
- Build integrations on it.
- Store endpoint credentials securely.
- Gate settings with `administer post api settings`.
- Gate the UI with `access post api queue ui`.
- Support Drupal 10.1+ and 11.
- Deliver data asynchronously.
- Inspect the queue.
- Integrate external APIs.
- Support developers
- Configure endpoints
- Handle POST payloads.
- Retry deliveries.
- Aid API integration.
- Post data outward
