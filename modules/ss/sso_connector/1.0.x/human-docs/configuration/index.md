# Configuration

SSO Connector is configured from a single admin form that establishes each site's
role in the federation and the trust between sites. You run through it once per
site.

## Set each site's role

Every site in the federation is either the **Identity Provider** (the one site
that authenticates users) or a **Service Provider** (a site that trusts the IdP
for login). The admin form is where you set this role. Configure the IdP first,
then each SP.

## Allowed service providers (on the IdP)

On the IdP, you maintain the **allowlist of service providers** it is willing to
mint tokens for. This is a security boundary, not a convenience list: after a user
logs in, the IdP only issues a token and redirects back to an SP that appears on
this allowlist, and it refuses outright for any site that does not. Keep the list
tight — only include sites you actually control — so a leaked or guessed return
URL cannot be used to harvest tokens.

## The signing key

The IdP signs tokens with an RSA private key and the SPs verify them with the
matching public key. Provision the keypair as described in the module's `README.md`
and `docs/BUNDLE.md`, and **keep the private signing key in `settings.php` or
State, never in exportable configuration**. A leaked signing key is the worst-case
failure here: it would let an attacker forge valid SSO tokens for any user, so
treat it with the same care as a database password.

## Token lifetime and transport

Tokens are deliberately short-lived (around 120 seconds by default) and
single-use, which limits the damage if one is ever intercepted. Leave the
lifetime short, and serve the whole SSO flow over **HTTPS** so tokens are never
exposed in transit.

## The machine token endpoint

Beyond the browser login flow, the module exposes a machine-to-machine token
endpoint at `/sso/token`. It is protected by a dedicated `X-SSO-Key` API key, a
CIDR-aware IP allowlist, and core flood control. Treat the `X-SSO-Key` value as a
secret (store it in `settings.php` or State like the signing key) and keep the IP
allowlist as narrow as your architecture allows.

## Save and test

After configuring the IdP and each SP, test an end-to-end login: sign in at an SP,
confirm you are redirected to the IdP, authenticate, and land back at the SP
logged in. Then confirm that a site *not* on the allowlist is refused.
