CKEditor5 Open New Tab adds an "Open in new window" option to CKEditor 5's link dialog, letting editors mark a link to open in a new browser tab (`target="_blank"`).

---

The module is a tiny CKEditor 5 integration with no configuration of its own. Via
`hook_ckeditor5_plugin_info_alter()` (in `ckeditor5_open_new_tab.module`) it swaps the class of core's
`ckeditor5_link` plugin definition to `Drupal\ckeditor5_open_new_tab\Plugin\CKEditor5Plugin\CKEditor5Link`.
That subclass overrides `getDynamicPluginConfig()` to append a CKEditor 5 **manual link decorator**
(`{ mode: 'manual', label: 'Open in new window', attributes: { target: '_blank' } }`) to the editor's
`link` configuration. The result is a checkbox in the link balloon that, when ticked, writes
`target="_blank"` onto the anchor. There is no settings form, no permission, no schema, and no submodule;
enabling the module on any text format that already uses the core Link (`ckeditor5_link`) plugin is all
that is needed. Note that whether the `target` attribute survives filtering depends on the text format's
allowed-HTML configuration.

---

- Let editors choose to open a specific link in a new tab from the CKEditor 5 link dialog.
- Add `target="_blank"` to outbound links (e.g. to external sites) without editing HTML source.
- Provide a per-link "Open in new window" checkbox instead of forcing all links to a target.
- Standardize new-tab behavior for links across content authored in CKEditor 5.
- Give content editors control over external-link targeting in body/rich-text fields.
- Enable new-tab links on selected text formats only (by enabling the module + core Link plugin there).
- Mark download/document links to open separately from the current page.
- Improve editor UX for linking to third-party tools that should not replace the current page.
- Keep new-tab configuration in the WYSIWYG rather than requiring a custom CKEditor build.
- Complement accessibility/security practices by combining with `rel="noopener"` handling from other modules or format filters.
- Link to external partner or reference sites that should stay open alongside your content.
- Open large media or PDF links in a new tab so readers do not lose their place.
- Let authors opt a specific call-to-action link into a new tab while keeping internal links in-page.
- Support editorial guidelines that require external links to open separately.
- Add new-tab links inside long-form articles without touching the HTML source view.
- Configure the behavior consistently for multiple content editors on shared text formats.
- Provide the same "open in new window" affordance editors expect from other CMSs.
- Toggle new-tab on or off per link when re-editing existing content.
