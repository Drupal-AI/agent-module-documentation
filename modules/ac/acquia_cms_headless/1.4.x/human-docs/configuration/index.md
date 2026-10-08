# Configuration

Acquia CMS Headless pre-wires the decoupled stack, but a working headless site
still needs a few decisions made: how OAuth is secured, which front-end consumers
are registered, and what JSON:API exposes. This page describes those tasks at a
practical level. The single fastest route is the **Headless dashboard** added by
the `acquia_cms_headless_ui` submodule, which gathers most of these in one place;
the provided **Drush commands** automate parts of the initial setup as well.

## 1. Secure Simple OAuth

This is the most important part of the security posture.

- **Generate OAuth keys.** Simple OAuth needs a public/private key pair to sign
  tokens. Generate them outside the web root and point Simple OAuth at them —
  never commit key material to version control. Store paths/secrets via
  environment variables (and a **Key** entity where supported) rather than plain
  config.
- **Set token lifetimes.** Under **Configuration → Web services → Simple OAuth**,
  choose access- and refresh-token expirations appropriate to your app — short
  enough to limit exposure, long enough to be practical.
- **Review scopes.** Grant consumers only the scopes/roles they actually need.

## 2. Register a consumer

Each front-end application authenticates as a **consumer**.

- Go to **Configuration → Web services → Consumers** and add a consumer for your
  Next.js (or other) app.
- Record its client ID/secret securely and configure your front end with them.
- Assign the consumer the minimum scopes/roles required.

## 3. Control what JSON:API exposes

- Use **Configuration → Web services → JSON:API Extras** to shape the API —
  enable/disable resources, rename fields, and limit what is exposed.
- Only expose the entities and fields your front end needs. Treat every exposed
  resource as publicly reachable unless protected by OAuth.
- **JSON:API Menu Items** exposes menus so the front end can build navigation.

## 4. Point the front end at Drupal

With OAuth and a consumer in place, configure your Next.js app (via the `next` /
`next_jsonapi` integration) with the site URL, the JSON:API base, and the OAuth
client credentials. Requests are then authenticated with OAuth tokens.

## 5. Browse the API docs

The **OpenAPI UI** (ReDoc and Swagger) renders browsable documentation of the
JSON:API surface, which is useful while building and debugging the front end.

## A note on the dashboard and Drush

If you enabled `acquia_cms_headless_ui`, the **Headless dashboard** presents the
consumers, tokens, and headless settings together — start there. The module also
ships **Drush commands** that automate parts of the headless setup; run
`drush list` and look for the module's commands to see what is available on your
version.
