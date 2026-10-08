<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
URL-friendly Options enforces that the keys of option-list fields (list_string / list_integer allowed-values keys) contain only alphanumeric characters and hyphens, so they are safe to use directly in URLs (e.g. as Views contextual-filter arguments).

---

The module has no configuration UI of its own (`configure` is null). It alters the field settings form (`field_config_edit_form`) for any field that exposes an allowed-values table: it adds an `#element_validate` callback that rejects saving when a key is not URL-friendly (regex `^[a-zA-Z0-9-]*[a-zA-Z0-9]+$`), and it overrides the built-in machine-name element so the auto-generated key uses hyphens instead of underscores (`replace_pattern` `[^a-z0-9\-]+`, `replace` `-`). It also implements `hook_requirements()` so the status report flags any existing `list_string` field storage whose allowed-values keys are non-compliant. A hook, `hook_url_friendly_options_bypass_field_validation($field_name, $entity_type_id)`, lets other modules exempt a specific field from both the form validation and the requirements check. It does not change existing stored values; it only blocks new/edited non-compliant keys. Depends on core `options`.

---

- Guarantee that a "category" select field's option keys (e.g. `breaking-news`) work as clean URL segments.
- Make option-list keys safe to pass as a Views contextual filter argument without extra rewriting.
- Force editors to type hyphenated keys (`first-value`) instead of underscored ones when adding allowed values.
- Auto-convert the machine-name suggestion in the allowed-values table to use hyphens as you type the label.
- Prevent spaces or special characters from ever entering a list field's keys.
- Surface a status-report error listing any existing list fields that still have non-URL-friendly keys.
- Audit a legacy site for option keys that would break clean URLs, via the runtime requirements check.
- Keep taxonomy-like select fields consistent with a slug convention across content types.
- Enforce URL-safe keys on a "status" or "state" list field used to filter a view by path.
- Standardise option keys so front-end routing and deep links stay predictable.
- Block a content editor from saving `second value!` as an allowed-values key.
- Exempt one specific field from the rule with `hook_url_friendly_options_bypass_field_validation()` while keeping it enforced everywhere else.
- Allow a migration-imported field with legacy underscore keys to bypass validation until it can be cleaned up.
- Ensure API/JSON consumers receive tidy, URL-safe enum keys from list fields.
- Keep option keys compatible with static-site generators that map them to file paths.
- Validate list field keys at edit time so problems are caught before content is created.
- Adopt a consistent hyphen-case convention for all new option-list fields on a project.
- Reduce the need for a custom Views argument rewrite by keeping keys clean at the source.
- Give site builders immediate, inline validation feedback when a key is not URL-friendly.
- Protect faceted-search or filter URLs that embed option keys from encoding issues.
- Maintain SEO-friendly, human-readable filter URLs derived from list field values.
