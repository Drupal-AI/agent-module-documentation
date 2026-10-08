<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Twig injects GraphQL query results into Twig templates by embedding the query in the template itself, so a theme template can fetch its own data with no preprocessing or site building.

---

The normal way to get data into a Twig template is a preprocess function or a view — code or config that runs before the template and passes variables in. GraphQL Twig inverts that: you write a GraphQL query directly inside the theme template, and the module runs it and makes the result available to the template. For a front end assembled from GraphQL, that keeps a component's data requirements next to its markup.

The templates here are **theme templates authored by developers**, not user input — the GraphQL query is written by whoever writes the template, in the theme layer, exactly like any other Twig. So this is not a server-side-template-injection surface in the untrusted-input sense: an attacker does not supply the Twig or the query. It requires the contrib **GraphQL** module (3.x) and a configured GraphQL server.

What to keep in mind is what the query can reach: a template's embedded query runs against the site's GraphQL schema with whatever access that schema and the current user allow. So the security boundary is the GraphQL schema's own access control, not this module — a template can only fetch what the GraphQL layer would already expose to that user. Design the schema's field access deliberately, and this module simply surfaces it in templates.

---

- Fetch data in a Twig template.
- Embed a GraphQL query in a template.
- Skip preprocess functions.
- Co-locate data needs with markup.
- Build a GraphQL-driven front end.
- Query the schema from a template.
- Render a component with its own data.
- Avoid custom preprocessing.
- Use GraphQL 3.x with theming.
- Populate a template via GraphQL.
- Keep data logic in the template.
- Fetch a node's fields by query.
- Compose data-driven components.
- Rely on the GraphQL schema's access control.
- Design schema field access deliberately.
- Require the GraphQL module.
- Configure a GraphQL server.
- Render lists from a query.
- Template against the site schema.
- Simplify a decoupled-ish theme.