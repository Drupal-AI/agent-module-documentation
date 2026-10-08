Routes the Drupal AI module through a Cloudflare AI Gateway so one provider exposes every model the gateway fronts, with the gateway's caching, logging and cost analytics.

---

Cloudflare AI Gateway Provider registers a single `cloudflare_gateway` AI provider that extends the AI module's OpenAI-compatible base client and re-points it at a Cloudflare AI Gateway's `/compat` endpoint. Because the gateway fronts many upstream vendors (OpenAI, Anthropic, Google, Mistral, Workers AI and more), that one provider makes all of their models available to every AI feature on the site — Explorer, Automators, Chatbot, AI Search — while applying the gateway's response caching, request logging and per-model cost analytics. It supports chat (including streamed responses) and embeddings, injects Cloudflare's cf-aig-* control headers (cache TTL, skip-cache, request metadata) per request, and can reference Cloudflare Dynamic Routing routes as `dynamic/<route>` for multi-provider fallback. Upstream provider keys are held in the gateway (unified billing or bring-your-own-key) and Cloudflare account credentials live in settings.php via the sibling cloudflare_ai/cloudflare_sdk modules, so no provider key is stored in Drupal config. A settings form curates which models to expose against the gateway's live catalogue (filterable by provider, with price shown), gated behind the `administer ai providers` permission.

---

- Expose many AI vendors' models to Drupal through a single provider instead of one module per vendor.
- Add Cloudflare's response caching in front of all AI calls to cut cost and latency.
- Collect request logs and per-model cost analytics for every AI operation in the Cloudflare dashboard.
- Use unified billing so no per-vendor API key is stored in Drupal.
- Use bring-your-own-key (BYOK): keep provider keys in the gateway, not in the Drupal database.
- Provide chat models (streamed and non-streamed) to AI Chatbot and the AI Explorer.
- Provide embeddings models to AI Search / vector database features.
- Curate exactly which chat and embeddings models are exposed via the settings form.
- Filter the gateway's live model catalogue by provider prefix (e.g. openai, anthropic).
- See each model's price per million tokens while choosing which to enable.
- Autocomplete model IDs against the gateway's live `/compat/models` catalogue.
- Reference a Cloudflare Dynamic Routing route as `dynamic/<route>` for automatic multi-provider fallback and retries.
- Set a cache TTL so the gateway serves identical responses for a configured period.
- Bypass the gateway cache per deployment with the skip-cache control.
- Attach custom metadata (e.g. environment: production) to every request for dashboard filtering.
- Have the AI operation type and per-request tags appended to request metadata automatically.
- Switch the whole site's AI traffic between gateways by changing one setting.
- Consolidate spend and observability across several AI vendors behind one connection.
- Keep the provider working with cached model IDs even when the live catalogue is briefly unreachable.
- Export the provider's model selection and gateway choice through Drupal configuration management.
