# Configuration

Route aliases are managed at **Configuration → Search and metadata → URL aliases →
Route aliases** (`/admin/config/search/path/route-aliases`). You need the
**administer route path aliases** permission to use it. The module ships with no
aliases, so you build up the list yourself.

## Adding an alias

Each alias maps a route that contains dynamic parameters to a friendlier pattern
that reuses those parameters. The classic example:

```
/user/{user}  →  /person/{user}
```

Here `{user}` is the dynamic parameter carried over from the original route into
the alias, so `/user/42` becomes reachable as `/person/42`. Because the module
works on the route (not a single fixed path), one alias covers every value of the
parameter. Aliases can be created for **any route, core or custom**.

## Multiple languages

Aliases are language‑aware. For a multilingual site you can define a **different
alias per language** for the same route, so each language gets a URL in its own
words. Set the alias text for each language you want to support when you create or
edit the alias.

## Parameter conditions

For parameters that can point at different kinds of content, you can make the
alias depend on the parameter's value. For example, for `/node/{nid}` you can add
a **condition on the bundle (content type)** of the `{node}` entity, so articles
and pages get different alias patterns from the same route. Use conditions when
one route should produce distinct aliases depending on what the parameter refers
to.

## Save

Save the alias. The new URL becomes active for the matching route (and, where you
defined them, for each language). Visit the aliased path to confirm it resolves to
the original route's page.
