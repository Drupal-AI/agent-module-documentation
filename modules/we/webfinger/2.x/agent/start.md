<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WebFinger (webfinger) — agent index

**WebFinger protocol** support (RFC 7033) — a discovery endpoint locating user profiles by identifier.
Version **2.0.4**. Used for Fediverse/federated identity/OpenID discovery.

**Privacy (inherent to the protocol):** WebFinger is **discovery** — it reveals whether an identifier
maps to an account (user enumeration) and returns configured profile info. Expose only **intended
public** profile data (profile URL/avatar), **never** sensitive account details; scope to the minimum.