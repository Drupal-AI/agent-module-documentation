Purge Tokens adds token support to Purge so that purger plugins can build cache-invalidation requests (URLs, headers, paths) using replacement tokens.

---

This lightweight Purge submodule implements Drupal's Token API (`hook_token_info()` and `hook_tokens()`) to expose Purge-related replacement tokens. Purger modules that construct requests to a reverse proxy or CDN can then use tokens in their configuration — for example to inject the current host, a base URL, or invalidation details into a purge request URL or HTTP header — instead of hard-coding values. This makes purger configuration portable across environments (dev/stage/prod) where hostnames differ. It has no UI, configuration, schema, or permissions of its own; enabling it simply registers the tokens for any purger (or other module) that wants to consume them via the standard token replacement service. It depends on the Purge core framework and is only useful alongside a token-aware purger.

---

- Use tokens in a purger's request URL instead of hard-coded values.
- Inject the current site host into a CDN purge request.
- Build environment-portable purger configuration.
- Avoid hard-coding hostnames in cache-invalidation requests.
- Add token placeholders to purge HTTP headers.
- Vary purge targets by base URL via tokens.
- Reuse the same purger config across dev/stage/prod.
- Let a custom purger consume Purge tokens in its settings.
- Provide token replacement for external cache clearing requests.
- Register Purge tokens for the core Token API.
- Support multi-site setups with host-specific purge URLs.
- Templatize purge request paths.
- Combine with Token module UIs to browse available tokens.
- Keep purger settings free of literal domain names.
- Enable dynamic purge targets computed at runtime.
- Feed request metadata into a purger via tokens.
