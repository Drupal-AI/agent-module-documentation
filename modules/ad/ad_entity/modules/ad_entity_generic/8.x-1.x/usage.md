Provides a provider-agnostic "generic" ad type and JavaScript view as a skeleton for wiring up custom ad implementations.

---

Advertising Entity: Generic ads is a submodule of the ad_entity project. It registers a `generic` AdType plugin ("Generic slot", `GenericType`) and a `generic` AdView plugin ("Generic ads via JavaScript", `GenericJsView`). The view is deliberately minimal: it renders only an empty container `<div>` (theme `ad_entity_generic_js`, template `ad-entity-generic-js.html.twig`) carrying the configured identifier as its DOM id, an `adtag` CSS class, and a `data-ad-format` attribute. It ships no code that actually fetches an ad — instead its `js/generic.base.js` sets up a queue on `window.adEntity.generic` with `load`/`remove` handler lists, and `js/generic.view.js` collects each slot into an `ad_tag` object (id, element, machine name, format, targeting, and a `done(success, isEmpty)` callback) and pushes it to those handlers. A site builder or developer supplies the real loading logic by registering a handler (the bundled `ad_entity_generic_example` submodule demonstrates this). Per-slot configuration is an Identifier, a Display format, and optional default targeting key-value pairs. A global setting can also expose applicable page targeting as a named global JavaScript variable (default `dataLayer`) written into an inline script in the page head.

---

- Build a custom ad integration for a network that has no dedicated ad_entity submodule.
- Render an empty, class-tagged ad container that your own JS fills asynchronously.
- Expose page-level targeting to a tag manager (e.g. Google Tag Manager) via a `dataLayer` variable.
- Attach default key-value targeting to a slot from its Advertising entity form.
- Register a custom load handler on `window.adEntity.generic.loadHandlers` to inject ad markup.
- Register a remove handler to clean up ads when containers are detached (AJAX/behaviors).
- Give each ad slot a stable identifier and a display-format string your handler reads.
- Integrate a house ad server or in-house creative rotation without writing a new plugin type.
- Use the `data-ad-format` attribute to select a creative size/format in your loader.
- Read per-slot targeting (`ad_tag.targeting`) including slotNumber, onPageLoad, and personalized flags.
- Respect consent by checking `window.adEntity.usePersonalization()` before loading personalized ads.
- Queue ads that arrive before your async loader script (via the global `toLoad`/`toRemove` queues).
- Signal fill/empty state back to ad_entity by calling `ad_tag.done(success, isEmpty)`.
- Combine with ad_entity_fallback so an empty generic slot falls back to another ad.
- Prototype an ad layout with a stub loader before the real ad tags are ready.
- Serve different targeting per page by feeding Advertising context into the global targeting variable.
- Turn ads off contextually: a `turnoff` context makes the global targeting push `{show_ads:false}`.
- Manage generic slots per theme breakpoint like any other Advertising entity.
- Place generic ad Display configs as blocks through the standard ad_entity display workflow.
- Learn the handler pattern from the included ad_entity_generic_example loader before writing your own.
