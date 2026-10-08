<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WebFinger provides WebFinger protocol support for locating user profiles and account information via a standard discovery endpoint.

---

WebFinger is a standard protocol (RFC 7033) for discovering information about a person or account from an identifier (like an email or acct: URI) — used in federated identity, Fediverse (Mastodon), and OpenID discovery. This module provides a WebFinger endpoint for locating user profiles. The security-relevant point is inherent to the protocol: WebFinger is a discovery mechanism, so by design it reveals whether an identifier corresponds to an account and returns configured profile information — which is user enumeration and profile disclosure, intended for interoperability but a consideration for privacy. So configure carefully what the endpoint exposes: it should return only the profile data you intend to be publicly discoverable (a public profile URL, an avatar), never sensitive account details, and be aware that the endpoint confirms account existence for any queried identifier. For federation/Fediverse interoperability it is the standard mechanism; treat the exposed data as public and scope it to the minimum.

---

- Provide WebFinger discovery.
- Support the Fediverse.
- Enable account discovery.
- Return a public profile URL.
- Support federated identity.
- Expose only public profile data.
- Understand it confirms account existence.
- Scope the exposed data.
- Avoid exposing sensitive details.
- Interoperate with Mastodon.
- Provide OpenID discovery.
- Treat exposed data as public.
- Configure the endpoint carefully.
- Enable identifier lookup.
- Support RFC 7033.
- Limit disclosed information.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.