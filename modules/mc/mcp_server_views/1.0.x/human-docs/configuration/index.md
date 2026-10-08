# Configuration

There is no single settings form for MCP Server Views. Configuration happens in two
places: you **author** a resource inside a view, and you **enable** the resource
providers in the MCP Server UI. This page walks through both, and explains the
access model you need to keep in mind.

## The access model — read this first

An MCP Resource is **read‑only**, but it is still an exposure of your content. When an
agent reads the resource, MCP Server Views **executes the view in the requesting
account's context** and returns the rows as JSON. That means:

- The view's **access settings** and **filters** are the only thing standing between an
  agent and the data. If the view would show a row to that account in a normal page, the
  agent gets that row too.
- Field values are rendered through each field's configured formatter, then stripped of
  HTML wrappers so they read as plain text. Fields marked *exclude from display* are
  omitted. Turning on **Raw output** for a field emits stored values instead.
- Scope resources tightly: filter to exactly the content you intend agents to read, and
  set the access plugin on the view accordingly. Do not expose a broad, unfiltered
  content view unless you truly mean to.

## Step 1 — Add an MCP Resource display to a view

1. Go to **Structure → Views** (`/admin/structure/views`) and create or edit a view.
2. Click **Add** next to the display list and choose **MCP Resource**.
3. Configure **fields**, **filters** and **sorts** as usual, and set the **MCP resource
   limit** (how many rows a single read returns).

## Step 2 — Configure field aliases

Under the display's **Row** settings, give each included field an **alias**. Aliases are
the JSON keys the agent will read, so choose clear, stable names (for example
`field_ingredients` → `ingredients`). Optionally enable **Raw output** per field to emit
the stored value rather than the rendered markup. Save the view.

- A display with **no parameters** is auto‑enumerated at `views://<view_id>/<display_id>`
  and appears under `resources/list`.
- A display with **contextual or exposed filters** becomes a *resource template* at
  `views://<view_id>/<display_id>/{param1}/{param2}/…`, where each placeholder is named
  after the Views handler ID. It appears under `resources/templates/list` instead.

## Step 3 — Enable the providers in MCP Server UI

Go to **Configuration → Web services → MCP Server → Resources** and enable the
**Resources** provider; if you use templated displays, also enable **Resource
Templates**. **Until both are enabled, MCP Resource displays are not advertised or
readable** — this is the on/off switch for the whole feature.

## Verify

Connect an MCP client (for example the Claude Desktop connector) and list resources. Each
MCP Resource display should appear as a callable resource; reading one should return JSON
with `rows`, `total`, `has_more` and `next_offset`. If a resource does not appear, check
that the providers are enabled in Step 3 and that the view grants the reading account
access to the rows.
