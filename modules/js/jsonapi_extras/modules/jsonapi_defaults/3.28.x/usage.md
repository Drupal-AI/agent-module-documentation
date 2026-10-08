JSON:API Defaults is a submodule of JSON:API Extras that lets you set default includes, filters, sorting, and a page limit per resource, so API clients get fully-formed responses without passing any query parameters.

---

Core JSON:API requires clients to request related data and constraints explicitly via URL
parameters (`?include=`, `?filter=`, `?sort=`, `?page[limit]=`). JSON:API Defaults moves those
defaults to the server: on a resource's override configuration it adds a fieldset where you
define default `include`, `filter`, `sort`, and `page_limit` values, stored as third-party
settings on the `jsonapi_resource_config` entity. When a collection request for that resource
arrives **without** the corresponding parameter, the module applies your default; if the client
does send the parameter, the client's value wins. It overrides the JSON:API `EntityResource`
controller to inject these defaults and adds a cache context so responses vary correctly by query
arguments. This lets a front end request a simple resource URL and still receive all the related
objects and the right ordering, keeping client code minimal. It depends on and is configured
through JSON:API Extras.

---

- Always include an article's author and tags without a client `include` param.
- Return a node's image and media relationships by default.
- Apply a default `status = 1` filter so only published content is exposed.
- Default a "featured = true" filter on a promotions resource.
- Set default sorting by created date descending for a news feed.
- Sort a directory resource alphabetically by title by default.
- Cap a resource at a default page limit (e.g. 10 records).
- Give a frontend a clean URL that returns fully-hydrated responses.
- Reduce client complexity by moving include logic to the server.
- Provide sensible defaults while still allowing clients to override them.
- Default-include nested relationships (e.g. `field_tags.vid`).
- Filter a comments resource to a default status server-side.
- Enforce a default page size to protect against huge responses.
- Configure per-resource defaults exportable as config for deployment.
- Deliver a "simple resource" API contract for mobile apps.
- Default-sort an events resource by event date.
- Combine default filters and includes for a ready-made feed endpoint.
- Pre-filter a products resource to in-stock items by default.
