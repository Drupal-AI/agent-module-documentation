<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
xAI Provider registers xAI (Grok) as a chat provider for the Drupal AI module.

---

xAI Provider is an early-stage (alpha) provider plugin that adds **xAI's Grok** to the Drupal AI
module. It registers a single `xai` provider exposing the `chat` operation type and the `grok-2` model,
backed by the third-party `grok-php/client` library rather than an OpenAI-compatible client. The API key
is stored through the Key module and selected on an admin settings form at
`/admin/config/ai/providers/xai`. The project is under active development and marked "Under development";
its `chat()` implementation is still a scaffold (see the agent docs), so treat it as a starting point
rather than production-ready. It depends on the AI module and the Key module and sits in the
"AI Providers" package.

---

- Register xAI (Grok) as a provider in the Drupal AI module.
- Offer the `grok-2` model for the AI module's `chat` operation.
- Authenticate to xAI with a Key-module key.
- Configure the xAI API key at `/admin/config/ai/providers/xai`.
- Restrict provider configuration to users with `administer ai providers`.
- Back the `grok-php/client` library from a Drupal AI provider plugin.
- Prototype Grok integrations before the provider reaches a stable release.
- Compare Grok output against other AI-module providers.
- Serve as a reference implementation of a minimal AI provider plugin.
- Select `xai` programmatically via `\Drupal::service('ai.provider')->createInstance('xai')`.
- Hot-swap the API key at runtime through `getClient($api_key)`.
- Provide chat responses to AI-module consumers (Automators, Agents, chat blocks).
- Keep the Grok credential out of exported config by using a Key entity.
- Read the provider's model list from `definitions/api_defaults.yml`.
- Extend the plugin to add temperature / token options exposed by `grok-php/client`.
- Evaluate xAI as an AI backend for a Drupal site.
