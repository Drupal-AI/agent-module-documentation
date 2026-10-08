<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Regex Functions (views_regex_functions) — agent index

**A Views field + filter that apply admin-defined regex replace/match to other fields' rendered output.**

- **Version:** 1.2.x  (info.yml `1.2.0`)  •  **Core:** ^9 || ^10 || ^11  •  **Depends on:** views
- **Field:** `@ViewsField("views_regex_functions_field")` — `src/Plugin/views/field/ViewsRegexFunctionsField.php` (`render()` = `preg_replace(pattern, replacement, subject)`)
- **Filter:** `@ViewsFilter("views_regex_functions_filter")` — `src/Plugin/views/filter/ViewsRegexFunctionsFilter.php` (row removal in `hook_views_post_execute`; `canExpose()` = FALSE)
- **Data/hooks:** `views_regex_functions.views.inc`, `.module` (`hook_module_implements_alter` orders itself first)
- **Options:** pattern, search_subject (`{{ field }}` tokens), replacement, strip_tags, allowed_tags

**Security:** No routes or permissions; configured in the Views UI (*administer views*). The regex pattern is **admin configuration, not request input** — the filter explicitly cannot be exposed (`canExpose()` returns FALSE) and its subject is validated to a single field token. Patterns are validated with `@preg_match($pattern, '')`; PHP has no `/e` eval modifier, so there is no preg-injection/RCE and no visitor-supplied-regex ReDoS. Residual risk is only a privileged Views admin authoring a catastrophic pattern (trusted role). Output is a plain string returned to Views' normal (escaping) render pipeline.

See [configure/field-filter.md](configure/field-filter.md)
