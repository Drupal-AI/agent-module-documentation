# ckeditor5_plugin_pack_text_transformation — agent start

Submodule of CKEditor 5 Plugin Pack. Registers the **Text Transformation** CKEditor 5 plugin
(class `src/Plugin/CKEditor5Plugin/TextTransformation`) — autocorrect-style replacements
((c)→©, --→—, smart quotes, fractions…). Passive, no toolbar button. Depends on
`ckeditor5_plugin_pack`.

Enable, then turn it on / pick which transformations apply in the plugin settings for a text
format at **Admin → Config → Content authoring → Text formats and editors**. Config schema
`config/schema/ckeditor5_plugin_pack_text_transformation.schema.yml`. No standalone admin page.
