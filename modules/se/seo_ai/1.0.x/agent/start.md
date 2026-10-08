<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SEO AI — agent index

Adds a **Generate Metatags** AJAX button to node edit forms (`SeoAiNodeForm`) that calls an OpenAI-compatible chat API (`OpenAiMetatagGenerator`, Guzzle) and fills Metatag basic/OG fields. Configure endpoint/model/token at `/admin/config/content/seo-ai` (`administer seo ai`). Depends on node + metatag. Version **1.0.0**, core 10/11.

Endpoint is admin-configured (not user input); API token stored in plain config; Guzzle default TLS verification.