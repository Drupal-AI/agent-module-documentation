Decoupled Kit Redirect exposes a JSON:API endpoint that returns any Redirect-module redirect matching a given front-end path, with the destination's path alias in meta.

---

`decoupled_kit_redirect` is a submodule of Decoupled Kit that adds one JSON:API resource,
`Drupal\decoupled_kit_redirect\Resource\Redirect`, on route `decoupled_kit.redirect` at
`%jsonapi%/decoupled_kit/redirect`. Given a `current_path` query arg it resolves that (possibly
aliased) path to its internal path via `path_alias.manager`, loads a `redirect` entity whose
`redirect_source.path` matches, and returns it as a JSON:API individual document. It also computes
the path alias of the redirect's destination and returns it under the document's `meta.alias`. If no
redirect matches, it returns an empty JSON:API document. The endpoint is read-only and lets a
decoupled front end decide, per requested URL, whether to issue a redirect and where to. Requires
`decoupled_kit` and the contrib `redirect` module.

---

- Check whether a front-end URL has a Drupal redirect: `/jsonapi/decoupled_kit/redirect?current_path=/old-page`.
- Drive server-side (SSR) or client-side redirects in a headless front end from Drupal-managed redirects.
- Resolve an incoming aliased path to its internal path before matching redirects.
- Read the redirect's destination URI from the returned redirect entity's `redirect_redirect` field.
- Read `meta.alias` to get the human-friendly alias of the redirect target for the front-end Location.
- Preserve SEO by honoring editor-managed 301/302 redirects in a decoupled site.
- Return an empty document (no match) so the front end can proceed to normal routing.
- Combine with the Router endpoint: check for a redirect first, then resolve the entity for the final path.
- Migrate legacy URLs by mapping them to new decoupled routes through the Redirect module.
- Inspect a redirect for a path from the Decoupled Kit Dashboard's generated redirect link.
- Support multilingual redirects by matching on the resolved internal path.
- Centralize redirect management in Drupal's Redirect UI while serving a JS front end.
- Build a catch-all front-end route that queries this endpoint before rendering a 404.
- Expose redirect data as standard JSON:API so existing JSON:API clients can consume it.
- Debug redirect resolution for a specific path during front-end development.
