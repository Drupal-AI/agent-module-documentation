# Configuration

IndieWeb is configured entirely from its **dashboard**, reached at
**Configuration → Web services → IndieWeb** (the `indieweb.admin.dashboard`
route). Each submodule you enabled adds its own section there. Because the exact
options that appear depend on which submodules are on, this page walks through the
model of each area rather than every individual checkbox.

> **Serve over HTTPS.** Several of these features expose public endpoints and
> issue or accept authentication tokens. Configure and test them only on an
> HTTPS site.

## IndieAuth — the authentication core

IndieAuth (`indieweb_indieauth`) decides how identity and tokens work:

- Choose whether to run the **built-in IndieAuth Authorization and Authentication
  API** (with PKCE) or delegate to an **external** IndieAuth service.
- When you use the built-in authority, your site issues bearer **tokens** with
  **scopes** (such as `create`, `update`, `delete`). These tokens are what the
  Micropub and Microsub endpoints check.
- Users can log in and create accounts with IndieAuth.

Because enabling IndieAuth turns your site into a token authority, keep it well
configured, review the tokens it issues, and never run it over plain HTTP.

## Micropub — the posting endpoint

Micropub (`indieweb_micropub`) exposes an endpoint (at `/indieweb/micropub`) that
external clients use to create content. Every request must carry a valid IndieAuth
bearer token: the endpoint returns **401** when the `Authorization` header is
missing or invalid, and **403** when the token's scope is insufficient, before it
creates anything.

In this section you map incoming post types (note, article, event, RSVP, reply,
like, repost, bookmark, checkin, and so on) to how they are stored on your site,
decide whether location coordinates are saved, and enable optional query support
(`q=category`, and experimentally `q=source`). Only grant the scopes you actually
need.

## Webmention — sending and receiving mentions

Webmention (`indieweb_webmention`) handles cross-site mentions in both directions:

- **Receiving** — accept incoming webmentions and pingbacks through the internal
  endpoint or via Webmention.io. Incoming mentions are stored, and you can
  optionally turn `in-reply-to` mentions into comments. **Treat every received
  webmention as untrusted input**: moderate them and verify their sources before
  displaying.
- **Sending / syndicating** — send webmentions for your own posts and syndicate
  content, likes, and reposts (for example via Bridgy), storing the resulting
  syndication links.

Blocks are provided for rendering received webmentions, RSVPs, and a "sign in"
control.

## The reader and feed pieces

- **Microsub** (`indieweb_microsub`) runs a reader/subscription server — internal
  or external — and can allow anonymous requests where appropriate.
- **WebSub** (`indieweb_websub`) adds real-time PuSH 0.4 publishing and
  subscribing and integrates with Microsub for feed subscriptions.
- **Feed** (`indieweb_feed`) creates Microformats2, Atom, and JF2 feeds of your
  content.
- **Microformats** (`indieweb_microformat`) applies Microformats2 markup so other
  IndieWeb tools can parse your pages.

## Supporting stores

- **Contacts** (`indieweb_contact`) keeps a contact list used for Micropub
  contact queries and mentions/autocomplete.
- **Post context** (`indieweb_context`) fetches and stores context for content and
  reader items (for example the post you are replying to).
- **Media cache** (`indieweb_cache`) stores remote images locally so the internal
  webmention and Microsub endpoints do not hotlink third-party media.

## Permissions

The module defines its own permissions; grant them carefully, since they govern
who can administer these endpoints and who can act through them. Combined with the
IndieAuth token scopes above, permissions are how you keep the public-facing parts
of IndieWeb from being abused.
