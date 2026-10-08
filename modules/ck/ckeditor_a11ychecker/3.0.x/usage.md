CKEditor Accessibility Checker adds a toolbar button to CKEditor 5 that inspects the content being edited for accessibility problems and reports them inline, using the bundled Sa11y checking engine.

---

The module is a pure CKEditor 5 plugin integration with no server-side PHP: it registers a CKEditor 5 plugin (`ckeditor_a11ychecker.ckeditor5.yml` → `a11ychecker.A11ychecker`) that provides an "Accessibility Checker" toolbar item. When an editor clicks the button, the front-end plugin runs the bundled **Sa11y** accessibility engine (shipped locally under `sa11y/`, with English language strings) over the editable region and surfaces issues (missing alt text, heading order, contrast, link quality, etc.) directly in the editor. It depends only on the core `ckeditor5` module and loads two asset libraries — `ckeditor_a11ychecker/a11ychecker` (the editor runtime: Sa11y + the compiled plugin) and `ckeditor_a11ychecker/admin.a11ychecker` (admin CSS shown while configuring a text format). There is no settings page (`configure` is null), no permissions, no config schema, and no Drush; you enable it purely by adding its toolbar button to a text format's CKEditor 5 toolbar at `/admin/config/content/formats`. All assets are self-hosted (no CDN).

---

- Give content editors a one-click accessibility check inside the CKEditor 5 editing area.
- Flag images that are missing alternative text before content is published.
- Detect skipped or out-of-order headings (e.g. an `h4` following an `h2`) in body content.
- Warn about low-contrast text that fails WCAG contrast thresholds.
- Catch ambiguous link text such as "click here" or "read more".
- Surface empty links or buttons that have no accessible name.
- Help editors self-serve accessibility fixes without leaving the edit form.
- Add the checker only to the rich-text formats that need it (e.g. Full HTML) via the toolbar config.
- Provide an in-editor complement to page-level accessibility audits.
- Encourage WCAG-conscious authoring across a content team.
- Check accessibility of content in any CKEditor 5-enabled field (body, long-text fields, etc.).
- Run checks fully client-side with the bundled Sa11y engine (no external service or API key).
- Keep accessibility tooling self-hosted for privacy/offline environments (no CDN calls).
- Review heading structure of long-form articles while drafting.
- Identify tables or media lacking accessible metadata during editing.
- Onboard new editors to accessibility basics through immediate inline feedback.
- Reduce post-publish accessibility remediation by catching issues at authoring time.
- Add the accessibility button to a custom text format used by a specific editorial workflow.
