<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Open AI Metadata calls the OpenAI API to generate meta descriptions (and body content) for content based on a node's title.

---

The module has an API settings form (`/admin/config/open_ai_metadata/open-ai-api-settings`, `MetadataConfigForm`) for the OpenAI endpoint (default `https://api.openai.com/v1/chat/completions`), access token, model, max tokens, and temperature; a content-type settings form; and a modal content form (`/metadata/content/form/{fieldName}`) that editors invoke to generate text. Generation builds a chat prompt from the node title and POSTs it via Guzzle, returning the model's suggestion into the form. The access token is stored in Drupal `state` (not config), keeping it out of config exports.

Security review found the outbound calls use a default Guzzle client, so **TLS verification stays enabled** and there is no `verify=>false`; the endpoint is admin-configured behind an admin permission (not attacker-controllable, no SSRF for low-privilege users). One notable quirk: the module references custom permissions (`Administer Open AI Metadata`, `Access Open AI Metadata Content Type Settings`) that are not defined by any `permissions.yml`, so those routes are effectively restricted to user 1 until the permissions are provided — a fail-closed configuration issue, not an exposure. Content is sent to OpenAI, so review that provider's data handling before enabling.

---
- Generate an SEO meta description from a node's title.
- Draft body content for a node with OpenAI.
- Let editors trigger AI generation from a modal on the node form.
- Configure which content types get AI metadata.
- Set the OpenAI model, temperature, and max tokens.
- Point the integration at a custom OpenAI-compatible endpoint.
- Speed up metadata authoring across many nodes.
- Provide first-draft descriptions editors then refine.
- Keep the API token out of config exports (stored in state).
- Standardise meta-description length via max-token limits.
- Reduce blank or missing meta descriptions.
- Assist non-expert authors with SEO copy.
- Batch-improve metadata quality on a content-heavy site.
- Generate consistent tone via a fixed temperature.
- Integrate AI drafting without leaving the node form.
- Review OpenAI data handling before enabling for editors.
