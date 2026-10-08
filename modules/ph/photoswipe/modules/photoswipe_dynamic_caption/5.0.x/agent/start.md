# photoswipe_dynamic_caption — agent start

Submodule of **photoswipe** (`part_of: photoswipe`). Adds captions inside the PhotoSwipe 5
lightbox via the [photoswipe-dynamic-caption-plugin](https://github.com/dimsemenov/photoswipe-dynamic-caption-plugin).
Depends on `photoswipe:photoswipe`. Needs the caption JS library locally
(`composer require npm-asset/photoswipe-dynamic-caption-plugin:^1.2` into
`/libraries/photoswipe-dynamic-caption-plugin`) or via the main module's CDN option
(a `hook_requirements` check flags a missing library). Config UI:
**Admin → Config → Media → PhotoSwipe Dynamic Caption Settings**
(`/admin/config/media/photoswipe_dynamic_caption`); settings route
`photoswipe_dynamic_caption.settings`.

- Pick the caption source per field + global caption position/layout settings → [configure/photoswipe_dynamic_caption.md](configure/photoswipe_dynamic_caption.md)
