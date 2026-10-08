<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Swiper formatter CKEditor is a submodule of Swiper formatter intended to add a CKEditor 5 tool/button that embeds a Swiper slider into rich-text content; in the 3.0.x release it is a placeholder that ships only an info.yml and README (the CKEditor 5 plugin is not yet implemented).

---

The submodule declares itself as `swiper_formatter_ckeditor` and depends on the parent `swiper_formatter` module. Its stated purpose is to expose Swiper inside CKEditor 5 Drupal rich text as a toolbar button, so an editor could insert a slider directly while writing body text. As shipped in 3.0.x it contains no PHP, no `*.ckeditor5.yml` plugin definition, no JavaScript and no configuration — the parent project's README lists "Finish CKEditor 5 plugin" as an open TODO. Enabling it therefore only registers the module and pulls in the parent; it does not yet add a working CKEditor button or any editor behaviour. It exists so that installs can opt in early and so the plugin has a home once implemented. For actual slider functionality today, use the parent module's field formatters and Views style (see the `swiper_formatter` docs). No permissions, routes, services, schema or hooks are provided by this submodule.

---

- Opt in to the (planned) CKEditor 5 Swiper button by enabling the submodule alongside swiper_formatter.
- Track when Swiper gains an in-editor embed by watching this submodule's implementation status.
- Keep the CKEditor integration as a separate, optional install so sites that only need field/Views sliders are not affected.
- Enable it on a content-authoring site to reserve the editor integration ahead of the plugin landing.
- Depend on it from a distribution/profile that expects a future rich-text Swiper tool.
- Disable/uninstall it cleanly when only the parent formatters are needed.
- Understand that the working slider features live in the parent swiper_formatter module, not here.
- Use the parent module's field formatters instead while the CKEditor plugin is unfinished.
- Serve as the home for the CKEditor 5 plugin code once it is written.
- Model how a Drupal project ships an optional CKEditor-integration submodule as a thin dependency shim.
- Verify on a live site whether the CKEditor integration is enabled by checking module status.
- Add it to a composer/config export so the integration is enabled consistently across environments.
- Pair it with a text format that uses CKEditor 5 in anticipation of the toolbar button.
- Signal intent to editors/stakeholders that rich-text Swiper embedding is on the roadmap.
- Contribute the CKEditor 5 plugin upstream by implementing it inside this submodule.
- Avoid enabling it in production if you want to keep the editor toolbar unchanged for now.
