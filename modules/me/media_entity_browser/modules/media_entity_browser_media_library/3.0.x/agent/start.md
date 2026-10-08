# media_entity_browser_media_library — agent start

Optional submodule of `media_entity_browser`. Adds one more Entity Browser whose UX mirrors
core Media Library, for WYSIWYG embedding. Config-only; also depends on core `media_library`.
Wire it into an Entity Embed button at `/admin/config/content/entity_browser`. For reference
fields, prefer core's Media Library widget. Expected to be deprecated once core supports
WYSIWYG media embedding natively.

- Config it installs + preprocess/form-alter behavior → [configure/browser.md](configure/browser.md)
