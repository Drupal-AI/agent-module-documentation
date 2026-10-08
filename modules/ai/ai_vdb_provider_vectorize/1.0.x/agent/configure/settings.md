<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Cloudflare Vectorize provider

Route `ai_vdb_provider_vectorize.settings_form` at `/admin/config/ai/vdb_providers/vectorize` (form `\Drupal\ai_vdb_provider_vectorize\Form\SetupForm`), permission `administer ai providers`.

Steps:
1. Enable the module and its dependency chain (ai, ai_search, search_api, cloudflare_ai/sdk/api).
2. Configure Cloudflare account + API access via the cloudflare_* modules.
3. On the provider settings form, set the Vectorize index / namespace details.
4. Create a Search API server/index and pick the Cloudflare Vectorize VDB provider.
5. Index content, then run semantic queries through AI Search.

The `CloudflareVectorize` VdbProvider plugin performs index create, vector insert/delete and similarity query; `VectorizeMapper` maps Search API fields to Vectorize metadata.
