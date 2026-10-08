Mautic Paragraph lets editors embed a Mautic marketing-automation form into content by picking it from a live list of forms pulled from a configured Mautic instance.

---

Mautic Paragraph connects a Drupal site to a Mautic (open-source marketing automation) server and exposes Mautic forms as reusable content. On install (once the Paragraphs module is present) it provides a **Mautic** paragraph type and a **Mautic** custom-block type, each carrying a title field, a rich-text field, and a "Form" field whose allowed values are fetched from Mautic. A site administrator configures the connection once at `/admin/config/services/mautic`, choosing a connector plugin (HTTP Basic Auth or OAuth2 two-legged) and entering the Mautic base URL plus credentials; the module talks to Mautic through the `mautic/api-library` PHP client. When the paragraph or block is rendered, a field formatter emits a single `<script>` tag pointing at the Mautic instance's `form/generate.js` endpoint for the selected form id, so the real Mautic form is injected client-side. The form list is cached for a configurable period and editors can pick a form either from a select list or from an autocomplete widget.

---

- Embed a Mautic newsletter signup form inside a landing page via a Paragraph.
- Add a Mautic lead-capture form to any content type that uses Paragraphs.
- Place a Mautic form in a region using the provided "Mautic" custom block type.
- Let content editors choose which Mautic form to show without touching code or knowing form ids.
- Give editors an autocomplete field that searches Mautic forms by name.
- Present editors a simple select list of all available Mautic forms instead of autocomplete.
- Add an optional heading and intro text above an embedded Mautic form.
- Reuse the same Mautic instance across many pages, forms and campaigns.
- Connect to a Mautic server protected by HTTP Basic authentication.
- Connect to a Mautic server using OAuth2 (two-legged / client-credentials) API credentials.
- Point the integration at a Mautic install on a custom port or subpath.
- Cache the list of Mautic forms for a chosen interval to reduce API calls.
- Disable caching so newly created Mautic forms appear immediately in the picker.
- Limit how many forms are retrieved from the Mautic API per request.
- Verify connectivity to Mautic from the settings form's status indicator.
- Apply a layout/style class to a Mautic paragraph (full width vs. image-left/right) for theming.
- Collect campaign leads on a Drupal editorial site while keeping automation logic in Mautic.
- Roll out consistent, centrally-managed marketing forms across a multi-page site.
- Swap the embedded form on a page simply by changing the selected Mautic form.
- Restrict who may configure the integration with the dedicated administration permission.
- Extend the module with a custom connector plugin for other Mautic authentication schemes.
