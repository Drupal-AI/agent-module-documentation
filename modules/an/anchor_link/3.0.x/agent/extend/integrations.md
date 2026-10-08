# Integrations: Linkit + CKEditor 4→5 upgrade

Both are plugin implementations the module ships; you rarely touch them directly.

## Linkit matcher
`src/Plugin/Linkit/Matcher/CKEditorAnchorLinkMatcher.php` — `@Matcher(id = "ckeditor_anchor_link")`.
If the [Linkit](https://www.drupal.org/project/linkit) module is installed, add this matcher
to a Linkit profile (`/admin/config/content/linkit`) so anchor links are recognized/resolved
by Linkit autocomplete. `execute($string)` handles the anchor-style link strings.

## CKEditor 4 → 5 upgrade
`src/Plugin/CKEditor4To5Upgrade/Anchor.php` maps the legacy CKEditor 4 anchor button/config
to the CKEditor 5 equivalent during the core editor upgrade path — no action needed beyond
running the standard text-format upgrade; it keeps existing anchor buttons working.

## Legacy CKEditor 4 plugins
`src/Plugin/CKEditorPlugin/{Anchor,Link,Unlink}.php` are the old CKEditor 4 plugin
definitions, retained for CKEditor 4 compatibility. On CKEditor 5 only the
`anchor_link.ckeditor5.yml` definition is used.
