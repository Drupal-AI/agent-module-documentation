# AOS JS — agent index

Integrates the [AOS](https://github.com/michalsnik/aos) "Animate On Scroll" JS library.
Base module: registers asset libraries + auto-attaches AOS on non-admin pages and inits it
with `AOS.init()`. No config, no permissions, `configure` is null. Animate elements with
`data-aos="..."` HTML attributes. PHP helpers supply option lists for the UI submodule.

- **Asset libraries, CDN-vs-local loading, `data-aos` markup usage, and the `aosjs_*` PHP option helpers / `hook_aos_animation_names()`** → [api/library.md](api/library.md)

Submodules (own docs):
- `aosjs_ui` — selector-management admin UI (config, `aos` DB table, service) → [../../modules/aosjs_ui/1.0.x/agent/start.md](../../modules/aosjs_ui/1.0.x/agent/start.md)
- `aosjs_animatecss` — swaps AOS animations for Animate.css → [../../modules/aosjs_animatecss/1.0.x/agent/start.md](../../modules/aosjs_animatecss/1.0.x/agent/start.md)

Key facts:
- Libraries (in `aosjs.libraries.yml`): `aos-v2.js` / `aos-v2.cdn` (AOS 2.3.4), `aos-v3.js` / `aos-v3.cdn` (3.0.0-beta.6), `aos.init`.
- Auto-attach only happens when neither `aosjs_ui` nor `animatecss_aos` is enabled (`aosjs_page_attachments()`).
- Local copy at `libraries/aos` is preferred; otherwise CDN (`aosjs_check_installed()`).
- Init is a plain `AOS.init()` in `js/aosjs.init.js` (`Drupal.behaviors.aosInit`).
