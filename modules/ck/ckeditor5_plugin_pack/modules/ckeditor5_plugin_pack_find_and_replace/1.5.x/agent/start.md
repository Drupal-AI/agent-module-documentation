# ckeditor5_plugin_pack_find_and_replace — agent start

Submodule of CKEditor 5 Plugin Pack. Registers the **Find and Replace** CKEditor 5 plugin
(class `src/Plugin/CKEditor5Plugin/FindAndReplace`) plus a CKEditor4→5 upgrade plugin
(`src/Plugin/CKEditor4To5Upgrade/Find`). Depends on `ckeditor5_plugin_pack`.

Enable, then add the Find and Replace button to a text format toolbar at **Admin → Config →
Content authoring → Text formats and editors**. Config schema
`config/schema/ckeditor5_plugin_pack_find_and_replace.schema.yml`. No standalone admin page.
