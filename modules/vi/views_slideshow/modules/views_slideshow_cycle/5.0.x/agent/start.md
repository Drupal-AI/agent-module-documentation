# views_slideshow_cycle — agent start

The reference **engine** for Views Slideshow. Provides the `views_slideshow_cycle` slideshow
type (jQuery Cycle) that animates the slides. Enable it alongside `views_slideshow` (its only
dependency, `views_slideshow:views_slideshow`). No config of its own — its options live inside
the host View's Slideshow style, and it needs external JS libraries under `/libraries`.
Package: Views. Part of the `views_slideshow` project.

- Select Cycle as the engine + its transition/action options (per display) → [configure/views_slideshow_cycle.md](configure/views_slideshow_cycle.md)
- Install the required jQuery libraries via Drush → [drush/views_slideshow_cycle.md](drush/views_slideshow_cycle.md)
