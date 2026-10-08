# Configuration

Headless CMS is configured per feature (Preview, Notify) and — thanks to its
integration with the **Consumers** module — often per consumer. Administration is
gated by a dedicated permission, so set that up first.

## Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant
**`administer headless_cms settings`** only to trusted administrative roles. This
permission controls the module's configuration; keep it off anonymous and
untrusted roles.

## Register your consumers

Because the module builds on Consumers, its behaviour is configured against the
**consumers** registered on your site — each consumer represents a front-end
application (for example a Nuxt or Next.js app) that talks to Drupal. Manage
those under the Consumers module's administration, then configure Headless CMS's
features on a **per-consumer** basis where the forms allow it. This lets you, for
instance, send Notify events to one consumer's webhook and not another's.

## Preview

If you enabled the **Preview** submodule, configure how editors preview
unpublished content and revisions in your external front end — typically the
front-end preview URL and any per-consumer settings. Once configured, editors get
a preview link that opens the draft in the decoupled front end.

## Notify

If you enabled the **Notify** submodule, choose the transport and target for
outbound events:

- **Webhook** — Drupal POSTs an event payload to a URL your front end exposes
  when entities are created, updated or deleted, or when caches rebuild. Point it
  at your front end's revalidation/rebuild endpoint.
- **NATS** — publishes events to a NATS messaging server, for setups that consume
  events off a message bus.

Configure these per consumer where offered, so each front end receives only the
events it cares about. If a webhook endpoint requires a secret or token, treat it
as sensitive — supply it through the environment rather than committing it, and
send it over HTTPS.

## Security checklist for a headless backend

A decoupled Drupal exposes content to API clients, so get these right — most live
in core/web-services configuration rather than in this module, but they are what
keep the setup safe:

- **Authentication.** Require proper authentication (for example Simple OAuth
  bearer tokens) on your content APIs; don't rely on obscurity.
- **CORS.** Configure allowed origins in your site's `services.yml` so only your
  real front-end origins can call the APIs from a browser — avoid a blanket
  wildcard in production.
- **Consumers.** Only register the consumers you actually use, and scope each
  one's access appropriately.
- **Transport secrets.** Keep any webhook/NATS credentials in environment
  variables, never in committed config, and use encrypted transports (HTTPS /
  secured NATS).
