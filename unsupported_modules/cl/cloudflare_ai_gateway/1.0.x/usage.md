<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare AI Gateway is a Drupal client for the Cloudflare AI Gateway (gateway.ai.cloudflare.com): it stores gateways as config, builds gateway URLs and cf-aig-* control headers, exposes the live model catalogue, and registers a gateway as a provisionable Cloudflare primitive.

---

Cloudflare AI Gateway is the client layer for Cloudflare's AI Gateway — a hosted reverse proxy that sits in front of many model providers and adds caching, analytics, rate limiting and provider fallback. This module does not make the LLM calls itself; it builds the gateway's request URLs for the three endpoint styles (passthrough, universal, OpenAI-compatible) and the `cf-aig-*` request headers (cache TTL, skip-cache, metadata, cache-key), resolves the gateway authorization from a Cloudflare credential set, and reads the gateway's live model catalogue (cached). Each gateway is a `cloudflare_gateway` config entity (host, slug, credential set, default provider, origin), managed at Administration > Configuration > Web services > Cloudflare AI Gateways.

It also makes a gateway a first-class provisionable Cloudflare primitive — a capability, provider and asset-kind — so a gateway can be created and inspected (with a 24h analytics panel) alongside Workers and buckets. It builds on the Cloudflare SDK (credential resolution from settings.php/env, shared HTTP plumbing, the `administer cloudflare` permission) and the Cloudflare API modules; the separate AI Gateway Provider module uses a configured gateway to route the Drupal AI module through it. Requires Drupal 10.5+ or 11 and PHP 8.3+.

Project status: the standalone project is marked Obsolete/Unsupported on drupal.org — its code was consolidated unchanged into the broader Cloudflare AI (`drupal/cloudflare_ai`) module, which new sites should install instead.

---

- Store each Cloudflare AI Gateway as a config entity.
- Build gateway request URLs for passthrough, universal and OpenAI-compatible endpoint styles.
- Set cf-aig-* headers for cache TTL, skip-cache, metadata and cache-key.
- Resolve the gateway authorization token from a Cloudflare credential set (settings.php/env), never from config.
- Expose the gateway's live model catalogue, cached per gateway for one hour.
- Register a gateway as a provisionable Cloudflare primitive (capability, provider, asset-kind).
- Provision and inspect gateways via the Cloudflare AI Gateway management API.
- Show a 24h requests/cache-hit analytics panel on a gateway's detail page.
- Gate all admin UI and routes behind the `administer cloudflare` permission.
- Underpin the AI Gateway Provider module that routes the Drupal AI module through a gateway.
