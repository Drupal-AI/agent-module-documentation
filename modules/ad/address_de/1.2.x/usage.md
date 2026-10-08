Address DE adds Germany's 16 federal states (Bundesländer) as administrative-area subdivisions to the Address module's German (DE) address format.

---

Address DE is a small, configuration-free add-on to the contributed Address module. The underlying CommerceGuys addressing library deliberately omits German states from the postal address format because they are not part of a valid German mailing address. Some sites, however, need the states for other purposes — regional reporting, faceting, tax or shipping rules, or simply capturing the Bundesland alongside a stored address. On enable, Address DE registers one event subscriber (`AddressEventsSubscriber`) that listens to the Address module's `ADDRESS_FORMAT` and `SUBDIVISIONS` events. For the `DE` country code it appends an `%administrativeArea` line to the German format, marks the administrative-area type as "state", sets the subdivision depth to 1, and returns the fixed list of the 16 states with their ISO 3166-2 codes (for example `DE-BW` for Baden-Württemberg). The result is that any Address field configured to expose the administrative area shows a German state dropdown in the widget and a state line in the rendered address. There is no settings form, no route, and no permission — installing and enabling the module is the entire setup.

---

- Show a "state" (Bundesland) dropdown on address forms for German addresses.
- Capture the German federal state alongside street, postal code, and city in an Address field.
- Add the state line to rendered German addresses via the Address module's format.
- Populate address forms with the canonical 16 German states (16 Bundesländer) without hand-maintaining an options list.
- Store ISO 3166-2 subdivision codes (e.g. `DE-BE` for Berlin, `DE-BY` for Bayern) for German addresses.
- Enable regional segmentation of customers or members by German state.
- Support Views filtering or faceting of content by German federal state.
- Drive shipping, tax, or business rules that depend on the German state in a Commerce or custom workflow.
- Provide consistent, spelling-normalized state names on data-entry forms to reduce free-text errors.
- Extend the Address module without writing custom event-subscriber code for the German subdivisions.
- Add German states to profile, user, node, commerce order, or any entity using an Address field.
- Localize a German site's address handling to include the administrative area used elsewhere on the site.
- Feed downstream exports or integrations that expect a structured German state value.
- Improve address data quality for German B2B/B2C sites needing the Bundesland.
- Support analytics dashboards that break figures down by German region.
- Prefill or validate German state selection where the parent country is fixed to Germany.
- Keep German subdivision data in sync with the addressing library's event-driven extension points.
- Serve as a minimal reference example of using `AddressEvents::ADDRESS_FORMAT` and `AddressEvents::SUBDIVISIONS` to add subdivisions for any country.
- Combine with other country-specific Address add-ons to build a multi-country subdivision setup.
- Deploy with zero configuration across environments — behavior is fixed in code, nothing to export.
