# Simple OAuth Redirect URI Wildcard — manual setup guide

**Simple OAuth Redirect URI Wildcard** (`simple_oauth_redirect_uri_wildcard`)
extends the [Simple OAuth](https://www.drupal.org/project/simple_oauth) module so
that a consumer's registered redirect URI may contain a **subdomain wildcard**.
Instead of registering a separate exact URI for every subdomain, you can register
one pattern such as `https://*.example.com/callback` and let it match any single
subdomain.

The typical reason to want this is preview/deployment hosting: platforms like
Vercel generate a fresh, unique subdomain for every git commit, so you cannot
know all the redirect URIs in advance. Large identity providers such as Auth0 and
Okta offer the same wildcard capability for the same reason.

There is no settings form. Once the module is enabled, you simply enter a
wildcard pattern in the **Redirect URI** field of a Simple OAuth consumer, and the
module handles the matching. It depends on the **Simple OAuth** module and has no
submodules.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Please read this before you use it

Wildcard redirect URIs touch OAuth's single most safety-critical control, so it
is worth being honest about both how the module protects you and what risk
remains no matter how well it is written.

**What the module does to keep matching safe.** The wildcard is not a loose
"match anything" rule. The pattern is compiled to an *anchored* regular expression
(built with `preg_quote`), where `*` stands for a **single subdomain label
containing no dots** — so it cannot span domain boundaries or match as a
substring somewhere unexpected. The validator also **forbids the wildcard in the
registrable-domain or top-level-domain position**: you may wildcard a subdomain,
but not write `*` or `*.com`. Together these close the usual wildcard-matching
bypasses.

**The risk that remains no matter what.** The OAuth 2.0 Security Best Current
Practice recommends *exact* redirect-URI matching precisely because a wildcard
like `*.example.com` allows **any** matching subdomain to receive authorization
codes and tokens. If an attacker can control or take over any one of those
subdomains — through a subdomain takeover, a compromised or user-content
subdomain, or shared hosting — they can capture OAuth codes. Note too that using
a wildcard technically violates Section 3.1.2 of RFC 6749, which requires
absolute redirect URIs.

So use this module **only where you control every subdomain that the pattern can
match**, keep the wildcard as narrow as possible, watch actively for subdomain
takeover, and prefer exact redirect URIs wherever you can. The responsibility for
governing wildcards safely rests with you as the site owner.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

There is no admin settings page for this module. After enabling it:

1. Edit (or create) a Simple OAuth **consumer** at **Configuration → Web services
   → Consumers** (`/admin/config/services/consumer`).
2. In the **Redirect URI** field, enter a wildcard pattern — for example
   `https://*.example.com/callback`. The `*` matches exactly one subdomain label.
3. Save the consumer. When a client begins an OAuth flow with a redirect URI that
   fits the pattern, the module validates it against the anchored regex described
   above and allows the flow to proceed.
