Rules Token lets you use Drupal tokens (from Token, Custom Tokens, and Custom Tokens Plus) inside Rules, providing one action to resolve a token to a value and two conditions to compare tokens/data.

---

The module registers three Rules plugins with no configuration UI or settings of its own: a `rules_token_get_token_value` **action** ("Get token value") that runs `\Drupal::token()->replace()` on a token string and provides the result as a new `token_value` context variable for later Rules steps; a `rules_token_compare_data_with_token` **condition** ("Compare Data with Token") that resolves a token and compares it against a Data value; and a `rules_token_compare_token_with_token` **condition** ("Compare Token with Token") that resolves two tokens and compares them. Comparison operators are `==` (default), `<`, `>`, `CONTAINS`, and `IN`, reusing the logic of Rules' own Data Comparison. Each plugin takes an optional "Entity of Token" context: for context-bound tokens like `[node:title]` or `[webform_submission:values:message]` you select the entity via the data selector (the module derives the entity type from the token prefix), while global tokens like `[date:html_date]` or `[site:url]` need no entity. Token replacement always uses `['clear' => TRUE]` so unresolved tokens become empty rather than leaking the raw `[...]` string. A `hook_form_FORM_ID_alter` on the Rules expression edit form adds a "Browse available tokens" link (`token_tree_link`, all token types, restricted shown) beside the token fields. Requires the Rules and Token modules.

---

- Capture a webform submission field value into a Rules variable after submission.
- Read `[node:title]` (or any node token) into a variable for use in a later Rules action.
- Get the current date via `[date:html_date]` inside a rule.
- Get the site URL via `[site:url-brief]` for use in a generated email.
- Pull a user token (e.g. `[user:mail]`) into a Rules variable.
- Resolve a Custom Tokens / Custom Tokens Plus token inside Rules.
- Compare a token's value against a literal Data value to branch a rule.
- Compare two tokens' values against each other (e.g. two date tokens).
- Use the `CONTAINS` operator to test whether a token value contains a substring.
- Use the `IN` operator to test membership against a list-valued token.
- Use `<` / `>` to compare numeric or date token values in a condition.
- Branch a rule on whether a webform field equals an expected value.
- Feed a resolved token value into a "Send email" action's body or subject.
- Use the token browser link on the Rules form to discover available tokens.
- Handle both global tokens (no entity) and entity-context tokens (with a data-selected entity).
- Avoid raw `[token]` leakage by relying on the built-in `clear` behavior.
- Build reaction rules on entity save that compute a value from tokens.
- Normalize/compare values coming from different entities via two-token comparison.
- Populate a scheduled-task rule with a computed date/URL from tokens.
- Extend Rules workflows without writing a custom Rules action plugin.
