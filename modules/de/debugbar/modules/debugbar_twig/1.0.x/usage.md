Debug Bar Twig adds a Twig template profiler pane to the Debug Bar, showing which templates rendered during the current request with timing.

---

Debug Bar Twig (`debugbar_twig`) is a submodule of Debug Bar. It decorates the parent module's `debugbar.debugbar` service with `Drupal\debugbar_twig\TwigDebugBar`, which extends `DrupalDebugBar` and adds a `DebugBar\Bridge\NamespacedTwigProfileCollector`. It also registers a `Twig\Extension\ProfilerExtension` (tagged `twig.extension`) wired to a shared `Twig\Profiler\Profile` object, so Twig records per-template profiling data that the collector then renders as a pane in the debug bar. It has no configuration and no routes or permissions of its own; enabling it simply adds the Twig pane. Requires the `debugbar` module (and, transitively, `vendor_stream_wrapper` and the `maximebf/debugbar` Composer package).

---

- See the list of Twig templates rendered while producing the current page.
- Inspect how many times each template was rendered during a request.
- Review per-template render timing to spot slow or repeatedly rendered templates.
- Identify unexpected template rendering (e.g. a template rendered far more often than expected).
- Debug theme override resolution by confirming which template actually rendered.
- Complement the parent bar's route/log/exception panes with template-level insight.
- Profile a page's render tree without a full profiler like Webprofiler.
- Confirm that a newly added template is being picked up and rendered.
- Diagnose render-array performance issues during local theme development.
- Verify caching behavior by observing whether a template re-renders on repeated requests.
- Teach new developers which templates compose a given page.
- Enable only when needed by turning the submodule on/off independently of the parent bar.
- Correlate template rendering with the request/route shown by the parent Debug Bar.
- Use during theme refactors to ensure old templates stop rendering and new ones take over.
- Spot N+1 style template rendering caused by loops over entities.
