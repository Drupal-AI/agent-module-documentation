Error Reporting replaces Drupal's default exception output with a rich, styled error page that shows the exception type, message, source-code excerpt around the failing line, full stack trace, and request/server/session/cookie context.

---

The module registers a custom PHP exception handler and a high-priority kernel `EXCEPTION` event subscriber. When custom error reporting is enabled (a single on/off setting), a thrown exception is rendered through the `custom_error_display` theme hook using `ExceptionFormatter`, which builds a browsable stack trace (each frame with its own file/line and a ±17-line source snippet), plus tables for the `$_SERVER`, request, cookie and session data and an "App" panel with the Drupal and PHP versions. The kernel-event path is gated by the restricted "View error reports" permission, and the whole feature can be toggled off from a settings form so it stays disabled on production. The optional `error_ai_recommendations` submodule adds a "Suggest AI Fix" button that posts the failing frame to an AI provider for a suggested fix. It is a developer/debugging aid, not a logging or monitoring backend.

---

- Show a detailed, styled error page instead of Drupal's generic "The website encountered an unexpected error" message during development.
- Give developers the source-code context (±17 lines) around the exact line that threw, inline on the error page.
- Browse a clickable stack trace where each frame shows its own file, line and surrounding code.
- Syntax-highlight the failing code using highlight.js on the error page.
- Inspect the `$_SERVER` values for the failing request in a dedicated Server panel.
- Inspect the request parameters (method and POST body) that led to the error.
- Inspect the cookies present on the failing request.
- Inspect the session contents at the time of the error.
- See the running Drupal core version and PHP version in an App panel.
- Toggle the entire enhanced-error behaviour on or off from `/admin/config/system/error-reporting`.
- Keep the enhanced output enabled on local/dev environments while disabling it on staging and production.
- Restrict who can see enhanced error pages using the "View error reports" permission.
- Preserve Drupal's normal 404 handling when the feature is turned off.
- Return a proper HTTP 500 status with the detailed page for uncaught exceptions.
- Debug fatal/uncaught exceptions that escape the kernel via the module's custom `set_exception_handler`.
- Speed up local debugging by not having to tail logs for a stack trace.
- Pair with the AI submodule to get an AI-suggested code fix for the top stack frame.
- Let a configured AI provider (via the `ai` module) analyse the failing code and error message and return a fix with code snippets.
- Choose which AI provider answers fix requests from the settings form (when the AI submodule is enabled).
- Onboard new developers by making error output readable without extra tooling.
- Diagnose deployment issues on a dev copy by reproducing the failing request and reading the full context.
- Use as a lightweight alternative to installing a full backtrace/devel stack for quick triage.
- Turn off custom reporting before a release so end users only see the generic error message.
