<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive Image formatter link to image style — agent orientation

- Formatter `ResponsiveImageFormatterLinkToImageStyleFormatter` extends `ImageFormatterBase`.
  Settings: responsive_image_style, image_link_style, image_link_class, image_link_rel,
  image_link_image_class. `viewElements()` builds the responsive image vars, computes the link
  URL from the chosen `ImageStyle::buildUrl()` (or original), and themes via
  `responsive_image_formatter_link_to_image_style_formatter`.
- Preprocess in `.field.inc` builds the `responsive_image` render array + link attributes.

Security review (sound): display-only formatter, admin-configured settings, uses
`file_url_generator` and image-style derivatives. No routes/user input/access concern. No
finding.
