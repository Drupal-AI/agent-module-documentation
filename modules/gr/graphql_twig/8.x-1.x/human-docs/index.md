# GraphQL Twig — manual setup guide

**GraphQL Twig** (`graphql_twig`) lets a Twig template fetch its own data by
embedding a GraphQL query directly in the template. Normally you get data into a
template through a preprocess function or a view — code or configuration that
runs first and passes variables in. GraphQL Twig inverts that: you write the
query inside the template, the module runs it during an extra preprocessing
step, and the result is handed to the template as a `graphql` variable. No site
building, no manual preprocessing.

You write the query inside a special `{#graphql … #}` comment block at the top of
the template, then read the results from `graphql.*` in the markup below. The
module also collects query fragments from included templates and tries to match
template variables to query arguments automatically, so a component's data
requirements can sit right next to the markup that uses them — handy for a front
end assembled largely from GraphQL.

Because the templates here are **theme templates authored by developers** — not
user input — this is not a template-injection risk in the untrusted-input
sense; an attacker doesn't supply the Twig or the query. What matters instead is
what a query can *reach*: an embedded query runs against your GraphQL schema with
whatever access that schema and the current user allow. The security boundary is
therefore your GraphQL schema's own field access, not this module. Design that
access deliberately, and this module simply surfaces it in templates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside GraphQL.

There is **no configuration page** for this module — everything happens in your
theme's Twig templates.

## How to use it

Add a `{#graphql … #}` comment block with your query at the top of a template
override, then read the results from the `graphql` variable in the markup. For
example, a "Powered by Drupal" block override that also greets the admin:

```twig
{#graphql
query {
  admin: userById(id: "1") { uid name }
  user: currentUserContext { uid }
}
#}

{% extends '@bartik/block.html.twig' %}
{% block content %}
  {% set admin = graphql.admin %}
  {% set user = graphql.user %}
  {{ content }} and
  {% if user.uid == admin.uid %}
    you, {{ admin.name }}.
  {% else %}
    you, appreciated anonymous visitor.
  {% endif %}
{% endblock %}
```

The query in the comment is executed in an extra preprocessing step and its
result populates the `graphql` variable. Clear caches (`drush cr`) after adding
or changing an embedded query.

> **Note:** This `8.x-1.x` / 3.x branch is compatible with **GraphQL 3.x**. Use
> the 4.x branch if your site runs GraphQL 4.x — the two GraphQL versions differ
> significantly. A configured GraphQL server is required either way.
