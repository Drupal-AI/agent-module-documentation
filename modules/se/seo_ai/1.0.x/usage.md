<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SEO AI generates metatag values for nodes via an OpenAI-compatible chat API.

---

SEO AI extends the node form (`SeoAiNodeForm`) to add a 'Generate Metatags' AJAX button on selected content types that have a Metatag field. It sends the node title and body to a configured OpenAI-compatible chat completions endpoint (`OpenAiMetatagGenerator` via Guzzle) and fills the Metatag basic/Open Graph fields with the JSON response (title, description, abstract, keywords, OG title/description). Endpoint, model, token, temperature and enabled content types are set at `/admin/config/content/seo-ai` behind the restricted `administer seo ai` permission. Depends on node + metatag. TLS verification is left at Guzzle defaults; the API endpoint is admin-configured (not user-supplied).

---

- Generate SEO metatags for a node with one click.
- Suggest a meta title under ~60 characters.
- Suggest a meta description for SERP.
- Suggest an abstract and keywords.
- Suggest Open Graph title and description.
- Target only chosen content types.
- Require the node to have a Metatag field.
- Configure the OpenAI-compatible endpoint.
- Configure model, max tokens and temperature.
- Store the API token in module config.
- Populate Metatag fields via AJAX.
- Limit input by max context length.
- Gate settings behind a restricted permission.
- Use on Drupal 10 and 11.
- Integrate AI copywriting into editing.
- Fall back to error messages on API failure.
