# Configuration

Setting up Swagger UI Info is two steps: supply the spec you want to display, and
decide who may view it.

## Upload your Swagger spec

1. Log in as an administrator.
2. Open the module's settings page.
3. **Upload the Swagger file** you want to display, or leave the bundled **example
   file** in place to try it out.
4. Save.

Your API documentation is then rendered with Swagger UI at **`/swagger_info`**,
where developers can browse the endpoints and, where the spec allows, use the "try
it out" feature to make live calls.

## Control who can view the explorer

The module provides its own permission for viewing the documentation. On
**People → Permissions**, grant it only to the roles that should see the API
explorer.

This matters because the Swagger UI page exposes your **API surface** — the
endpoints and their parameters — to anyone who can reach it, and its "try it out"
calls run with the **caller's own authentication**. So:

- Gate `/swagger_info` to the intended audience via the permission; do not leave it
  open to anonymous users unless you truly intend the API to be publicly
  documented.
- Do not publish documentation for internal or undocumented endpoints you want to
  keep private.
- Remember that any interactive call a viewer makes uses their own credentials, not
  a shared or elevated account.
