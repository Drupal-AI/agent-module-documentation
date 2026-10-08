<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sidekick surfaces ChatGPT-generated content suggestions to editors as they author nodes, by calling a remote Sidekick API with a configured API key.

---

The module is configured at `/admin/config/services/sidekick` (route `sidekick.settings_form`, permission `administer sidekick configuration`), where an `api_key` and related options are stored in `sidekick.settings` config. `SidekickService` uses Guzzle (`http_client`) to POST/GET the Sidekick endpoints with an `Authorization: Bearer <api_key>` header, returning suggestions used to help draft content; a custom `ImageWidget` and templates integrate the suggestions into the edit form. A `sidekick content generation` permission gates which users can invoke generation. TLS uses Guzzle defaults (certificate verification on).

Operational/security notes: the API key is stored as plaintext in module config (exportable), not via the Key module. Because generation calls a paid remote service, restrict the `sidekick content generation` permission to trusted editors to limit cost exposure. Typical setup: enable the module, enter the API key on the settings form, grant the generation permission, and use the suggestion UI while editing content.

---

- Get AI-generated suggestions while writing a node.
- Configure the Sidekick API key.
- Request content ideas from ChatGPT via the Sidekick service.
- Restrict content generation to specific roles.
- Draft body copy with AI assistance.
- Surface suggestions inside the node edit form.
- Use the custom image widget to attach suggested media.
- Generate alternative phrasings for a field.
- Speed up first-draft authoring for editors.
- Cache suggestions using the entity cache backend.
- Localize requests using the language manager.
- Log generation activity via the logger factory.
- Limit AI cost by gating who can generate.
- Integrate suggestions into a custom content workflow.
- Tune model/behavior options on the settings form.
- Provide editors a writing assistant without leaving Drupal.
- Token-enable prompts sent to the assistant.
- Enable/disable the assistant per environment via config.
- Review suggested content before saving a node.
- Store API configuration in exportable config.
