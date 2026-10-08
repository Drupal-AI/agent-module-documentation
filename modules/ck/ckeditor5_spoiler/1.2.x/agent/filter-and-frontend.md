<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter, libraries, frontend toggle & install hook

## `filter_spoiler` filter (`src/Plugin/Filter/FilterSpoiler.php`)

```php
#[Filter(
  id: 'filter_spoiler',
  title: 'Spoiler support',
  type: FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE,
  description: 'Adds necessary JavaScript and CSS for spoiler functionality on the frontend.',
)]
```

`process($text, $langcode)` returns `new FilterProcessResult($text)` — the text is
returned **unchanged**. Its only effect: if `hasSpoilerMarkup($text)` is true it attaches
the library `ckeditor5_spoiler/spoiler.for.users`.

`hasSpoilerMarkup()` is simply `str_contains($text, 'spoiler')` — a coarse substring
check (any content containing the word "spoiler", even in prose, attaches the CSS/JS).
This is a harmless over-match: at worst it loads a tiny CSS+JS library on a page that has
no spoiler widget. The filter neither adds, strips, nor rewrites any markup, so it does
not alter the format's XSS posture; tag/attribute allow-listing is still done entirely by
the format's other filters (e.g. `filter_html`).

Being `TYPE_TRANSFORM_IRREVERSIBLE` means it must run after "Convert line breaks"/etc. in
the filter order and cannot be used with the "Display any HTML as plain text" flow.

## Libraries (`ckeditor5_spoiler.libraries.yml`)

| library | contents | used for |
|---|---|---|
| `spoiler` | `assets/css/spoiler.css`, `assets/js/build/spoiler.js` (minified) + `assets/js/spoiler.js`; dep `core/ckeditor5` | the CKEditor build + spoiler styles; wired as the plugin's `library` |
| `spoiler.for.users` | `assets/css/spoiler.css`, `assets/js/spoiler.js`; deps `core/drupal`, `core/once` | attached by `filter_spoiler` on rendered pages |
| `admin.spoiler` | `assets/css/spoiler.admin.css` | toolbar-button icon background (`.ckeditor5-toolbar-button-Spoiler`); wired as the plugin's `admin_library` |

## Frontend toggle behavior (`assets/js/spoiler.js`)

```js
Drupal.behaviors.ckeditorSpoiler = {
  attach(context) {
    const spoilerTitles = document.querySelectorAll('div.spoiler-title');
    once('spoiler-title', spoilerTitles, context).forEach((element) => {
      element.addEventListener('click', function () {
        const iconElement = this.querySelector('.show-icon, .hide-icon');
        if (iconElement) { iconElement.classList.toggle('show-icon'); iconElement.classList.toggle('hide-icon'); }
        const nextSibling = this.nextElementSibling;
        if (nextSibling) {
          nextSibling.style.display = nextSibling.style.display === 'none' ? '' : 'none';
        }
      });
    });
  },
};
```

Clicking a `div.spoiler-title` toggles the icon classes and shows/hides its next sibling
(`div.spoiler-content`) by flipping `style.display`. Idempotent via `core/once`
(`data-once="spoiler-title"`). It only reads/writes `classList` and `style.display` — no
`innerHTML`, no user-supplied strings written into the DOM. The module's functional test
confirms the content starts visible (no inline `style`) and gets `display: none` after
the first toggle.

CSS (`assets/css/spoiler.css`) styles the title bar and body; `.spoiler-content.hidden {
display:none }` / `.spoiler-content.show { display:block !important }` support the
in-editor preview; the toggle arrow is an inline `data:image/svg+xml` background (no
external asset fetch).

## Install hook (`ckeditor5_spoiler.install`)

`ckeditor5_spoiler_update_11001()` iterates all `FilterFormat`s; for any whose CKEditor 5
editor toolbar `items` already contain `Spoiler`, it enables `filter_spoiler`
(`status = TRUE`) if not already on. This retro-fits the filter onto formats that had the
button before the filter existed.

## Setup (from README)

1. Enable the module (`drush en ckeditor5_spoiler`).
2. `/admin/config/content/formats` → Configure a format.
3. Drag the **Spoiler** button into the CKEditor 5 active toolbar.
4. Enable the **Spoiler support** (`filter_spoiler`) filter.
5. Save. There is no module-level configuration page.
