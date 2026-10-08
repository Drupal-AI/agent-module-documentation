Block Exclude Pages extends the core "Pages" (request path) block-visibility condition so individual paths can be *excluded* from a wildcard rule by prefixing them with `!`.

---

Drupal core's block visibility "Pages" condition (the `request_path` condition plugin) lets you show or hide a block on a list of paths, with `*` wildcards, but it has no way to carve an exception out of a wildcard — e.g. "show on all of `/user/*` except `/user/jc`". Block Exclude Pages fills that gap. It implements `hook_condition_info_alter()` to swap the core `request_path` condition class for its own `BlockExcludePagesRequestPath` subclass, so **every** block's Pages setting site-wide gains exclusion syntax with no per-block opt-in. In the Pages textarea you still list one path per line; any line prefixed with `!` is an *exclude* pattern (it too supports `*` wildcards, e.g. `!/user/jc/*`). The custom `evaluate()` collects whether the current path matches a normal (include) pattern and whether it matches an exclude pattern, then returns the two XORed — so an excluded path flips the block's visibility back off (or, with the condition negated / set to "hide for the listed pages", back on). Order matters: patterns are processed top to bottom, and a later line can re-include a path a wildcard excluded, or vice-versa. The module adds no config schema, permissions, services beyond a logger channel, or admin routes of its own — it purely enhances the existing Block layout UI at Admin → Structure → Block layout. Validation is also relaxed so a line may legally start with `!/` or be `!<front>`.

---

- Show a block on every user profile (`/user/*`) but hide it on one specific profile (`!/user/jc`).
- Display a sidebar across a whole section (`/offices/human-resources/current-employees/*`) except one landing page (`!/offices/human-resources/current-employees/manager-resources`).
- Hide a promo block sitewide but re-show it on selected pages by combining "hide for listed pages" negation with `!` exclusions.
- Keep a call-to-action on all article pages while suppressing it on paywalled or legal sub-pages.
- Show a menu block under `/products/*` but not on the checkout flow (`!/products/*/checkout`).
- Exclude the front page from an otherwise sitewide banner using `!<front>`.
- Show a block on a documentation tree but not on its printer-friendly variants (`!/docs/*/print`).
- Suppress a newsletter signup on the user's own account/edit pages (`!/user/*/edit`) while keeping it on public profiles.
- Run a seasonal banner on `/*` while excluding admin paths (`!/admin/*`, `!/node/*/edit`).
- Show a "related events" block across `/events/*` but not on archived events (`!/events/archive/*`).
- Carve a single deep page out of a wildcard, e.g. show on `/user/jc/*` but not `/user/jc/settings/mc` (`!/user/jc/*/mc`).
- Re-include one page inside an excluded branch by ordering an include line after the exclude line.
- Restrict a support-chat widget to logged-in areas but off the login/register forms (`!/user/login`, `!/user/register`).
- Present a department block on `/offices/*` but hide it for a merged/deprecated department path.
- Show breadcrumb-style helper blocks under a section while excluding its taxonomy term listing pages.
- Keep an ad block on content pages but exclude search results (`!/search/*`) and 404-ish utility routes.
- Show a block on a multi-step form's first steps but not the confirmation page (`!/order/*/complete`).
- Combine several wildcards and exclusions to model complex "show here, but not there" visibility without writing a custom condition plugin.
- Migrate hand-written per-block visibility PHP into declarative path rules by expressing exceptions as `!` lines.
- Exclude localized/aliased variants of a page from a wildcard by listing their aliases as `!` patterns (matching runs against both the alias and the internal path).
- Provide editors a self-service way (in the standard Block UI) to add page exceptions without a developer.
- Test path rules quickly by listing include and exclude patterns together and letting order resolve precedence.
