Assist For WCAG embeds a hosted, token-authenticated accessibility widget by injecting a remote script from dockaccess.org into every non-admin page.

---

Assist For WCAG is a minimal glue module: an administrator stores a single token on a settings form, and the module then adds a `<script src="https://dockaccess.org/accessibility/<token>/start.js" defer>` tag to the HTML head of all front-end (non-admin) pages via `hook_page_attachments()`. The remote widget renders a visitor-facing accessibility overlay/toolbar offering controls such as color inversion, contrast enhancement, font-size adjustment, and preset accessibility profiles (e.g. dyslexia, ADHD, low vision). Because the widget is loaded remotely, it updates on its own without a new module release. The module provides only a settings route (gated by `administer site configuration`), a menu link, and an admin CSS library — no plugins, services, entities, permissions, or config schema. It targets Drupal 10/11/12 on PHP 8.1+ and requires a valid token plus outbound HTTPS access to dockaccess.org. The widget is a third-party overlay, so its privacy handling and real-world accessibility effectiveness are outside the module's control.

---

- Add a hosted accessibility widget to a site without writing custom code.
- Store the dockaccess.org account token via an admin settings form.
- Inject the remote `start.js` accessibility script into front-end pages automatically.
- Keep the widget off admin routes (it only attaches on non-admin pages).
- Let visitors invert colors or enhance contrast through the remote widget.
- Let visitors increase or decrease font size for readability.
- Offer preset accessibility profiles (dyslexia, ADHD, low vision, etc.).
- Get automatic widget updates without a module release.
- Provide a lightweight path toward WCAG 2.1/2.2 conformance goals.
- Configure the whole feature with a single token value.
- Turn the widget on or off by setting or clearing the token.
- Enable an accessibility toolbar across an entire public site quickly.
- Support multilingual/multi-theme sites (the widget is theme-agnostic front-end JS).
- Provide assistive features to users who rely on browser-level accommodations.
- Add an a11y overlay to a marketing or campaign site with minimal effort.
- Meet a procurement or compliance checklist item requiring an accessibility widget.
- Centralize widget management in Drupal config rather than editing theme templates.
- Deploy the token across environments through configuration management.
- Remove the widget cleanly by uninstalling the module (no residual markup).
- Combine with audit-oriented accessibility modules for a broader a11y strategy.
