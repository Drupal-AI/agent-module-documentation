<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views user input field

Provides a global Views **field** ("User input field") that reads a value from the current
request's query string by a configured key and outputs it. Intended so that user-supplied
input (from an HTML form, a Webform, or an exposed filter's *Filter identifier*) can be
surfaced in a view row and reused in calculations (e.g. by *Views Simple Math Field*) or in
Twig when rewriting field output.

---

## Summary

`hook_views_data()` registers a `#global` field `user_input_field` under the "Custom Global"
group. The handler `ViewsUserInputField` (extends `FieldPluginBase`) has one setting,
`query_string_key`. `query()` is empty (it adds nothing to the SQL query — no join, no
column, so there is no SQL-injection surface). `render()` reads
`$request->query->get($queryStringKey)`, passes it through `Html::escape()`, and returns it
as `#markup` with a cache context of `url.query_args:<key>` so output varies correctly per
query value.

Because the value is escaped with `Html::escape()` before output, the rendered string is not
an XSS vector. The field is most useful as an input carrier for math/formula fields or Twig,
not for display of trusted data. Configure it per view by adding the field and entering the
query-string key (for an exposed filter, use its Filter identifier).

---

## Use cases

- Echo an exposed filter's current value elsewhere in the view (via its Filter identifier).
- Feed a user-entered number into *Views Simple Math Field* for a live calculation.
- Capture a query-string parameter passed from an external HTML form into the view.
- Read a Webform-submitted value forwarded as a query argument.
- Show "results for: X" style context by surfacing the searched query key.
- Use the value inside a Twig field rewrite to build a custom label or link.
- Multiply/divide a catalogued price by a user-supplied quantity query arg.
- Drive conditional field output based on a query parameter value.
- Pass a coupon/discount code query arg into a downstream computed field.
- Build a configurable unit converter view seeded from a query string.
- Combine several user-input fields as operands in one formula field.
- Personalize a greeting or filter summary from a `?name=` style parameter.
- Reflect a date chosen in an exposed date filter into a computed duration.
- Provide per-row context for tokens used in rewritten output.
- Expose the raw query value for debugging an exposed filter's identifier.
