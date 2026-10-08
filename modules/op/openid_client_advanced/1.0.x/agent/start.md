<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenID Client Advanced — agent index

An **advanced OpenID Connect client plugin** — adds **ID-token (JWT) signature validation** + **nonce**
support on top of the base client. Depends on `openid_connect`. Version **1.0.0-rc8**. Core `^10||^11`.

Security-enhancing, correct foundation: extends OpenID Connect's client (**state/CSRF** handled by core's
state-token service) and **adds** JWT signature validation + nonce. **Enable the `use_nonce` option**
(defaults off) for replay protection; configure the provider JWKS; store the client secret as a secret;
HTTPS. No content-access role beyond auth.
