Context lets you define reusable "sections" of a site as a set of conditions plus reactions: when the conditions match the current request, the configured reactions fire (place blocks, switch theme, add body classes, alter page-title/template suggestions, set the active menu trail). (This release is 5.0.0-rc2, a release candidate.)

---

Context is built around a single `context` config entity. Each context holds a list of **conditions** and a list of **reactions**. Conditions reuse Drupal core's standard Condition plugins (request path, user role, node type, language, plus a few Context-provided ones like request domain, HTTP status code, request-path exclusion, user profile page, and view inclusion), and you choose whether *all* conditions must pass (`requireAllConditions`, AND) or *any* (OR); a context with no conditions is treated as sitewide. Reactions are Context's own `ContextReaction` plugin type: the flagship **blocks** reaction places blocks into theme regions (an alternative to core Block layout, with per-context visibility), plus **theme** (switch theme), **body_class**, **page_title**, **page_template_suggestions**, **menu** (set active menu trail), and **regions** (disable regions). The `context.manager` service evaluates every context on each request and exposes the active reactions; module hooks (`context_preprocess_html`, `context_theme_suggestions_page_alter`, an event subscriber `BlockPageDisplayVariantSubscriber`, and a `theme_negotiator`) apply them. Contexts can be grouped and weighted. All configuration lives in the `context` config entity, so contexts export and deploy with the rest of your config. The admin UI to build contexts lives in the separate **context_ui** submodule at `/admin/structure/context`; the base module ships only the entity, plugins, services and one edit route. Developers extend the system by writing a new `ContextReaction` plugin in `Plugin/ContextReaction`.

---

- Place a block only on pages matching a path pattern, without touching core Block layout.
- Show a promotional block to authenticated users but not anonymous ones (role condition).
- Switch to a different theme for a whole "section" of the site (theme reaction).
- Add a body CSS class on specific pages so a theme can style them (body_class reaction).
- Override the page title on matched pages (page_title reaction).
- Add extra Twig template suggestions for a section so you can build a custom page template.
- Set the active menu trail/breadcrumb for pages that aren't naturally in the menu (menu reaction).
- Disable/unset theme regions on certain pages (regions reaction).
- Build a context that fires sitewide by leaving its conditions empty.
- Require ALL conditions (AND) to narrowly target a page, or ANY (OR) for broader matching.
- Group related contexts and order them by weight for predictable evaluation.
- Target a page by domain using the Context request_domain condition.
- Trigger reactions on 403/404 pages via the http_status_code condition.
- Exclude specific paths from an otherwise sitewide context (request_path_exclusion).
- Fire a reaction only on a user's own profile page (user_status condition).
- Activate a context when a particular View is rendered (view_inclusion condition).
- Chain contexts together with the context (any) / context_all conditions.
- Duplicate an existing context as a starting point for a new one.
- Disable a context temporarily without deleting it.
- Export contexts as configuration and deploy them between environments.
- Write a custom ContextReaction plugin to trigger any site behavior when conditions match.
- Fetch the currently active reactions in code via the context.manager service.
- Reuse any third-party Condition plugin (e.g. from other contrib modules) as a context condition.
- Replace scattered per-block visibility rules with centralized, reusable contexts.
- Include or exclude the default Block-layout blocks alongside context-placed blocks (blocks reaction).
