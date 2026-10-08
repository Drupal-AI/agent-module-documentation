<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alexa provides an endpoint that receives Amazon Alexa skill requests, validates them as genuine, and dispatches a Symfony event so other modules can build skills without handling request validation.

---

Install the module and configure the application id at /admin/config/services/alexa (permission: administer alexa configuration). Alexa posts to /alexa/callback; the controller validates the signature certificate (cached) and application id via the alexa-app library, then dispatches alexaevent.request. Submodules alexa_demo and alexa_chatbot_api show integrations.

---

- Expose an Alexa callback at /alexa/callback.
- Validate requests via signature + certificate.
- Verify the certificate chain URL before fetching.
- Check the configured Alexa application id.
- Cache the downloaded Amazon certificate.
- Dispatch alexaevent.request for skill handlers.
- Provide an admin settings form for the app id.
- Gate settings behind 'administer alexa configuration'.
- Return JSON Alexa responses.
- Support a dev_mode state flag to skip validation.
- Include demo and chatbot_api submodules.
- Serve as a voice-assistant integration.
- Note: request verification is present (sound).
- Reuse core httpClient for cert retrieval.
- Let modules build skills without validation code.
- Log invalid requests via watchdog_exception.
- Depend on the alexa-app PHP library.
- Keep the endpoint self-authenticating by signature.
