<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform widget handler provides a field widget whose Webform can be altered by handlers.

---

**Webform widget handler** adds a Field API widget (a select widget) that embeds a Webform and lets Webform handler plugins modify the widget at render/submit time. It ships an example submodule (`webform_widget_handler_example`) demonstrating a handler that manipulates the widget. Requires the `webform` module. It provides no routes or permissions of its own — it is a building block for developers.

Use it when you need a form widget whose behaviour is driven by Webform handler logic rather than static field settings.

---

- Provide a Webform-backed field widget.
- Let Webform handlers modify a field widget.
- Embed a select widget driven by handler logic.
- Ship an example handler submodule.
- Demonstrate widget manipulation from a handler.
- Build custom form widgets without new field types.
- Alter widget options via handler code.
- Integrate Field API widgets with Webform handlers.
- Depend on the Webform module.
- Serve as a developer building block.
- Enable the example module to learn the pattern.
- Modify widget behaviour at render time.
- Modify widget behaviour at submit time.
- Avoid hardcoding widget configuration.
- Reuse Webform handler plugins for widgets.
- Extend forms with dynamic widgets.
- Keep widget logic in handler plugins.
- Provide a reusable SelectWidget plugin.