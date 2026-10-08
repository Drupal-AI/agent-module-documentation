# Configuration

JSON:API Extras is configured in two places on the same admin page: the
**Settings** tab holds the global, site-wide options, and the **Resource
overrides** tab is where you reshape individual resource types and fields. This
page walks through both.

## Open the configuration page

1. Go to **Configuration → Web services → JSON:API → Extras**
   (`/admin/config/services/jsonapi/extras`).
2. You land on the **Settings** tab by default. The **Resource overrides** tab
   sits next to it.

## Global settings

![The JSON:API Extras settings page](../images/settings.png)

The Settings tab has the following options:

- **Path prefix** — the base path for the entire JSON:API, shown after the
  leading `/`. The default is `jsonapi`, so the API is served from `/jsonapi`.
  Change it to, for example, `api` to serve the API from `/api`. This field is
  required. Saving a new prefix rebuilds Drupal's routes so the new path takes
  effect immediately.
- **Include count in collection queries** — off by default. When ticked, every
  collection response returns a total record count for the query (in the
  response's `meta` section), which is useful for building pagination controls
  in your front-end.
- **Disabled by default** — off by default. When ticked, every resource type
  that does *not* have a matching **enabled** resource override is disabled.
  This flips the API to a whitelist model: nothing is exposed unless you have
  explicitly overridden and enabled it on the Resource overrides tab. Use this
  to lock the API down to only the resources you intend to publish.
- **Validate config integrity** — on by default. This adds a validation step
  when configuration is imported, checking that the field overrides in your
  resources still match the actual entity fields, so you can't import broken
  overrides. As the on-screen note explains, disable it *temporarily* if you
  need to import incomplete configuration (so you can fix it locally and export
  a complete version), then re-enable it afterwards.

### Save

When you have set the options you want, click **Save configuration**. Your
changes take effect immediately; if you changed the path prefix, the API is
served from the new path right away.

## Resource overrides

Switch to the **Resource overrides** tab. This is the core of the module: it
lists every JSON:API resource on your site, and lets you customize each one.
Each override you create is stored as a configuration entity, so it can be
exported and deployed like any other Drupal configuration.

### Override a resource type

1. Find the resource you want to change in the list (for example the
   `node--article` resource).
2. Use its **Overwrite** operation to start editing it. (Once a resource has
   been overridden, a **Revert** operation appears, which returns it to Drupal's
   default behaviour.)
3. On the override form you can set, for the resource as a whole:
   - **Disabled** — remove the resource from the API entirely, so it is no
     longer exposed to consumers.
   - **Resource type** — the public type name. This is where you rename
     `node--article` to a clean `article`.
   - **Path** — the URL path for this resource (for example `articles`, so the
     resource is served at `/{prefix}/articles`).

### Rename, hide, or enhance individual fields

The same override form lists every field on the resource. For each field you can:

- **Public name** — the name the field is exposed under in the API. Rename
  Drupal's internal `field_body` to a clean `body`, for instance.
- **Disabled** — hide the field so it never appears in responses. Use this for
  internal flags, admin metadata, or anything sensitive.
- **Enhancer** — attach a plugin that transforms the field's value on the way
  out (and reverses it on the way in). Built-in enhancers include date/time
  formatting for timestamp and datetime fields, parsing a JSON-string field into
  a real nested object, flattening a single-value field out of its array
  wrapper, extracting a value from a nested/compound field, and rewriting
  reference or link fields into resolvable links. Selecting an enhancer usually
  reveals its own settings (such as the date format to use).

Save the override form when you are done. Because JSON:API Extras reshapes
responses live rather than copying data, your changes apply to API output
immediately.
