# Configuration

Height Equalizer is configured from one central form. Log in as an administrator
and go to **Configuration → User interface → Height Equalizer**.

## Add the selectors to equalize

1. Open the settings form.
2. **Add a CSS selector** for the elements that should share a common height —
   for example a class applied to your teaser cards or panels (such as
   `.card`). You can manage multiple selectors from the form as separate global
   rules, so different sets of elements can each be equalized independently.
3. **Save configuration.**
4. **Clear caches** (`drush cr`, or **Configuration → Development → Performance →
   Clear all caches**) so the updated behaviour is applied.

Once saved, Height Equalizer automatically applies to matching elements across
the site. Because it watches for layout and content changes with ResizeObserver
and MutationObserver, it re-levels heights when the viewport changes or when
AJAX/dynamic content updates the page — you don't need to reload to keep the
heights in sync.

## Choosing good selectors

- Target the specific elements you want levelled, not their containers — the
  module equalizes the heights of the elements your selector matches.
- Keep selectors reasonably tight so you only affect the intended row or grid;
  an overly broad selector could level elements you didn't mean to.
- The concept was inspired by the
  [Same Height](https://www.drupal.org/project/same_height) module, but here you
  manage everything from this central form and via multiple global rules, rather
  than adding data attributes to individual elements.

## Removing or changing a rule

To stop equalizing a set of elements, remove its selector from the form and save
(then clear caches). To adjust which elements are affected, edit the selector.
Since the module only sizes elements client-side and holds no content or access
role, removing a rule simply returns those elements to their natural heights.
