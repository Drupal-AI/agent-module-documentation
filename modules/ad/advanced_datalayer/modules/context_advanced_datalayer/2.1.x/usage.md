Context Advanced Datalayer bridges the Context module and Advanced Datalayer, letting you set GTM dataLayer tag values through Context reactions so datalayer variables can be applied conditionally (by path, role, entity type, etc.) rather than only per page type.

---

The submodule adds one plugin: a **Context reaction** `context_advanced_datalayer`
(`@ContextReaction`, class `ContextAdvancedDatalayer`). When you add this reaction to a Context, its configuration form is built from `advanced_datalayer.manager->form(...)` — the same tag-value UI the base module uses — so you can enter values for the available datalayer tags. The chosen values are stored in the Context's `reactions.context_advanced_datalayer` config as a `tag_id => value` map. At request time the submodule implements `hook_advanced_datalayer_alter()`: it asks `context.manager` for all **active** `context_advanced_datalayer` reactions (i.e. every Context whose conditions currently match), executes each, and merges their tag values into the datalayer array that Advanced Datalayer is about to push — so whichever Contexts are active on the current request contribute their variables. It sets its module weight to 1000 on install so it runs after Context. It has no routes, permissions, services, or config schema of its own; everything is driven through the Context UI and the base Advanced Datalayer module.

---

- Push different dataLayer variables based on URL path using a Context path condition.
- Set analytics variables only for users in a specific role via a Context role condition.
- Apply datalayer values on a section of the site (e.g. `/blog/*`) without touching page-type defaults.
- Add campaign-specific dataLayer variables that switch on and off with a Context.
- Combine multiple Context conditions (path + role) to target datalayer values precisely.
- Override or add a `site_Category`/`event` value only when a Context is active.
- Layer conditional datalayer values on top of the base module's per-page-type defaults.
- Emit a dataLayer flag for logged-in vs anonymous users.
- Manage marketing datalayer variables through the familiar Context UI.
- Turn a set of datalayer variables on for a landing-page Context during a promotion.
- Provide per-language datalayer values by pairing with a Context language condition.
- Keep conditional datalayer logic in exportable configuration (the Context entity).
- Merge several active Contexts' datalayer values on one request.
- Set datalayer variables for a specific content type via a Context entity condition.
- Avoid custom code for conditional GTM variables by using Context reactions.
