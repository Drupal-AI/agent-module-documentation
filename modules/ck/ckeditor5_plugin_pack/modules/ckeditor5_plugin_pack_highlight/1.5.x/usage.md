Adds the CKEditor 5 Highlight plugin, letting editors mark text with configurable marker colors in the rich text editor.

---

This submodule of CKEditor 5 Plugin Pack registers the Highlight editor plugin (class `Plugin/CKEditor5Plugin/Highlight`), which adds a marker/highlighter button to the CKEditor 5 toolbar. Editors select text and apply one of several highlight colors (like a physical highlighter). The set of available colors is configurable, and the module generates the matching CSS so highlights render the same on the front end (`Service/HighlightCssFileCreator` writes the stylesheet). Enable the submodule, then add the Highlight button to a text format toolbar at Admin → Configuration → Content authoring → Text formats and editors and choose the colors in the plugin settings. It depends on the base `ckeditor5_plugin_pack` module and ships its own config schema, icon and CSS.

---

- Highlight important sentences with a yellow marker.
- Offer multiple highlight colors (yellow, green, pink, blue).
- Draw attention to key terms in documentation.
- Mark up draft content for reviewers.
- Emphasize deadlines or warnings in body text.
- Highlight quoted passages differently from surrounding text.
- Configure the exact set of highlight colors allowed.
- Ensure highlights render identically on the published page via generated CSS.
- Provide a pen/marker style option beyond plain background color.
- Remove a highlight from previously marked text.
- Highlight table cell contents.
- Mark corrections in editorial workflows.
- Color-code categories of information inline.
- Restrict highlight colors to a brand palette.
- Help low-vision users spot key content with strong markers.
- Standardize highlighting across content types.
- Add the highlight button only to formats that need it.
- Combine with font color for richer inline emphasis.
- Highlight callouts in knowledge-base articles.
- Let authors self-annotate long-form content.
