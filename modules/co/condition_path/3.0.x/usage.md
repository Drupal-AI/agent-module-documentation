Condition path adds a single condition plugin, "Request Path Include Exclude" (`request_path_inclexcl`), that lets you include AND exclude paths at the same time in one visibility rule — unlike core's Request Path condition, which is whitelist-only or blacklist-only.

---

The module provides one Condition plugin (`RequestPathInclexcl`) that extends core's
`system` `RequestPath` condition, so it plugs into any Conditions consumer (block visibility, Page Manager,
Rules, etc.). In the plugin's *Pages* textarea each line is a path pattern; a leading `!` marks that line as
an **exclude**. `evaluate()` lowercases the current path and its alias, splits the lines, then groups
consecutive include lines and consecutive exclude lines into ordered groups (`groupPages()`), matching each
group with core's `PathMatcher`. Groups are evaluated in order and the **last matching group wins**, so a
later, more specific exclude/include line overrides an earlier broader one — meaning order matters and more
specific paths must be placed lower in the list. It matches against both the internal path and the path
alias, supports the `<front>` token and `*` wildcards, and honors the condition's `negate` flag. Validation
requires each non-empty line to be `<front>`, or start with `/`, `*`, `!/` or `!*`. The module also does a
small `hook_form_block_form_alter` to relabel the plugin to "Pages (include and exclude)" on block forms and
sit it next to core's Pages control. `configure` is null (there is no admin settings page); config for an
instance is stored on the host object as `condition.plugin.request_path_inclexcl` with a single `pages`
string.

---

- Show a block on a section and all its subpages but hide it on specific child pages, in one rule.
- Include `/news` and `/news/*` while excluding `!/news/*/comments` without a second condition.
- Show a block everywhere except a subtree, then re-include a specific page under that subtree.
- Combine include + exclude path logic that core's whitelist-OR-blacklist condition cannot express.
- Control block visibility with ordered, most-specific-last path rules.
- Restrict a menu block, Page Manager variant, or Rules action by an include/exclude path set.
- Use `<front>` to target (or exclude) the front page in a visibility rule.
- Use `*` wildcards to match whole path subtrees for inclusion or exclusion.
- Match against path aliases as well as internal paths (case-insensitively).
- Show a block on all pages (`*`) except news article pages but keep it on news comment pages.
- Hide a promo block on checkout/account subpages while showing it site-wide.
- Group include and exclude paths for better path-matching performance.
- Negate the whole condition (flip include/exclude) via the standard Conditions `negate` toggle.
- Present editors a familiar "Pages (include and exclude)" control alongside core's Pages field on blocks.
- Reuse the same include/exclude path logic anywhere Drupal's Condition plugin API is consumed.
- Migrate a whitelist + blacklist pair of core Request Path conditions into a single rule.
