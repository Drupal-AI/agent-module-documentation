Site Studio Webform Element adds a "Webform" custom element to the Acquia Site Studio builder so an editor can drop an existing Webform into a component.

---

Acquia Site Studio (Cohesion) builds pages from its own vocabulary of drag-and-drop elements, and a Webform is not one of them. This module registers a `CustomElement` plugin (`WebformElement`, id `site_studio_webform_element`) that appears in the Layout Canvas as a **Webform** element with a single select field listing every Webform on the site by label. When the component renders, the chosen form is placed via a lazy builder (`#create_placeholder` + `#lazy_builder`) that hands off to core's `#type => 'webform'` render element — so the form is loaded late in the render pipeline, keeping the surrounding component cacheable instead of taking the uncacheable penalty of rendering a form inline. Nothing about the form itself moves: its fields, validation, handlers, confirmation and access all stay in Webform, and the module only records which form id to place. It is deliberately the same shape as the Site Studio Views Element module, only for Webform, and it avoids creating Webform nodes or blocks. The module also ships a small endpoint and JS helper (`/api/cohesion/webform-list`, `siteStudioWebformElementList`) so a component form's Select field can be populated dynamically as an "external data source" or "options from a custom function" for token-driven form placement. It requires the commercial Site Studio stack (`cohesion`) plus `webform`; on a site without Site Studio it does nothing.

---

- Place an existing Webform inside a Site Studio component from the Layout Canvas.
- Let a content editor add a form to a page without a developer editing a template.
- Pick which form a component shows from a select list of all site Webforms.
- Keep a form's fields, validation, handlers and confirmation entirely in Webform.
- Change a form's configuration without touching the page it sits on.
- Move or reorder a form on a page by moving the component, not editing the form.
- Avoid creating a Webform node or Webform block just to show a form on a built page.
- Keep the surrounding component cacheable by lazy-loading the form at render time.
- Reuse one Webform across many pages built in Site Studio.
- Build a single "form" component whose form is chosen per placement.
- Drive form choice from a component form Select field using a token value.
- Populate that Select dynamically from `/api/cohesion/webform-list` as an external data source (Site Studio 7.5.0+).
- Populate that Select via a custom function by entering `siteStudioWebformElementList` as the function name.
- Mirror the Site Studio Views Element pattern for forms instead of views.
- Confirm the site's Site Studio licence covers using the builder at all.
- Verify a placed form still shows after a Webform or Site Studio upgrade.
- Audit which built pages carry which forms by reviewing component values.
- Standardise how designers embed contact / signup / survey forms in components.
- Present the same form on many landing pages with consistent styling from the component.
- Document for the team that form behaviour is Webform's and placement is Site Studio's.
