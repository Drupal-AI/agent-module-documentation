<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive image class — agent orientation

- Formatter `ResponsiveImageClassFormatter` extends core `ResponsiveImageFormatter`; adds
  settings `image_classes`, `remove_alt`, `focal_point`. In `viewElements()` it merges classes
  via `ClassFormatter::classStringToArray()`, optionally blanks `#item` alt, and sets
  `#item_attributes['data-focal-position']` from `FocalPoint::getFocalPosition()`.
- Services: `responsive_image_class.class_formatter`, and `responsive_image_class.focal_point`
  with `setFocalPointManager('@?focal_point.manager')` (optional dependency).
- `FocalPoint` maps a crop entity's x/y to left/right/top/bottom/center buckets.

Security review (sound): display-only formatter; classes are admin-configured; no routes, no
user-supplied data, no access concern. No finding.
