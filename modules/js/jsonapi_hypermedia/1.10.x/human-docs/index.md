# JSON:API Hypermedia — manual setup guide

**JSON:API Hypermedia** (`jsonapi_hypermedia`) extends Drupal's core JSON:API so that
your API responses can carry custom, access-aware hyperlinks. Instead of a client
having to hard-code backend knowledge ("to publish a node, POST to this URL"), the
API itself advertises the actions that are available — "authenticate", "publish",
"next page", "edit" — as links inside the standard JSON:API `links` object. This is
the HATEOAS idea (Hypermedia as the Engine of Application State) applied to Drupal.

The links are **access-aware**, and that is the powerful part. A link provider can
return a link only when the current user is actually allowed to follow it, and can
*omit* it entirely otherwise. So a "publish" link appears only on unpublished content
the user may publish, and disappears once the content is published — the mere
presence or absence of a link tells a decoupled front-end what it can do right now,
with no separate documentation.

This is a **developer/API module**. It has no settings page, no permissions, no admin
screens, and no Drush commands. You extend it by writing small plugins (a
`LinkProvider` plugin type it adds), each of which declares which relation type it
provides, where it applies (the whole document, a resource, or a relationship), and
returns the link from a `getLink()` method. New link relation type names are declared
in a `*.link_relation_types.yml` file, and other modules can alter your providers via
a hook. The module ships worked examples (an authenticate/logout link, a
publish/unpublish link, an image-relationship link) under its `examples/` folder,
which are not enabled by default.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including the plugin anatomy, the context types, and the
`AccessRestrictedLink` return object — read the sibling [`agent/`](../agent/start.md)
docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core's JSON:API module.

## How to use it

Because there is nothing to configure in the UI, "using" this module means writing a
`LinkProvider` plugin in a custom module. In brief:

1. Create a class under `src/Plugin/jsonapi_hypermedia/LinkProvider/` in your module,
   annotated with `@JsonapiHypermediaLinkProvider`.
2. Declare its `link_relation_type` (e.g. `publish`), an optional `link_key` (the
   member name under `links`), and a `link_context` saying where it applies — the
   `top_level_object` (with a sub-type like `entrypoint` or `collection`), a
   `resource_object` (all resources or a specific `type--bundle`), or a
   `relationship_object`.
3. Implement `getLink($context)` to return an `AccessRestrictedLink` built from an
   access result, cacheability metadata, a URL, and the relation type. Return
   `AccessRestrictedLink::createInaccessibleLink()` to hide the link.
4. Declare any custom relation-type names in `your_module.link_relation_types.yml`,
   then rebuild caches (`drush cr`).

Once enabled, the module decorates JSON:API's link-collection normalizer, so your
providers automatically run every time JSON:API builds a `links` object — only the
`api_json` (JSON:API) responses are affected. The bundled `examples/` folder is the
fastest way to see complete, working providers.

## Where it lives in the admin menu

Nowhere — JSON:API Hypermedia has no admin pages or configuration form. Everything it
does is defined in code by the link-provider plugins you (or other modules) install.
