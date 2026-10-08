Copy Prevention makes copying text and images from your Drupal site harder: it can disable text selection, copy-to-clipboard and the right-click context menu, overlay a transparent GIF on images, and hide images from search-engine image indexes.

---

The module adds a settings form at *Configuration → User interface → Copy Prevention*
(`/admin/config/user-interface/copyprevention`, route `copyprevention.settings_form`, permission
`administer copy prevention`). Everything is off by default. Body-level options
(`copyprevention_body`) add `onselectstart`, `oncopy` and/or `oncontextmenu="return false"`
attributes to the `<body>` tag (via `hook_preprocess_html()`) and bind matching jQuery handlers.
Image options (`copyprevention_images`) can disable the context menu on `<img>` elements and/or
place a transparent GIF overlay above images larger than a configurable minimum dimension
(`copyprevention_images_min_dimension`), so right-click "Save image as" / drag-to-desktop grabs the
blank overlay instead. Search-engine options (`copyprevention_images_search`) can send an
`X-Robots-Tag: noimageindex` HTTP header, add a `noimageindex` robots `<meta>` tag to the page head,
and/or emit image `Disallow` rules into robots.txt (the last requires the RobotsTxt module, via
`hook_robotstxt()`). A `bypass copy prevention` permission exempts trusted roles, and a
`hook_copyprevention_enable_alter()` alter hook lets other modules disable it contextually. These
are client-side deterrents only — none of them actually prevent a determined user (view-source,
devtools, or a direct image URL still work).

---

- Disable right-click context menus across the whole site to deter casual image saving.
- Turn off text selection so visitors cannot easily highlight and copy article text.
- Block copy-to-clipboard (`oncopy`) on all pages.
- Disable the context menu specifically on `<img>` tags while leaving text menus alone.
- Overlay a transparent GIF on top of images so "Save image as" grabs a blank file.
- Only protect images above a minimum size (e.g. ignore small icons under 150px).
- Add a `noimageindex` robots meta tag so search engines skip your images.
- Send an `X-Robots-Tag: noimageindex` HTTP header for image-index suppression.
- Write `Disallow: *.jpg/png/gif` rules into robots.txt (with the RobotsTxt module).
- Exempt admins/editors from copy prevention via the `bypass copy prevention` permission.
- Keep photographers' galleries harder to scrape by combining overlay + noimageindex.
- Deter copy-paste plagiarism of premium article content.
- Protect stock-image previews on a listing page from quick downloads.
- Discourage right-click "inspect"/"save" on a portfolio site.
- Apply a site-wide deterrent without editing templates or writing JS.
- Programmatically disable copy prevention on certain routes via the alter hook.
- Combine header + meta-tag options for redundant image-noindex signals.
- Hide product imagery from Google Images while keeping pages indexed.
- Raise the friction of casual content theft on a membership site.
- Toggle protections per environment by exporting/overriding `copyprevention.settings`.
- Keep a transparent-overlay deterrent only on large hero images.
- Provide a lightweight, dependency-free copy deterrent (only robots.txt option needs a module).
- Reduce accidental drag-and-drop of images to the desktop by editors' audiences.
