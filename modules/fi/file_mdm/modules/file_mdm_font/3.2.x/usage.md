A file_mdm submodule that adds a `font` FileMetadata plugin, reading metadata (family, style, weight, name-table entries) from TTF/OTF/WOFF font files using the PHP Font Lib (dompdf/php-font-lib).

---

file_mdm_font registers a FileMetadata plugin with id `font` in the File metadata manager framework. Given a font file's URI, you obtain its `FileMetadata` object from the manager and call `getMetadata('font', $key)` to read font attributes. Supported keys include `FontType` and `FontWeight` plus every entry from the OpenType/TrueType `name` table (font family, subfamily, full name, PostScript name, version, copyright, manufacturer, designer, and so on), exposed through php-font-lib's `name` table code map. Parsing copies the file to a local temp path (handled by the base plugin) and loads it via `FontLib\Font::load()`, so remote/stream-wrapped fonts work too. Results are cached like any file_mdm metadata, with global settings or a per-plugin override via the `file_mdm_font.file_metadata_plugin.font` config entity. It is a read-only plugin (fonts are not written back). This is useful for building font-management UIs, validating uploaded fonts, or displaying human-readable font names in a media/asset library.

---

- Read a font's family name (`name` ID 1) from a TTF file.
- Get the font subfamily/style (regular, bold, italic).
- Retrieve the full font name and PostScript name.
- Read the declared `FontWeight` of a font file.
- Determine the `FontType` (TTF/OTF/WOFF).
- Extract copyright and license text embedded in a font.
- Read manufacturer and designer name-table entries.
- Display the font version string.
- Validate that an uploaded font has a required name entry.
- Build a font picker that shows real font names, not filenames.
- Populate a font-management admin list with parsed metadata.
- Cache font metadata to avoid re-parsing on every request.
- Override font-metadata cache settings independently.
- Read metadata from a font stored on a remote stream wrapper.
- Verify a WOFF file's family matches its intended use.
- Group uploaded fonts by family in a media library.
- Surface trademark/unique-id name entries for compliance checks.
- Provide font metadata to a decoupled front end via custom code.
- Detect duplicate fonts by comparing name-table values.
- Show designer/vendor attribution for licensed fonts.
