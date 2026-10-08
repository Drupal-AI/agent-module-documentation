<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare Worker Purge lets a Drupal site running the Purge module invalidate the Cloudflare edge by cache tag through a custom Cloudflare Worker, instead of Cloudflare's own tag-purge API.

---

Install it alongside `purge` and `purge_ui` (and `key` if you want to store an authorization token), then add the **Cloudflare Worker** purger under **Configuration → Development → Performance → Purge**. In the purger's configuration dialog set the **URL** of your Worker and, when the Key module is enabled, pick a **Key entity** that holds the token the Worker accepts. As Drupal renders cacheable responses this module adds an **`X-Cache-Tag`** header (Cloudflare strips the normal `Cache-Tag` header before it reaches a Worker), so your Worker can record which tags a cached asset belongs to. When content changes, Purge queues tag invalidations and this module's purger `POST`s them — up to 30 tags per request as `{"tags":[…]}` — to your Worker URL over HTTPS, adding `Authorization: Bearer <token>` when a Key is configured. This is aimed at sites that want cache-tag purging on Cloudflare **without** a Cloudflare Enterprise account; you supply the Worker (its code is not part of this module). Note the project is marked obsolete/unsupported on drupal.org, so evaluate it before relying on it in production.

---

- Purge the Cloudflare edge by cache tag.
- Invalidate cached pages when their content changes.
- Use cache-tag purging without a Cloudflare Enterprise plan.
- Route Drupal cache invalidations through a custom Cloudflare Worker.
- Plug into the Purge module's queue and processor pipeline.
- Add the Cloudflare Worker purger in the Purge admin UI.
- Set the Worker endpoint URL in the purger configuration.
- Store the Worker authorization token as a Key entity.
- Send `Authorization: Bearer <token>` to the Worker on purge.
- Emit an `X-Cache-Tag` response header for the Worker to read.
- Work around Cloudflare stripping the `Cache-Tag` header.
- Batch up to 30 tags per purge request.
- Post invalidations as JSON `{"tags":[…]}` to the Worker.
- Purge asynchronously and mark each invalidation succeeded or failed.
- Keep stale content from lingering on the CDN edge.
- Restrict configuration to Purge administrators.
- Read the token from an environment variable via a Key provider.
- Confirm the Worker returns 2xx so Purge does not retry.
- Test the purge flow on a staging site before production.
- Review whether the obsolete module still fits your stack.
