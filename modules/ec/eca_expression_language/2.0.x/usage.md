<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Expression Language adds a Symfony Expression Language condition to ECA, letting model conditions branch on an evaluated expression (comparisons, boolean logic, arithmetic, `in`/`matches`) computed over token values.

---

ECA Expression Language is a small add-on for the ECA (Event-Condition-Action) module. It contributes one ECA condition plugin, *"Expression language condition"* (id `eca_el`), built on the Symfony `symfony/expression-language` component. In an ECA model you attach this condition to any event or action gate, enter a single expression such as `[entity:nid] in [2, 6, 7] and ("[entity:type]" == "article" or [user:uid] == 1)`, and ECA replaces the tokens in that string and evaluates the resulting expression to a boolean. Compared with chaining several primitive ECA conditions with AND/OR containers, one expression can express composite logic (grouping with parentheses, comparisons, membership, regex matching, arithmetic) far more compactly. The condition has just two settings: the expression itself and a fallback value (True/False) returned if the expression is malformed or does not evaluate to a boolean. It depends on the `eca` module and requires no other configuration, permissions, routes, or services. The README also advertises an upcoming "Expression Language Value" feature for calculated token values; that is not present in this 2.0.x release, which ships the condition only.

---

- Gate an ECA action on a composite condition without stacking multiple condition plugins.
- Branch a model on `[entity:nid] in [2, 6, 7]` to match a small set of node IDs.
- Combine several checks with `and`, `or`, and parentheses in a single expression.
- Compare a token to a literal, e.g. `"[entity:type]" == "article"`.
- Check numeric thresholds such as `[node:field_price] > 100`.
- Test membership of a value in an inline list with the `in` operator.
- Use `not in` to exclude a set of values.
- Perform arithmetic inside a condition, e.g. `[commerce_order:total] * 1.2 > 500`.
- Apply the `matches` operator for regular-expression checks against a token value.
- Evaluate ternary logic (`a ? b : c`) to derive a boolean result.
- Combine string concatenation (`~`) with comparison for compound keys.
- Set the fallback to True so a broken expression fails open, or False to fail closed.
- Return False by default when an expression has a syntax error (logged to the `default` channel).
- Replace a long AND/OR tree of ECA conditions with one readable formula.
- Reference any ECA-available token (entity, user, current-user, custom model tokens) inside the expression.
- Drive conditional publishing, notifications, or field updates from a single expression.
- Guard an action so it only runs for specific content types or user roles expressed as tokens.
- Compare two token values to each other, e.g. `[node:field_start] < [node:field_end]`.
- Express "either/or" business rules that would otherwise need nested ECA gateways.
- Keep model logic self-documenting by writing it as one Excel-like formula.
- Prototype workflow logic quickly, since the whole condition is one text field.
- Reuse the same expression pattern across models by copying the condition config.
