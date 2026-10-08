<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare SDK is the base framework for the Cloudflare module suite: named credential sets, settings.php secret resolution, a shared HTTP client factory, a Cloudflare asset registry, and a resource-provisioning framework.

---

Cloudflare SDK is the framework layer the other Cloudflare modules build on. Built on the standalone `cloudflare_api` client, it provides named **credential sets** (thin `cloudflare_credentials` config entities that store only a machine name and label), **secret resolution** that reads each set's account ID and API token from `settings.php` keyed by that machine name — so nothing account-specific ever lands in configuration or the database — and a shared **HTTP client factory** that binds a base URI and default headers over Drupal core's HTTP client. It also carries a **Cloudflare asset registry**: a `cloudflare_asset` config entity for tracked resources (managed or externally registered) plus an asset-kind/resolver framework that surfaces every tracked asset on a unified admin page, and a **provisioning framework** (capability plugins, primitive providers, a reconciler and deployment appliers) that feature modules drive to create and reconcile the Cloudflare resources they need. On its own the module makes no calls to Cloudflare; you install it because another Cloudflare module depends on it. An optional submodule, **Cloudflare SDK Key**, lets a credential set resolve its token from a Key entity instead of settings.php.

---

- Give the Cloudflare suite one shared credential model.
- Define named credential sets as thin config entities (machine name + label only).
- Keep account IDs and API tokens in settings.php, out of config export and the database.
- Resolve a credential set into an account ID + token behind a swappable interface.
- Optionally resolve the token from a Key entity via the Cloudflare SDK Key submodule.
- Build HTTP clients bound to a Cloudflare base URI with shared default headers.
- Inject fixed auth/control headers into any PSR-18 client via a decorator.
- Detect whether a token is read-only or read-write for action-gating.
- Track Cloudflare resources as `cloudflare_asset` entities (managed or external).
- Resolve each asset's runtime URL/status through a pluggable asset-kind framework.
- Surface all tracked assets on a unified Cloudflare assets admin page.
- Let feature modules declare needed primitives via capability plugins.
- Reconcile declared requirements: provision managed primitives or verify linked ones.
- Run idempotent deployment appliers after primitives are provisioned.
- List an account's existing resources to power a "link existing" picker.
- Gate all administration behind the `administer cloudflare` permission.
- Underpin modules such as Cloudflare AI Gateway and its AI provider.
