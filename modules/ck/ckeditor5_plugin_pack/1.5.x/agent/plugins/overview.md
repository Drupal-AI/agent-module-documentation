# Submodules (editor plugins)

Each submodule registers CKEditor 5 plugin(s) via its `*.ckeditor5.yml`. **To use:** enable the
submodule, then at **Admin → Config → Content authoring → Text formats and editors** edit a
format that uses CKEditor 5 and drag the new button into the toolbar (some, like Word Count, are
passive and just appear).

| Submodule | Adds |
|---|---|
| `ckeditor5_plugin_pack_font` | Font Family, Font Size, Font Color & background color. |
| `ckeditor5_plugin_pack_highlight` | Marker/highlight in multiple colors (configurable CSS). |
| `ckeditor5_plugin_pack_find_and_replace` | Find & Replace dialog (also a CKEditor4→5 upgrade path). |
| `ckeditor5_plugin_pack_word_count` | Live word / character count display. |
| `ckeditor5_plugin_pack_text_transformation` | Autocorrect-style text transformations (©, —, smart quotes…). |
| `ckeditor5_plugin_pack_media_embed` | Embed media by URL (oEmbed). |
| `ckeditor5_plugin_pack_emoji` | Emoji picker. |
| `ckeditor5_plugin_pack_bookmark` | Bookmarks / anchors. |
| `ckeditor5_plugin_pack_fullscreen` | Fullscreen editing mode. |
| `ckeditor5_plugin_pack_templates` | Insert reusable content templates. |
| `ckeditor5_plugin_pack_page_break` | Page break element. |
| `ckeditor5_plugin_pack_paste_markdown` | Paste Markdown, convert to rich text. |
| `ckeditor5_plugin_pack_restricted_editing` | Restricted editing regions. |
| `ckeditor5_plugin_pack_select_all` | Select-all command. |
| `ckeditor5_plugin_pack_indent_block` | Indent whole blocks. |
| `ckeditor5_plugin_pack_layout_table` | Layout tables. |
| `ckeditor5_plugin_pack_link_attributes` | Extra link attributes (rel/target/class). |
| `ckeditor5_plugin_pack_html_embed` | Embed raw HTML. |
| `ckeditor5_plugin_pack_todo_document_list` | To-do / checklist lists. |
| `ckeditor5_plugin_pack_auto_image` | Auto-insert image on pasting an image URL. |
| `ckeditor5_plugin_pack_empty_block` | Empty block element. |
| `ckeditor5_plugin_pack_free_wproofreader` | Free WProofreader spell/grammar checker. |

Notable ones documented separately: font, highlight, find_and_replace, word_count,
text_transformation, media_embed. A plugin submodule adds no config schema of its own beyond
the CKEditor plugin settings edited in the toolbar's plugin settings vertical tab.
