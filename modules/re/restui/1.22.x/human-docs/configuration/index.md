# Configuration — enable and configure a REST resource

REST UI stores nothing of its own. Everything you do on this screen is written into
core's `rest.settings` configuration, and it is core's REST and Serialization modules
that serve the result. This page walks through enabling a resource and then choosing
its HTTP methods, accepted formats, and authentication providers.

## Open the REST resources list

1. Go to **Configuration → Web services → REST**
   (`/admin/config/services/rest`).

The screen lists every REST resource plugin discovered from core and contrib, split
into an **Enabled** and a **Disabled** section. Each row shows the resource name, its
path, and the HTTP methods that path supports.

![The REST resources list, with Enabled and Disabled sections and Enable operations](../images/list.png)

## Step 1 — Enable a resource

1. Scroll to the **Disabled** section and find the resource you want to expose — for
   example **Content** (the `entity:node` resource).
2. Click the **Enable** button in that row's **Operations** column.

The resource moves up into the **Enabled** section. Enabling it turns the resource on
with sensible defaults; the next steps let you narrow those down.

## Step 2 — Edit the resource

1. In the **Enabled** section, find the resource you just turned on.
2. Click its **Edit** operation.

The edit form presents the resource's HTTP methods, and for each method a set of
accepted formats and authentication providers. Configure each one as follows.

### Granularity

At the top of the form you can choose the **granularity** of the settings:

- **Per method** — configure the formats and authentication separately for each HTTP
  method (GET, POST, PATCH, DELETE). Use this when, say, reads and writes should be
  authenticated differently.
- **Per resource** — apply one set of formats and authentication to the whole
  resource at once. Use this when every method should behave the same.

### HTTP methods

The **methods** are the operations a client may perform on the resource. Enable only
the ones you actually need:

- **GET** — read the resource. Enabling only GET makes the resource read-only.
- **POST** — create a new entity through the API.
- **PATCH** — update an existing entity.
- **DELETE** — remove an entity remotely.

### Accepted request formats

For each method, tick the **serialization formats** the resource will accept and
return. The list comes from the formats installed site-wide:

- **`json`** — plain JSON. The common choice for a decoupled front end or mobile app.
- **`xml`** — XML output.
- **`hal_json`** — Hypertext Application Language JSON, which adds hypermedia links
  between resources.

Restricting a method to a single format (for example `json` only) keeps a decoupled
front end lightweight and makes API errors easier to reason about.

### Authentication providers

For each method, choose the **authentication providers** that guard it. These are
collected from every provider installed on the site:

- **`cookie`** — session-cookie authentication, i.e. a user who is already logged in
  through the browser. This is the natural choice for same-site JavaScript.
- **`basic_auth`** — HTTP Basic authentication (username and password on each
  request). Use this for non-browser clients such as a server-to-server integration
  or a command-line consumer. (Basic auth requires core's **HTTP Basic
  Authentication** module.)

Contrib providers such as OAuth appear here too once their modules are installed.

## Step 3 — Save

Click **Save configuration**. REST UI writes your choices into the
`rest.resource_config.{id}` configuration for that resource, and core begins serving
the resource with exactly the methods, formats, and authentication you selected.

## A note on permissions

Enabling a resource and picking its authentication does **not** by itself grant
access to the data. Core still checks the requesting user's **permissions** for the
underlying entity (for example *View published content* or *Article: Create new
content*). If an API call is authenticated but returns a 403, confirm the account
tied to that authentication actually holds the permission the operation requires.
