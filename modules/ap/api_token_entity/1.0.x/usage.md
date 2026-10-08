<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
API Token Entity models API tokens (and token types) as content entities and provides a validation service plus a route access checker so custom/contrib code can authenticate incoming API requests with an `Authorization: ApiKey <token>` header.

---

API Token Entity adds two content entity types — `api_token_entity_api_token` (an issued token) and `api_token_entity_api_token_type` (a named category of tokens) — administered from *Configuration › Web services › API token entity*. Administrators create a token of a given type; the module generates a high-entropy value (`base64_encode(random_bytes(40))`), stores only its hash, shows the plain value once, and supports one-click rotation and a required expiration date. Consumption is code-side: mark a route with the `_api_token_type: '<type_name>'` requirement to have `ApiTokenTypeAccessCheck` validate the `Authorization: ApiKey …` header against issued tokens of that type, or call `\Drupal::service('api_token_entity.api_token.manager')->checkApiToken($value, $type, $consumerId)` directly. On success the manager returns the token's "Consumer ID" (its `name`); on failure it returns `FALSE`. Requires Drupal 11.3+, PHP 8.4+, and core `datetime`; all token administration is gated by the single `administer api_token_entity entities` permission (restrict access). A shipped `api_token_entity_test` module (under `tests/modules/`) is a reference example, not a runtime submodule.

---

- Issue API tokens to third parties or service accounts through the Drupal admin UI.
- Group tokens into named types (e.g. `read_only`, `partner_feed`) so each route accepts only the intended kind.
- Protect a custom API route by adding `_api_token_type: '<type_name>'` to its `requirements` in `*.routing.yml`.
- Authenticate requests carrying an `Authorization: ApiKey <token>` header.
- Validate a token programmatically from a controller, form, or service via `ApiTokenManager::checkApiToken()`.
- Resolve which consumer a presented token belongs to (the manager returns the token's Consumer ID).
- Generate a cryptographically strong token value with `ApiTokenManager::generateSecureApiTokenValue()`.
- Rotate a compromised token in place with the "Rotate Token" button (issues a new value, invalidating the old one).
- Set a per-token expiration date (defaults to one year ahead on creation).
- Show a token's plain value exactly once at creation/rotation, then store only its hash.
- Give each token a stable Consumer ID for logging and correlation.
- Restrict token administration to trusted roles via `administer api_token_entity entities`.
- Manage tokens and token types in sortable admin list tables (values shown masked).
- Check whether a specific token string is currently accepted using the built-in "Validate Token" form on the token list page.
- Delete individual or multiple tokens/types with core confirm forms.
- Back a headless/decoupled front end that talks to Drupal endpoints with a shared secret.
- Enforce machine-name style identifiers (lowercase letters, digits, `_`, `.`) on token and type names.
- Distinguish expired tokens visually in the admin list (flagged with a marker).
- Provide a lightweight, dependency-free alternative to full OAuth for simple service-to-service auth.
- Use as a building block that other modules can depend on for token-based endpoint protection.
