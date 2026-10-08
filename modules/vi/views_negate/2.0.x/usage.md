<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Negate provides a "Negate" checkbox for text (string) and list contextual filters in Views, applying a not-equal / not-in condition just like the exclude option on numeric arguments.
---
Views ships an "Exclude" toggle for numeric contextual arguments but not for string/list ones, so there is no built-in way to say "show everything whose value is NOT X" from a string argument. This module fills that gap with a single Views argument plugin, `StringNegate` (`src/Plugin/views/argument/StringNegate.php`), exposed through `views_negate.views.inc`. When a string or `list_string` field is used as a contextual filter, a "Negate" checkbox appears under the argument's MORE fieldset; ticking it makes the query use a not-equal condition, or a NOT IN condition when "Allow multiple values" is enabled.

The module is deliberately tiny: it depends only on core Views, declares its config schema in `config/schema/views_negate.schema.yml`, and provides no routes, permissions, services, or external integrations. It is configured entirely within the Views UI at the contextual-filter level, so there is nothing to set up globally and no security surface beyond normal Views administration.
---
- Add a "Negate" option to a string contextual filter to exclude matching results
- Add a "Negate" option to a list_string contextual filter
- Show all content except items with a given taxonomy/list value passed as an argument
- Apply a NOT IN condition when the argument allows multiple values
- Mirror numeric-argument "exclude" behavior for text-based arguments
- Build a "related but not this" listing by negating the current item's value
- Exclude a specific machine-name value from a Views page via its URL argument
- Combine a negated string argument with other Views filters
- Toggle negation on/off per contextual filter without custom code
- Use negation on a list field defined via an allowed-values list
- Drive exclusion dynamically from a contextual filter's URL/argument value
- Configure entirely in the Views UI under the argument's MORE fieldset
- Avoid writing a custom Views argument handler for simple exclusions
- Support multi-value exclusion by enabling "Allow multiple values"
- Keep the query efficient by pushing the exclusion into the Views SQL condition
- Apply to any string field usable as a Views contextual argument
