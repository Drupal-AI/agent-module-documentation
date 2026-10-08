Castorcito webform adds a "webform" cfield so a Castorcito component can embed a Webform form.

---

Castorcito webform is a sub-module of Castorcito that requires the contributed Webform module. It registers one `CastorcitoComponentField` plugin, `webform` (class `Webform` extending `ConfigurableComponentFieldBase`), whose model stores `value` and `webform_id`. Editors pick a webform (via the component builder / autocomplete), and the cfield's SDC (`components/castorcito_webform/`) renders it with Twig Tweak's `drupal_entity(type, webform_id)`. Because it renders the Webform entity directly, the embedded form keeps its own access, validation, and submission handling. An update hook (`castorcito_webform_update_10101`) strips an obsolete `url_autocomplete` setting from existing webform cfields.

---

- Embed a contact or feedback form inside a landing-page component.
- Place a newsletter signup Webform within a banner or card component.
- Add a survey/registration Webform to a reusable content component.
- Reuse the same webform-enabled component across many nodes.
- Combine a webform cfield with text/image cfields to build a "call to action + form" section.
- Let editors choose which webform a component instance shows.
- Override the webform SDC markup from a theme with `replaces: 'castorcito_webform:castorcito_webform'`.
