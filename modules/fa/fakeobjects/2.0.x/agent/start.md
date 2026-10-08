# fakeobjects — agent start

Registers the CKEditor **4** "fakeobjects" utility plugin with Drupal so other CKEditor
plugins that depend on it can load. No toolbar button, no config, no permissions. Requires
the JS library at `/libraries/fakeobjects/plugin.js` (download `>= 4.5.11` from ckeditor.com);
on Drupal 10/11 also needs the contributed `drupal/ckeditor` module. `package: CKEditor`;
core `^8 || ^9 || ^10 || ^11`.

- How the plugin is registered, where the JS goes, and the requirements check → [api/fakeobjects.md](api/fakeobjects.md)
