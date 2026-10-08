Debug Bar integrates the PHP Debug Bar library into Drupal to show information about the current request in an on-page bar for developers.

---

Debug Bar (`debugbar`) wraps the `maximebf/debugbar` PHP library and renders its bar at the bottom of every rendered HTML page via `hook_page_bottom()`/`hook_page_top()`. Out of the box it collects PHP info, memory usage, Drupal log messages, request POST/GET/server data, all site settings (`Settings::getAll()`), the current route name and parameters, and any exceptions thrown during the request. A `KernelEventSubscriber` also captures exceptions, folds request data into AJAX response headers, and stacks collected data across redirects so it survives to the next page. The module depends on the Vendor Stream Wrapper module to serve the library's bundled JS/CSS/font assets from the Composer `vendor/` directory. It is a development-only aid — the project explicitly advises against enabling it in production. There is no settings form. The bundled `debugbar_twig` submodule decorates the bar service to add a Twig template profiler pane. Requires the `maximebf/debugbar` Composer package (installed automatically when the module is required with Composer).

---

- Inspect Drupal log/watchdog messages generated during the current request without opening the database log.
- View the POST and GET variables submitted with the current request.
- Read the site's effective settings (`settings.php` values) for the current request while debugging.
- See the resolved route name and route parameters for the page you are on.
- Catch and read exceptions thrown during a request, including their stack traces.
- Monitor PHP memory usage for the current page render.
- Check the running PHP version and configuration via the PHP info collector.
- Debug AJAX requests by reading debug data folded into response headers (auto-show disabled to keep headers small).
- Keep debug data across redirects, so information from a POST-then-redirect flow is not lost.
- Profile Twig template rendering (which templates rendered, counts, timing) using the `debugbar_twig` submodule.
- Use it as a lightweight alternative to Webprofiler when you only need request/log/route/exception visibility.
- Verify which settings and route parameters are in effect on a staging or local environment.
- Trace why a page renders a particular route by confirming the route name at a glance.
- Confirm that expected log messages fire on a given action during local development.
- Diagnose form submissions by seeing the exact POST payload the server received.
- Reproduce and inspect an error by reading the exception collector after triggering it.
- Pair with Devel/Kint since the module ships a non-prefixed HTML var dumper compatible with the Symfony/devel dumper.
- Provide a quick on-page debug surface for developers new to a codebase to learn its routes and settings.
- Serve the library's Font Awesome fonts through the `/fonts/{filename}` route so the bar's icons render.
- Enable and disable the bar per environment simply by enabling/uninstalling the module (no configuration to manage).
