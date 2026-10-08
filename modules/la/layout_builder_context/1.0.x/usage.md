Layout Builder Context lets any Layout Builder section, or an individual block inside it, be shown or hidden at render time based on contrib Context module conditions.

---

Core's Layout Builder gives you per-entity layouts but almost no conditional display: a section is either in the layout or it is not, and core block-visibility conditions do not reach into Layout Builder components. The usual workarounds — a duplicated layout per audience, or a bespoke block plugin — are heavy for what is really a visibility rule.

This module closes that gap by borrowing the Context module's condition system. Once enabled, Layout Builder's add-block, update-block and configure-section forms gain a **Context visibility** fieldset; you build the Contexts at Admin > Structure > Context as usual and simply select them. At render time an event subscriber (for blocks) and a `preprocess_layout` hook (for sections) hand the selected Context IDs to a small `Visibility` service, which asks the Context manager to evaluate each Context's conditions. If they fail — and the "All Contexts must pass" checkbox is on — the section or component's content is removed from the render array with `#access = FALSE`.

Two constraints matter. It drives **visibility only**: Contexts carrying Reactions have no effect through this module, and a disabled Context is treated as always passing. And when "All Contexts must pass" is unchecked, nothing is ever hidden — that mode is advisory. It is a deliberately thin layer (two classes plus a `.module`), so it inherits Context's evaluation semantics wholesale, and its filtering never runs inside the Layout Builder preview — only on the live render.

---

- Hide a whole Layout Builder section when a Context's conditions fail.
- Hide a single block component inside a layout without touching the rest.
- Reuse Context conditions you already built for the rest of the site inside Layout Builder.
- Show a promotional block only to anonymous (not-logged-in) users.
- Show an "upgrade" call-to-action only to authenticated users on a free plan.
- Vary a section's visibility by the current site language.
- Vary a component's visibility by request path or route.
- Show or hide layout areas by user role.
- Gate a component on a Context condition that inspects a user field value.
- Gate a component on a Context condition that reads a session cookie.
- Drive simple content personalization from a single node's layout.
- Set up an A/B-style show/hide of two components on the same page.
- Combine several Contexts on one component and require all of them to pass (AND logic).
- Attach a second Context with "Add another" to build a multi-condition rule.
- Use the "All Contexts must pass" toggle off to keep a component always visible while still tagging its Contexts.
- Avoid duplicating an entire layout just to serve a different audience.
- Avoid writing a custom block plugin solely to add visibility logic.
- Keep audience/visibility logic centralized in reusable Context entities.
- Show a seasonal banner section only during a date/time Context window.
- Hide a component for visitors from a particular country using a geo Context condition.
- Let the same node render different components for different segments of visitors.
- Preview a layout in Layout Builder without the visibility rules interfering (filtering is skipped in preview).
- Inherit correct cache contexts and cache tags automatically from each selected Context.
- Introduce conditional Layout Builder display on a site that already standardizes on the Context module.
- Verify visibility behavior with the module's kernel test before relying on it in production.
