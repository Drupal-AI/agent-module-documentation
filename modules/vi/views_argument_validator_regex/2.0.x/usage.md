<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Contextual Filter Validator: Regular Expression provides a regex argument validator for Views contextual filters.

---

Views Contextual Filter Validator: Regular Expression provides a regex-based argument validator for
Views contextual filters — so a contextual filter (argument) only accepts values matching a configured
regular expression, rejecting others. This lets you constrain what argument values a View accepts (e.g. only
numeric IDs, or a specific pattern). It depends on core Views.

Use it to validate/constrain View contextual-filter arguments. It is a site-search/Views feature that
validates the argument; validation shapes what the View accepts, and it has no access-control role
(validation is not access control — it constrains input format, not who can access). Note: the regex is
admin-configured; write anchored patterns (a poorly-written regex could be inefficient, though arguments are
typically short). Configure the regex on the contextual filter.

---

- Validate View arguments with regex.
- Constrain contextual-filter values.
- Reject non-matching arguments.
- Depend on core Views.
- Accept only numeric IDs (e.g.).
- Constrain argument format.
- Not use as access control.
- Have no access-control role.
- Configure the regex on the filter.
- Write anchored patterns.
- Validate the argument pattern.
- Shape what the View accepts.
- Handle contextual filters.
- Constrain input format.
- Validate arguments.
- Configure the validator.
- Reject bad arguments.
- Match argument patterns.
- Validate filter values.
- Constrain arguments.
