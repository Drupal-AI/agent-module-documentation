# Configuration

The settings form is the route `graphql_compose.fragments`, alongside the other
GraphQL Compose settings. It controls how fragments are generated from your live
schema and, optionally, whether they are exposed on the schema itself.

## Generate fragments

From the settings form you generate a named, reusable field selection (a fragment)
for each type in the GraphQL Compose schema. Because generation reads the **live**
schema, the fragments always reflect your current entity types, fields and view
modes. Treat the output as a **starting point** — the fragments are a guide to get
you moving, not a final query design; refine them to match what each part of your
application actually needs.

## Expose fragments on the schema (optional)

There is an option to **enable fragments on the schema**, which adds them to the
`info` query so a client can retrieve the fragment definitions at runtime:

```graphql
query {
  info {
    fragments {
      type
      name
      class
      content
    }
  }
}
```

Enable this only if your workflow benefits from clients discovering fragments
through the API; many teams instead commit the generated fragment files and skip
runtime exposure.

## Recommended workflow

1. **Configure** and **generate** the fragments here.
2. **Commit** the generated fragments alongside your front‑end code, so a
   content‑model change surfaces as a pull‑request diff.
3. **Regenerate** whenever the content model changes, and feed the fragments into
   your codegen tooling to produce a typed client.

Because this module has no permissions or routes of its own beyond this form, who
can reach the generated data is governed by **GraphQL Compose's own access model**
and your GraphQL endpoint configuration.
