<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JWT (base module) — agent index

Framework for issuing/validating JSON Web Tokens. Adds a global `jwt_auth`
authentication provider, a `jwt.transcoder` encode/decode service, two Key-module
key types (`jwt_hs`, `jwt_rs`), and three events. It signs with **one site-wide Key
entity**; the base module alone does not authenticate or issue tokens — enable the
submodules for that.

- **Pick/rotate the signing key, config object & route, create a jwt_hs/jwt_rs Key** →
  [configure/config.md](configure/config.md)
- **Encode/decode tokens in code: `jwt.transcoder`, `JsonWebToken` claim API, algorithms** →
  [api/transcoder.md](api/transcoder.md)
- **Add claims / validate / resolve the account via the three JWT events** →
  [hooks/events.md](hooks/events.md)

Key facts:
- Config object `jwt.config` holds `key_id` (and optionally `algorithm`). It **does not exist
  until you save** `/admin/config/system/jwt` (route `jwt.jwt_config_form`, permission `administer jwt`).
- Depends on the `key` module. Supported algorithms: `HS256`/`HS384`/`HS512` (type `jwt_hs`) and
  `RS256` (type `jwt_rs`). See `JwtTranscoder::getAlgorithmOptions()`.
- Header read: `Authorization: Bearer <jwt>` (fallback `JWT-Authorization: Bearer <jwt>`).
- Submodules: `jwt_auth_consumer` (authenticate), `jwt_auth_issuer` (issue at `/jwt/token`),
  `jwt_oauth_ccf` (client-credentials at `/oauth2/token`), `jwt_path_auth` (query-string on paths),
  `users_jwt` (per-user RSA keys). Each has its own docs under `modules/<sub>/2.4.x/`.
