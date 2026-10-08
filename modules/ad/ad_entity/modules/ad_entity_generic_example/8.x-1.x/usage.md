A commented, copy-me developer example showing how to register a custom load/remove handler for ad_entity_generic ads.

---

Advertising Entity: Usage Example for Generic ads is a developer-facing example submodule nested under ad_entity_generic. It ships no configuration, no config entities, and no PHP logic other than a single `hook_page_attachments()` that attaches its `ad_entity_generic_example/loader` JavaScript library on every page. That library, `js/example.loader.js`, is a heavily commented reference implementation that registers a custom load handler (and a matching remove handler) on `window.adEntity.generic`. The comments document the full `ad_tag` object contract used by the generic provider — `id`, `el` (DOM element), `name` (machine name), `format`, `targeting` (with `slotNumber`, `onPageLoad`, `personalized`), the `done(success, isEmpty)` completion callback, and the reserved `isLoaded`/`isEmpty` flags — and show how to `unshift` your handler so it runs before the built-in queue handler, how to consume the incoming `ad_tags` queue with `shift()`, and how to check the globally available `toLoad`/`toRemove` queues for tags that arrived before an asynchronously loaded script. The handlers themselves only `console.log`; the module explicitly warns not to use the logger in production. Enable it only in development to learn the pattern, then copy it into your own integration module.

---

- Learn the exact `ad_tag` object shape the generic provider hands to load handlers.
- Copy the boilerplate for registering a custom `loadHandlers` callback on `window.adEntity.generic`.
- See how to `shift()` and consume only the ad tags your handler is responsible for.
- Understand how to `unshift` a handler so it runs before the default queue handler.
- See how to drain the global `toLoad`/`toRemove` queues for tags that arrived before your async script.
- Learn where to call `ad_tag.done(true, false)` to report a successful, non-empty ad load.
- Reference the meaning of `targeting.slotNumber`, `targeting.onPageLoad`, and `targeting.personalized`.
- See how to check consent state via `window.adEntity.usePersonalization()` before loading.
- Use it as a scaffold when building a real integration for a network without an ad_entity submodule.
- Enable it in a dev environment to watch the load/remove lifecycle in the browser console.
- See how a remove handler is wired for when ad containers are detached (AJAX/behaviors).
- Model your own module's `hook_page_attachments()` library attachment on its example.module.
- Verify that generic ad containers are being collected and queued as expected during development.
- Teach a new developer the ad_entity_generic client-side contract from a single annotated file.
- Prototype a loader quickly, then disable the example module and ship your own version.
