# AOS JS + AnimateCSS — agent index

Glue submodule: makes AOS JS UI use [Animate.css](https://animate.style/) effects instead of
AOS's built-in animations. No config/routes/permissions of its own — it swaps the `_form`
handlers on the AOS admin routes. Depends on `aosjs_ui` + the `animatecss` contrib module.

- **How the route swap and the `options.library = animate` form behavior work, install/uninstall hooks** → [configure/animatecss.md](configure/animatecss.md)

Parent module: [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md) ·
Sibling: `aosjs_ui` → [../../../aosjs_ui/1.0.x/agent/start.md](../../../aosjs_ui/1.0.x/agent/start.md)

Key facts:
- `aosjs.route_subscriber` (`RouteSubscriber`) overrides `_form` on routes `aosjs.settings`, `aosjs.add`, `aosjs.edit`.
- Replacement forms: `AosJsAnimateCssSettings extends AosJsSettings`, `AosJsAnimateCssForm extends AosJsForm`.
- Active only when `aosjs.settings:options.library == 'animate'`; otherwise falls back to AOS options.
- Settings/targets still stored in `aosjs.settings` + the `aos` table (owned by `aosjs_ui`).
