Site Studio Gin is a zero-configuration compatibility shim that makes Acquia Site Studio (Cohesion) look and behave correctly when the Gin admin theme is active.

---

The module does two things and nothing else. First, it attaches CSS overrides: a global override library (`sitestudio-gin-global-overrides`) on every page, and a Gin-specific override library (`sitestudio-gin-gin-overrides`) only when Gin — or a subtheme of Gin — is the active admin theme (detected via `sitestudio_gin_is_gin_or_gin_subtheme()`, which walks the active theme's base-theme chain). On the Site Studio component front-end edit route (`sitestudio-page-builder.layout_canvas.frontend_edit_component`) it removes Gin's secondary toolbar so it doesn't intrude on the Site Studio editing iframe. Second, it re-styles Site Studio's Component Content add/edit forms to use Gin's node-form layout: `hook_form_component_content_edit_form_alter` (and the add-form variant) switch the form theme to `node_edit_form`, attach `claro/node-form`, and convert the vertical-tab groups (advanced, meta, revision info) into Gin-style containers/accordions; `hook_gin_content_form_routes()` registers the component_content routes so Gin applies its content-form layout there. It requires the Gin theme (a `hook_requirements` install check, borrowed from gin_toolbar, blocks install otherwise) and depends on the `cohesion` (Site Studio) module. There is no configuration, no permissions, no services, no schema — once enabled with Gin active it "just works". It enabled here with an optional-integration warning because Site Studio/Gin need not both be present, which is expected.

---

- Make Acquia Site Studio's admin UI render correctly under the Gin admin theme.
- Apply Gin's node-form layout to Site Studio Component Content edit forms.
- Apply the same Gin layout to the Component Content add form.
- Hide Gin's secondary toolbar inside the Site Studio component edit iframe.
- Load global CSS tweaks that align Site Studio widgets with Gin styling.
- Load Gin-specific CSS only when Gin (or a Gin subtheme) is the active theme.
- Register component_content routes for Gin's content-form layout treatment.
- Convert Site Studio form vertical tabs into Gin container/accordion groups.
- Ensure the module only activates its Gin overrides under a Gin-based admin theme.
- Block installation when the Gin theme is not present (requirements check).
- Provide a consistent admin editing experience for editors using Site Studio + Gin.
- Avoid manual CSS patching to reconcile Site Studio and Gin visuals.
- Keep revision-information and authoring metadata grouped as Gin expects.
- Support Gin subthemes automatically via base-theme chain detection.
- Ship as a drop-in module with no settings to configure.
- Reduce visual glitches when building pages in Site Studio with Gin enabled.
