Appends the extension and human-readable size (and a MIME-type icon class) to links that point at local managed files, via a text-format filter and a `file_link` theme override.

---

Append File Info decorates links to **local managed files** with their file extension and byte size so visitors see, for example, "Annual report (PDF, 1.2 MB)" instead of a bare link. It ships two independent mechanisms that share one `FileInfoFormatter` service. The **"Append File Info Filter"** (`append_file_info_filter`) is a text-format filter that scans rendered HTML for `<a>` links, resolves each href to a `file` entity (by public/private stream path, or a `file/{fid}` route), and appends the info plus a mime-icon wrapper span. The **theme override** replaces core's `template_preprocess_file_link` preprocessor so that file fields themed as `file_link` get the same extra text and icon classes without editing a text format. A single site-wide setting (`display`) chooses whether to show the extension, the size, or both; the filter carries its own per-format copy of that setting. Only local files (stream wrappers extending `LocalStream`) are decorated; remote/external files are skipped. Configuration lives at `/admin/config/content/append-file-info` and requires the `administer site configuration` permission.

---

- Show "(PDF, 2.4 MB)" after download links in body text so users know the format and weight before clicking.
- Enable the "Append File Info Filter" on your Full HTML or Basic HTML text format to decorate authored links automatically.
- Append file info to Drupal core file links like `sites/default/files/report.pdf`.
- Append file info to File Entity links of the form `file/3`.
- Append file info to Media links of the form `media/3` when they resolve to a managed file path.
- Decorate file-field output rendered with core's *Generic file* / `file_link` formatter through the theme override, no filter needed.
- Display only the file **extension** (e.g. "(PDF)") by setting the display mode to *Extension only*.
- Display only the **file size** (e.g. "(2.4 MB)") by setting the display mode to *File size only*.
- Add a MIME-type icon to file links via the `file--mime-*` CSS classes the module sets on a wrapper span.
- Correctly label multi-part archive extensions such as `TAR.GZ` and `TAR.BZ2`.
- Keep image links untouched — the filter skips any `<a>` that wraps an `<img>`.
- Opt a specific link out of decoration by giving it a `no-file-info` class.
- Present accessible, self-describing download lists on document/library pages.
- Improve microformat markup on file links (the theme override sets a `type="mime; length="` attribute per http://microformats.org/wiki/file-format-examples).
- Localize gracefully: the filter strips a language-prefix from paths before resolving the file in multilingual sites.
- Ensure filtered output re-renders when a file changes, thanks to per-file cache tags added by the filter.
- Configure the behavior once site-wide, then reuse it across every text format and file field.
- Provide consistent "format + size" hints across body content and file fields on the same site.
- Help editors avoid manually typing "(PDF, 2 MB)" into link text.
- Support both public and private local files in the resolution logic.
